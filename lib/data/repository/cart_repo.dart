
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_bar/helpers/app_const.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  //init an empty cart list
  List<String> cart=[];
  List<String> cartHistory=[];

  //add to cart list memory
  void addToCartList(List<CartModel> cartList){
    cart=[];
    //converting objects to string/json because sharedPreferences only accepts string
    cartList.forEach((element) => cart.add(jsonEncode(element)));
    sharedPreferences.setStringList(AppConstants.CARTLIST, cart);
    getCartList();
  }

  //get cart list memory
  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CARTLIST)){
      carts = sharedPreferences.getStringList(AppConstants.CARTLIST)!;
    }
    List<CartModel> cartList=[];
    //convert back json/string to object
    carts.forEach((element)=> cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
}

  //saving cart to history
void addCartHistory(){
    for (int i=0; i<cart.length; i++){cartHistory.add(cart[i]);
} removeCart();
sharedPreferences.setStringList(AppConstants.CARTHISTORYLIST, cartHistory);
} void removeCart(){sharedPreferences.remove(AppConstants.CARTLIST); //remove all cart items once checkout
}
}