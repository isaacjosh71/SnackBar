
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:snack_bar/helpers/content.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:snack_bar/helpers/router.dart';
import 'package:snack_bar/validations/signIn.dart';

class Slide extends StatefulWidget {
  const Slide({Key? key}) : super(key: key);

  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  late PageController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
        Column(
            children: [
              const SizedBox(
                height: 20,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    Image.asset('assets/images/25.png',
                      height: MediaQuery.of(context).size.height * 0.05,
                      color: Colors.brown.shade700,
                    ),
                    const SizedBox(
                      width: 3,),
                    const Text('Snack',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFCC4B),
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),),
                    const Text('Bar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),),
                  ]
              ),
               SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Expanded(
                child:  PageView.builder(
                    controller: _controller,
                    onPageChanged: (int index){
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    scrollBehavior: const ScrollBehavior(
                      androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
                    ),
                    itemCount: contents.length,
                    itemBuilder: (_,i){
                      return Padding(padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Image.asset(
                                contents[i].image,
                                height: MediaQuery.of(context).size.height * 0.225),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03),
                            Text(
                              contents[i].text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize:25,
                              ),),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02),
                            Text(
                              contents[i].description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.035),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              List.generate(contents.length, (index){
                                return buildDot(index, context);
                              }),
                            ),
                          ],
                        ),);
                    }),
              ),
               SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03),
              GestureDetector(
                onTap: (){
                  if (currentIndex == contents.length - 1){
                    Get.offNamed(RouteHelper.getSignUpPage());
                  }
                  _controller.nextPage(duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFCC4B),
                          Colors.orange,
                        ]),
                  ),
                  child: Center(
                    child: Text( currentIndex == contents.length -1
                        ? 'Get Started' : 'Next',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white,
                          fontSize: 20),),
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText('Your Favorite Hunger Companion',
                      textAlign: TextAlign.justify,
                      textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      )),],
                repeatForever: true,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(duration: const Duration(milliseconds: 300),
                        height: 7.0,
                        width: currentIndex == index ? 17:7,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFCC4B),
                                Color(0xFFFF7D58),
                              ]),
                        ),
                      );
  }
}