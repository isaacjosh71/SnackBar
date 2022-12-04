
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150, width: 150,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFFFFF)
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.orangeAccent,),
      ),
    );
  }
}
