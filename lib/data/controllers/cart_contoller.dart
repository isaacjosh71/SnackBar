
import 'package:get/get.dart';
import 'package:snack_bar/models/cart_model.dart';
import 'package:snack_bar/models/product_model.dart';
import '../repository/cart_repo.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  final Map<int, CartModel> _items={};

  void addItem(ProductModel product, int quantity){
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