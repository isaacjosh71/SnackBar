
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_bar/data/controllers/auth_ctlr.dart';
import 'package:snack_bar/data/controllers/user_controller.dart';
import 'package:snack_bar/helpers/custom_loader.dart';
import 'package:snack_bar/helpers/profile_tile.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:snack_bar/helpers/router.dart';

import '../../data/controllers/cart_contoller.dart';

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
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().userModel;
      print('user has logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title:  Text('Profile',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
      body: GetBuilder<UserController>(builder: (userInfo){
        return
          userInfo.isLoading?
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
                          text: userInfo.userModel!.name,
                          tileIcon: Entypo.user),
                      SizedBox(height: size.height*0.015,),
                      ProfileTile(
                          text: userInfo.userModel!.phone,
                          tileIcon: Entypo.phone),
                      SizedBox(height: size.height*0.015,),
                      ProfileTile(
                          text: userInfo.userModel!.email,
                          tileIcon: Entypo.mail),
                      SizedBox(height: size.height*0.015,),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getAddressPage());
                        },
                        child: const ProfileTile(
                            text: 'Get Address',
                            tileIcon: Entypo.location),
                      ),
                      SizedBox(height: size.height*0.015,),
                      const ProfileTile(
                          text: 'Customer Service',
                          tileIcon: Entypo.chat),
                      SizedBox(height: size.height*0.015,),
                      SizedBox(
                        height: size.height*0.085,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: (){
                            Get.find<AuthController>().clearedSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.offNamed(RouteHelper.getLogInPage());
                          },
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
          ),
        ) : const CustomLoader();
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
