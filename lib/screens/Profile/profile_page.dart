
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_bar/data/controllers/location_controller.dart';
import 'package:snack_bar/data/controllers/user_controller.dart';
import 'package:snack_bar/helpers/custom_loader.dart';
import 'package:snack_bar/helpers/profile_tile.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:snack_bar/helpers/router.dart';

import '../../data/controllers/auth_ctlr.dart';
import '../../data/controllers/cart_contoller.dart';
import '../Customer_Service_Chat/chat_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? image;

  final ImagePicker _picker = ImagePicker();

  String? _imagePath;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().userInfo();
      print('User has logged in');
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title:  const Center(
          child: Text('Profile',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
      body:
      GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn ?
        ( userController.isLoading ?
        Padding(padding: EdgeInsets.symmetric(
            horizontal: size.width*0.07
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height*0.08,),
              GestureDetector(
                  onTap: () async {
                    image = await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      image = image;
                    });
                    _saveImage(image!.path);
                  },
                  child: _imagePath!= null?CircleAvatar(
                    backgroundImage: FileImage(File(_imagePath!)),
                    radius: 50,
                  )
                      : CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50,
                    backgroundImage: _getImage(),
                  )
              ),
              SizedBox(height: size.height*0.045,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileTile(
                          text: userController.userModel.name,
                          tileIcon: Entypo.user),
                      SizedBox(height: size.height*0.015,),
                      ProfileTile(
                          text: userController.userModel.phone,
                          tileIcon: Entypo.phone),
                      SizedBox(height: size.height*0.015,),
                      ProfileTile(
                          text: userController.userModel.email,
                          tileIcon: Entypo.mail),
                      SizedBox(height: size.height*0.015,),
                      GetBuilder<LocationController>(builder: (locationController){
                        if(_userLoggedIn&&locationController.addressList.isEmpty){
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: const ProfileTile(
                                text: 'Fill in your address',
                                tileIcon: Entypo.location),
                          );
                        } else{
                          return GestureDetector(
                            onTap: (){
                              Get.offNamed(RouteHelper.getAddressPage());
                            },
                            child: const ProfileTile(
                                text: 'Your address',
                                tileIcon: Entypo.location),
                          );
                        }
                      }),
                      SizedBox(height: size.height*0.015,),
                      GestureDetector(
                        onTap: (){
                          Get.to(const ChatPage());
                        },
                        child: const ProfileTile(
                            text: 'Customer Service',
                            tileIcon: Entypo.chat),
                      ),
                      SizedBox(height: size.height*0.015,),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearedSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<LocationController>().clearAddressList();
                            Get.offNamed(RouteHelper.getLogInPage());
                          } else {
                            print('You clicked log out');
                          }
                        },
                        child: SizedBox(
                          height: size.height*0.085,
                          width: double.infinity,
                          child: Card(
                            elevation: 0.5,
                            color: const Color(0xFFFFFFFF),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Entypo.logout, color: Colors.redAccent.shade200, size: 25,),
                                  const SizedBox(width: 23,),
                                  Text('Logout',
                                    style: TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.w400, color: Colors.redAccent.shade200),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),)
        : const CustomLoader()
        ) : Center(child: Container(child: Text('You must log in'),),);
      })
    );
  }

  ImageProvider _getImage() {
    final image = this.image;
    if (image != null) {
      return FileImage(File(image.path));
    }
    return const AssetImage('assets/images/profile.png');
  }

  void _saveImage (path) async{
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString('imagePath', path);
  }

  void loadImage() async{
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState((){
      _imagePath = saveImage.getString('imagePath');
    });
  }
}
