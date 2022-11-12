
import 'package:snack_bar/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? timeCreated;
  ProductModel? productModel;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.isExist,
        this.timeCreated,
        this.productModel
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    timeCreated = json['timeCreated'];
    productModel=ProductModel.fromJson(json['productModel']);
  }

Map<String, dynamic> toJson() {
  return {
  'id' : id,
  'name' : name,
  'price' : price,
  'img' : img,
  'quantity' : quantity,
  'isExist' : isExist,
  'timeCreated' : timeCreated,
    'productModel':productModel!.toJson(),
  };
}
}