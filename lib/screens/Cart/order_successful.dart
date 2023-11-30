
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:snack_bar/helpers/router.dart';
import 'package:snack_bar/screens/Home/root_app.dart';

class OrderSuccessful extends StatefulWidget {
  const OrderSuccessful({Key? key}) : super(key: key);

  @override
  State<OrderSuccessful> createState() => _OrderSuccessfulState();
}

class _OrderSuccessfulState extends State<OrderSuccessful> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
  }

  late Animation<double> animation;
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 163,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 46),
            child: ScaleTransition(
              scale: animation,
              child: Center(
                child: Image.asset('assets/images/25.png',
                  height: MediaQuery.of(context).size.height*0.15,
                  color: Colors.brown.shade700,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Text('Your order is arriving to your destination',style: TextStyle(
                    color: Color(0xFF767676),
                    fontSize: 17, letterSpacing: -0.33,
                    fontWeight: FontWeight.w400
                ),),
                SizedBox(height: 1,),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: formattedDate,
                              style: TextStyle(color: const Color(0xFF1F1F1F),
                                  fontSize: 15,letterSpacing: -0.33,
                                  fontWeight: FontWeight.w600
                              )),

                        ]
                    )),
              ],
            ),
          ),
          SizedBox(height: 70,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              height: 55,
              width: 296,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    elevation: MaterialStateProperty.all(0),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 49, vertical: 17)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal
                    ),)
                ),
                onPressed: (){
                  Get.off(()=> RootApp());
                },
                child: const Center(child: Text('Ok')),),
            ),
          ),
        ],
      ),
    );
  }
}
