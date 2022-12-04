
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/helpers/dimension.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? weight;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButton({Key? key, this.onPressed,
    required this.buttonText, this.transparent = false,
    this.margin, this.height, this.weight, this.fontSize,
    this.radius = 5, this.icon, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPressed==null
          ? Theme.of(context).disabledColor
          : transparent ? Colors.transparent
          : Theme.of(context).primaryColor,
      minimumSize: Size(width==null ? Dimensions.screenWidth : width!,
          height!=null ? height! : 40
      ),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      )
    );
    return Center(
      child: SizedBox(
        width: width??Dimensions.screenWidth,
        height: height??40,
        child: TextButton(
          onPressed: onPressed,
          style: _flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               icon!=null
               ? Padding(padding: const EdgeInsets.only(right: 5),
               child: Icon(icon,
               color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor,),
               ) : const SizedBox(),
               Text(
                 buttonText,
                 style: TextStyle(
                   fontSize: fontSize ?? 16,
                   color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor,
                 ),
               )
             ],
          ),
        ),
      ),
    );
  }
}
