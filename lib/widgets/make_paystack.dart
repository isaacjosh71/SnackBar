import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:snack_bar/helpers/notifier.dart';
import 'package:snack_bar/widgets/paystack_key.dart';

import '../data/controllers/cart_contoller.dart';
import '../screens/Cart/order_successful.dart';

class MakePayment{
  MakePayment({required this.ctx, required this.email, required this.price});
  BuildContext ctx; int price ; String email;
  PaystackPlugin payStack = PaystackPlugin();
  // Notifier notifier = Notifier();


  //make reference
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  //card UI
  PaymentCard _getCardUI(){
    return PaymentCard(number: '', cvc: '', expiryMonth: 0, expiryYear: 0);
  }

  //initialize plugin
  Future initializePlugin() async{
    await payStack.initialize(publicKey: PayStackKey.Pkey);
  }

  //charging card
  chargeCard ()async{
    initializePlugin().then((_) async{
      Charge charge = Charge()
        ..amount = price * 100
        ..reference = _getReference()
        ..email = email
        ..card = _getCardUI();

      CheckoutResponse response = await payStack.checkout(
        ctx,
        method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
        charge: charge,
        fullscreen: false,
        logo: Image.asset('assets/images/25.png',
          color: Colors.brown.shade700,
          height: 24,
        ),
      );
      print('PayStack Response $response');
      if(response.status==true){
        print('Transaction Successful');
        Get.find<CartController>().addCartHistory();
        // notifier.displayNotification(
        //     title: "SnackBar",
        //     body: 'Food arriving in few minutes');
        Get.to(()=> const OrderSuccessful());
      }
      else{print('Transaction Failed');
      }
    });
  }


}