
import 'package:get/get.dart';
import 'package:snack_bar/models/cart_model.dart';
import 'package:snack_bar/models/product_model.dart';
import '../repository/cart_repo.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  //product
  Map<int, CartModel> _items={};

  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  //products adding to cart
  void addItem(ProductModel product, int quantity){
    //add item to cart
    var totalQuantity=0;
    if(_items.containsKey(product.id!)){
      //if exist, add quantity to it
      _items.update(product.id!, (value){
        //if exist
        totalQuantity=value.quantity!+quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity!+quantity,
          timeCreated: DateTime.now().toString(),
          product: product,
          isExist: true,
        );
      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    }else{
      //if non existing
      if(quantity>0){
        _items.putIfAbsent(product.id!,()
        {return CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          timeCreated: DateTime.now().toString(),
          isExist: true,
          product: product,
        );
        });
      }else{
          Get.snackbar('Item Count', 'You should add at least an item');
        }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  //conditional check if product already exist in cart
  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  //
  int getQuantity(ProductModel product){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity=value.quantity!;
        }
      });
    }
    return quantity;
  }

  //total item displayed on cart icon badge
  int get totalItems{
    //does return, but not a function that needs parameters'()'
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
      // same as (totalQuantity = totalQuantity+value.quantity!)
    });
    return totalQuantity;
  }

  //list entry for new product added to cart
  List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  //total amount to checkout in cart page
  int get totalAmount{
   var total=0;
   _items.forEach((key, value) {
     total += value.quantity!*value.price!;
   });
    return total;
  }

  //get cart saved data
  List<CartModel> getCartData(){
    setCart=cartRepo.getCartList();
    return storageItems;
  }
  //to show previous cart history when app refreshes
  set setCart(List<CartModel> items){
    storageItems=items;
    //loop short_form for a continual list of (i)
    for(int i=0; i<storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!,
              () => storageItems[i]);
    }
  }

  //saved cart history for cart root page
  void addCartHistory(){
    cartRepo.addCartHistory();
    clear();
  }

  //clear after checkout
  void clear(){
    //empty map
    _items={};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCarHistoryList();
  }
}