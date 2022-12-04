import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';

class PaymentOption extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;
  final int index;
  const PaymentOption({Key? key, required this.iconData, required this.title, required this.subtitle, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartC){
      bool _selected = cartC.paymentIndex==index;
      return InkWell(
        onTap: ()=>cartC.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1
                )
              ]
          ),
          child: ListTile(
            leading: Icon(iconData,
              size: 40, color: _selected?Theme.of(context).disabledColor:null,
            ),
            title: Text(title, style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: 17,),),
            subtitle: Text(subtitle,
              maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 17,),),
            trailing: _selected?Icon(Icons.check_circle, color: Colors.orangeAccent,):null,
          ),
        ),
      );
    });
  }
}
