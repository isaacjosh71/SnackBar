
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snack_bar/validations/onboarding.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
                MaterialPageRoute(
                    builder: (context)=>const Slide()
                )));
  }
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
              child: Center(
                child: Image.asset('assets/images/25.png',
                height: 120,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
