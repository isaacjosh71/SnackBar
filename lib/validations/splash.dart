
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/helpers/router.dart';
import 'package:sizer/sizer.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    //load api list init
    // _loadResources();

    //logo animation
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    //screen navigation timer
    Timer(const Duration(seconds: 5),
            ()=>Get.offNamed(RouteHelper.getOnBoarding()));
  }

  late Animation<double> animation;
  late AnimationController controller;
  // Future<void> _loadResources() async{
  //   await Get.find<MostPopularController>().getMostPopularList();
  //   await Get.find<RecommendedController>().getRecommendedList();
  // }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return Scaffold(
          body:
          SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFCC4B),
                      Colors.orange,
                    ]),
              ),
              child: ScaleTransition(
                scale: animation,
                child: Center(
                  child: Image.asset('assets/images/25.png',
                  height: MediaQuery.of(context).size.height*0.15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
