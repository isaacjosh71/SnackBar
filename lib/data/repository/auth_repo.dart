
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_bar/helpers/app_const.dart';
import '../../models/auth_models/login_body.dart';
import '../../models/auth_models/signup_body.dart';
import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient, required this.sharedPreferences
  });

  Future<Response>signUpUser(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.SIGNUP_URI, signUpBody.toJson());
  }

  Future<Response>loginUser(LogInBody logInBody) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, logInBody.toJson());
  }

  getUserToken() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.TOKEN)??"None";
    print('getUserToken: $token');
  }

  bool userLoggedIn (){
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  saveUserToken(dynamic token) async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.TOKEN, token);
    print('save userToken: $token');
  }

  Future<void> savePhoneNumberAndPassword(String number, String password)async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  bool clearedSharedData (){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token="";
    apiClient.updateHeader("");
    return true;
  }
}