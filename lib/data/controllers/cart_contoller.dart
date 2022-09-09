
import 'package:get/get.dart';
import 'package:snack_bar/models/cart_model.dart';
import 'package:snack_bar/models/product_model.dart';
import '../repository/cart_repo.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  final Map<int, CartModel> _items={};

  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity){
    if(_items.containsKey(product)){
      _items.update(product.id!, (value){
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity!+quantity,
          timeCreated: DateTime.now().toString(),
          isExist: true,
        );
      });
    }else{
      _items.putIfAbsent(product.id!, () =>CartModel(
        id: product.id,
        name: product.name,
        price: product.price,
        img: product.img,
        quantity: quantity,
        timeCreated: DateTime.now().toString(),
        isExist: true,
      ));
    }
  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id!)){
      return true;
    }
    return false;
  }

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
}