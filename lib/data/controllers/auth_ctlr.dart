
import 'package:get/get.dart';
import 'package:snack_bar/models/auth_models/login_body.dart';
import '../../models/auth_models/response_model.dart';
import '../../models/auth_models/signup_body.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading  => _isLoading;

  Future<ResponseModel> signUpUser(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.signUpUser(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200 || response.statusCode == 201){
      authRepo.saveUserToken(response.body['token']);
      print('My token is${response.body['token'].toString()}');
      responseModel = ResponseModel(true, response.body['token']);
    }else{responseModel = ResponseModel(false, response.statusText!);}
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> loginUser(LogInBody logInBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.loginUser(logInBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200 || response.statusCode == 201){
      authRepo.saveUserToken(response.body['token']);
      print('User token ${response.body['token'].toString()}');
      print("getting token ${authRepo.getUserToken().toString()}");
      responseModel = ResponseModel(true, response.body['token']);
    }else{responseModel = ResponseModel(false, response.statusText!);}
    _isLoading = false;
    update();
    return responseModel;
  }

  void savePhoneNumberAndPassword(String number, String password) {
    authRepo.savePhoneNumberAndPassword(number, password);
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }

  bool clearedSharedData(){
    return authRepo.clearedSharedData();
  }
}