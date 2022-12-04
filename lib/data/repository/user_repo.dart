
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/data/api/api_client.dart';
import 'package:snack_bar/helpers/app_const.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async{
   return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}