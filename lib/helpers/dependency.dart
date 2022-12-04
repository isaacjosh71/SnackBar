
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_bar/data/api/api_client.dart';
import 'package:snack_bar/data/controllers/auth_ctlr.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';
import 'package:snack_bar/data/controllers/most_popular_ctlr.dart';
import 'package:snack_bar/data/repository/cart_repo.dart';
import 'package:snack_bar/data/repository/most_popular_repo.dart';
import 'package:snack_bar/helpers/app_const.dart';
import '../data/controllers/recommended_ctlr.dart';
import '../data/controllers/user_controller.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/recommended_repo.dart';
import '../data/repository/user_repo.dart';

Future<void> init() async{
  //shared preferences init
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(()=> ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //repositories
  Get.lazyPut(() => MostPopularRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedRepo(apiClient: Get.find()));
  Get.lazyPut(()=> CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(()=> AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(()=> UserRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => MostPopularController(mostPopularRepo: Get.find()));
  Get.lazyPut(() => RecommendedController(recommendedRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
}