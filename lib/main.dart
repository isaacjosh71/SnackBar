import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';
import 'package:snack_bar/screens/Cart/cart_page.dart';
import 'package:snack_bar/screens/Home/home_page.dart';
import 'package:snack_bar/screens/Home/recommended.dart';
import 'package:snack_bar/screens/Home/root_app.dart';
import 'package:snack_bar/validations/signIn.dart';
import 'package:snack_bar/validations/splash.dart';
import 'package:sizer/sizer.dart';
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
  runApp(const MyApp(token: '',));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required String token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Get.find<CartController>().getCartData();
    return GetBuilder<MostPopularController>(builder: (_){
      return GetBuilder<RecommendedController>(builder: (_){
        return GetBuilder<CartController>(builder: (_){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Acme',
            ),
            initialRoute: RouteHelper.getSplashScreen(),
            getPages: RouteHelper.routes,
            // home: const SignIn(),
          );
        });
      });
    });
  }
}
