import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snack_bar/screens/Home/home_page.dart';
import 'package:snack_bar/screens/Home/recommended.dart';
import 'package:snack_bar/screens/root_app.dart';
import 'package:snack_bar/screens/splash.dart';
import 'package:sizer/sizer.dart';
import 'data/controllers/most_popular_ctlr.dart';
import 'data/controllers/recommended_ctlr.dart';
import 'helpers/router.dart' as router;
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:snack_bar/helpers/dependency.dart' as dep;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Sizer(builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
      Get.find<MostPopularController>().getMostPopularList();
      Get.find<RecommendedController>().getRecommendedList();
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Acm',
        ),
        // initialRoute: ,
        // getPages: [],
        home: const RootApp(),
      );
    },);
  }
}
