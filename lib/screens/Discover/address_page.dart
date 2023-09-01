
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snack_bar/data/controllers/auth_ctlr.dart';
import 'package:snack_bar/data/controllers/location_controller.dart';
import 'package:snack_bar/data/controllers/user_controller.dart';
import 'package:snack_bar/models/address_models.dart';
import 'package:snack_bar/screens/Discover/pick_address_map.dart';
import '../../helpers/router.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonPhone = TextEditingController();
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(6.508835, 3.313712),
  zoom: 17
  );
  late LatLng _initialPosition = const LatLng(6.508835, 3.313712);
  late bool _isLogged;

  @override
  void initState(){
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().userInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(
          Get.find<LocationController>().addressList.last
        );
      }
      Get.find<LocationController>().getUserAddress();

      _cameraPosition = CameraPosition(target: LatLng(
      double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      ));

      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Pick Address'),
        backgroundColor: Colors.orangeAccent,
      ),
      body:
        GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
          _contactPersonName.text = userController.userModel.name;
          _contactPersonPhone.text = userController.userModel.phone;
          if(Get.find<LocationController>().addressList.isNotEmpty){
            _addressController.text = Get.find<LocationController>().getUserAddress()
                .address;
          }
        }
         return
         GetBuilder<LocationController>(builder: (locationController){
          _addressController.text = "${locationController.placemark.name??''}"
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print('address in my view is'+_addressController.text);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height*0.2,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 1.5, color: Colors.orange.shade300
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition:
                        CameraPosition(target: _initialPosition,
                            zoom: 17),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position)=>_cameraPosition=position),
                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                          if(Get.find<LocationController>().addressList.isEmpty){
                            // locationController.getCurrentLocation(true, mapController: controller);
                          }
                        },
                        onTap: (latLng){
                          Get.toNamed(
                            RouteHelper.getPickAddressMap(),
                            arguments: PickAddressMap(
                              fromSignUp: false, fromAddress: true,
                              googleMapController: locationController.mapController
                            )
                          );
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: SizedBox(
                    height: size.height*0.05,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          locationController.setAddressTypeIndex(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1, blurRadius: 5
                              ),
                            ]
                          ),
                          child: Icon(
                            index==0?Icons.home_filled:index==1?Icons.work:
                            Icons.location_on,
                            color: locationController.addressTypeIndex==index?
                            Colors.orangeAccent:Theme.of(context).disabledColor,
                            size: 24,
                          )
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.04,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Delivery Address', style: TextStyle(
                      fontSize: 17, color: Colors.black87
                  )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white.withOpacity(0.75),
                    ),
                    child: TextField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your address",
                        hintStyle: TextStyle(
                            color: Colors.black87, fontSize: 17
                        ),
                        prefixIcon: Icon(Icons.location_city_rounded,
                          size: 24, color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.03,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Contact Name', style: TextStyle(
                      fontSize: 17, color: Colors.black87
                  )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white.withOpacity(0.75),
                    ),
                    child: TextField(
                      controller: _contactPersonName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your name",
                        hintStyle: TextStyle(
                            color: Colors.black87, fontSize: 17
                        ),
                        prefixIcon: Icon(Icons.person,
                          size: 24, color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Contact Phone Number', style: TextStyle(
                      fontSize: 17, color: Colors.black87
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white.withOpacity(0.75),
                    ),
                    child: TextField(
                      controller: _contactPersonPhone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your phone number",
                        hintStyle: TextStyle(
                            color: Colors.black87, fontSize: 17
                        ),
                        prefixIcon: Icon(Icons.phone,
                          size: 24, color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        })
        ;
      },),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: size.height * 0.13,
              padding: EdgeInsets.only( left: size.width * 0.1,
                  right: size.width * 0.1),
              child:
                  GestureDetector(
                    onTap: (){
                      AddressModels _addressModel = AddressModels(
                          addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                      contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonPhone.text,
                        address: _addressController.text,
                        latitude:locationController.position.latitude.toString(),
                        longitude: locationController.position.longitude.toString()
                      );
                      locationController.addAddress(_addressModel).then((status){
                        if(status.isSuccess){
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar('Address', 'Address added successfully');
                        } else{
                          Get.snackbar('Address', 'Couldn\'t save address');
                        }
                      });
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only( bottom: 15,
                            top: 15,
                            left: size.width*0.05, right: size.width*0.05),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Text(
                            'Save Address',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,
                          color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  )
            ),
          ],
        );
      },
      ),
    );
  }
}
