
import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snack_bar/data/repository/location_repo.dart';
import 'package:snack_bar/models/auth_models/response_model.dart';
import 'package:snack_bar/screens/Discover/address_page.dart';
import '../../models/address_models.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;
  List<AddressModels> _addressList = [];
  List<AddressModels> get addressList => _addressList;
  late List<AddressModels> _allAddressList;
  List<AddressModels> get allAddressList => _allAddressList;
  final List<String> _addressTypeList =['home', 'office', 'others'];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  bool _updateAddressData = true;
  final bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  //for service zone
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  //whether the user is in service zone or not
  bool _inZone = false;
  bool get inZone => _inZone;

  //showing and hiding button as map loads
  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  void setMapController(GoogleMapController mapController){
    _mapController=mapController;
  }
  void updatePosition(CameraPosition position, bool fromAddressPage) async {
    if(_updateAddressData){
      _loading=true;
      update();
      try{
        if(fromAddressPage){
          _position = Position(longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }else{
          _pickPosition = Position(longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }

        ResponseModel _responseModel = await getZone(
        position.target.latitude.toString(),
            position.target.latitude.toString(), false);
        //if button is false, we are in service area
        _buttonDisabled=!_responseModel.isSuccess;

        if(_changeAddress){
          String _address = await getAddressFromGeocode(
            LatLng(
              position.target.latitude,
              position.target.longitude
            )
          );
          fromAddressPage?_placemark=Placemark(name: _address)
          : _pickPlacemark=Placemark(name: _address);
        }
      }
      catch(e){
        print(e);
      }
      _loading=false;
      update();
    }else{
      _updateAddressData = true;
    }
  }

  //address gotten or updated from geocode
  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = 'Unknown Location Found';
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    if(response.body["status"]=='OK'){
      _address = response.body["results"][0]['formatted_address'].toString();
      print('printing address'+_address);
    }else{
      print('Error getting the google api');
    }
    update();
    return _address;
  }

  Future<ResponseModel> addAddress(AddressModels addressModels) async{
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModels);
    ResponseModel responseModel;
    if(response.statusCode==200){
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModels);
    }else{
      print('Couldn\'t save user address'+response.statusText!);
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async{
    Response response = await locationRepo.getAllAddressList();
    if(response.statusCode==200){
      _addressList=[];
      _allAddressList=[];
      response.body.forEach((address){
        _addressList.add(AddressModels.fromJson(address));
        _allAddressList.add(AddressModels.fromJson(address));
      });
      print('....added.....'+_addressList.toString());
    }else{
      _addressList=[];
      _allAddressList=[];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModels addressModels) async{
    String userAddress = jsonEncode(addressModels.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress=>_getAddress;
  AddressModels getUserAddress(){
    late AddressModels _addressModels;
    //convert to map using jsonDecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try{
      _addressModels = AddressModels.fromJson(jsonDecode(locationRepo.getUserAddress()));
    }catch(e){
      print(e);
    }
    return _addressModels;
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async{
   late ResponseModel _responseModel;
   if(markerLoad){
     _loading=true;
   }else{
     _loading=true;
   }
   update();
   Response response = await locationRepo.getZone(lat, lng);
   if(response.statusCode==200){
     _inZone=true;
     _responseModel = ResponseModel(true, response.body['zone_id'].toString());
   }else{
     _inZone=false;
     _responseModel = ResponseModel(true, response.statusText!);
   }
     if(markerLoad){
       _loading=false;
     }else{
       _loading=false;
     }
   update();
   return _responseModel;
  }

  String getUserAddressFromLocalStorage(){
    return locationRepo.getUserAddress();
  }

  void setAddressTypeIndex(int index){
    _addressTypeIndex=index;
    update();
  }

  void setAddressData(){
    _position=_pickPosition;
    _placemark=_pickPlacemark;
    _updateAddressData = false;
    update();
  }

  void clearAddressList(){
    _addressList=[];
    _allAddressList=[];
    update();
  }
}