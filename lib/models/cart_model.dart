
class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? timeCreated;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.isExist,
        this.timeCreated
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    timeCreated = json['timeCreated'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['name'] = this.name;
//   data['description'] = this.description;
//   data['price'] = this.price;
//   data['stars'] = this.stars;
//   data['img'] = this.img;
//   data['location'] = this.location;
//   data['created_at'] = this.createdAt;
//   data['updated_at'] = this.updatedAt;
//   data['type_id'] = this.typeId;
//   return data;
// }
}