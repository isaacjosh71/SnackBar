
import 'package:get/get.dart';
import 'package:snack_bar/helpers/app_const.dart';

class ApiClient extends GetConnect implements GetxService{

  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      // 'Accept': 'application/json',
    };
  }

  //update token from dormant as user signs in
  void updateHeader(String token){
    _mainHeaders={
      // 'Accept': 'application/json',
      'Content-type':'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri) async{
    try{
      Response response = await get(uri);
      return response;
    }catch(e){
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<Response> postData (String uri, dynamic body) async {
    print(body.toString());
    try{
      Response response = await post(uri, body, headers: _mainHeaders);
      print(response.toString());
      return response;
    }catch(e){
      print(e.toString());
      return Response(
          statusCode: 1,
          statusText: e.toString());
    }
  }
}