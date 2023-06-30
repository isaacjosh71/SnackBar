
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_bar/helpers/profile_tile.dart';
import 'package:fluttericon/entypo_icons.dart';

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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title:  const Center(
          child: Text('Profile',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
      body: Padding(padding: EdgeInsets.symmetric(
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
                 const ProfileTile(
                     text: 'User',
                     tileIcon: Entypo.user),
                  SizedBox(height: size.height*0.015,),
                 const ProfileTile(
                     text: 'Phone',
                     tileIcon: Entypo.phone),
                  SizedBox(height: size.height*0.015,),
                  const ProfileTile(
                     text: 'Email',
                     tileIcon: Entypo.mail),
                  SizedBox(height: size.height*0.015,),
                  const ProfileTile(
                     text: 'Address',
                     tileIcon: Entypo.location),
                  SizedBox(height: size.height*0.015,),
                 const ProfileTile(
                     text: 'Customer Service',
                     tileIcon: Entypo.chat),
                  SizedBox(height: size.height*0.015,),
                  SizedBox(
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
                         SizedBox(width: 23,),
                         Text('Logout',
                           style: TextStyle(fontSize: 18,
                               fontWeight: FontWeight.w400, color: Colors.redAccent.shade200),)
                       ],
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
      )
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
