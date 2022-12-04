import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';
import 'package:snack_bar/helpers/app_const.dart';
import 'package:snack_bar/screens/Discover/address_page.dart';
import 'package:snack_bar/screens/Home/root_app.dart';
import 'package:snack_bar/validations/onboarding.dart';
import 'data/controllers/most_popular_ctlr.dart';
import 'data/controllers/recommended_ctlr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:snack_bar/helpers/dependency.dart' as dep;
import 'helpers/router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  final prefs = await SharedPreferences.getInstance();
  var token = prefs.getString(AppConstants.TOKEN);
  print('main user token: $token');
  runApp(MyApp(token: token ?? ''));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Get.find<MostPopularController>().getMostPopularList();
    Get.find<RecommendedController>().getRecommendedList();
    Get.find<CartController>().getCartData();
    return GetBuilder<MostPopularController>(builder: (_){
      return GetBuilder<RecommendedController>(builder: (_){
        return GetBuilder<CartController>(builder: (_){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Rubik',
              primaryColor: Colors.orangeAccent.shade200
            ),
            initialRoute: token == '' ? RouteHelper.getSplashScreen() : RouteHelper.getInitial(),
            getPages: RouteHelper.routes,
            // home: const RootApp(),
          );
        });
      });
    });
  }
}
