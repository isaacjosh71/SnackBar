
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:snack_bar/helpers/app_const.dart';
import 'package:snack_bar/models/address_models.dart';
import '../api/api_client.dart';

class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.sharedPreferences, required this.apiClient});

  //get address from Geocode
  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
    '?lat=${latLng.latitude}&lng=${latLng.longitude}'
    );
  }

  //send address to server
  Future<Response> addAddress(AddressModels addressModels) async{
    return await apiClient.postData(AppConstants.ADD_USER_ADDRESS, addressModels.toJson());
  }

  Future<Response> getAllAddressList() async{
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  //get service zone from server
  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  //save user address to server
  Future<bool> saveUserAddress(String address) async{
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  //get saved user address
  String getUserAddress(){
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??'';
  }
}