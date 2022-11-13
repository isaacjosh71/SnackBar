
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
    // sharedPreferences.remove(AppConstants.CARTLIST);
    // sharedPreferences.remove(AppConstants.CARTHISTORYLIST);
    cart=[];
    var time = DateTime.now().toString();
    //converting objects to string/json because sharedPreferences only accepts string
    for (var element in cartList) {
      element.timeCreated = time;
      cart.add(jsonEncode(element));
    }
    sharedPreferences.setStringList(AppConstants.CARTLIST, cart);
    // getCartList();
  }

  //get cart list memory
  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CARTLIST)){
      carts = sharedPreferences.getStringList(AppConstants.CARTLIST)!;
    }
    List<CartModel> cartList=[];
    //convert back json/string to object
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
}

  //get cart history list memory
  List<CartModel> getCarHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CARTHISTORYLIST)){
      cartHistory=[];
      cartHistory=sharedPreferences.getStringList(AppConstants.CARTHISTORYLIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  //saving cart to history memory
  void addCartHistory(){
    if(sharedPreferences.containsKey(AppConstants.CARTHISTORYLIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CARTHISTORYLIST)!;
    }
    for (int i=0; i<cart.length; i++){cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CARTHISTORYLIST, cartHistory);
  }

  //remove all cart items once checkout
  void removeCart(){
    sharedPreferences.remove(AppConstants.CARTLIST
    );
}
}