
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/data/controllers/cart_contoller.dart';
import 'package:snack_bar/data/repository/most_popular_repo.dart';
import 'package:snack_bar/models/product_model.dart';

class MostPopularController extends GetxController{
  final MostPopularRepo mostPopularRepo;
  MostPopularController({required this.mostPopularRepo});
  List<ProductModel> _mostPopularList=[];
  List<ProductModel> get mostPopularList => _mostPopularList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  late CartController _cart;

  Future<void>getMostPopularList() async{
      Response response = await mostPopularRepo.getMostPopularList();
      if (response.statusCode == 200){
        _mostPopularList=[];
        _mostPopularList.addAll(Product.fromJson(response.body).products);
        _isLoaded = true;
        update();
      }else{
      }
  }

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems= 0;
  int get inCartItems=>_inCartItems+_quantity;

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity=checkQuantity(_quantity+1);
    } else{
      _quantity=checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if(quantity<0){
      Get.snackbar('Item Count', 'You can\'t reduce more');
      return 0;}
    else if(quantity>10){
      Get.snackbar('Item Count', 'You can\'t add more');
      return 10;}
    else {return quantity;}
  }
  void initProduct(ProductModel product, CartController cartC){
    _quantity=0;
    _inCartItems=0;
    _cart=cartC;
    var exist=false;
    exist=_cart.existInCart(product);
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product){
   if(quantity>0){
     _cart.addItem(product, _quantity);
     _quantity=0;
     _cart.items.forEach((key, value) {});
   }else{
     Get.snackbar('Item Count', 'You should add at least an item');
   }
  }
}