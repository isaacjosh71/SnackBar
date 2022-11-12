class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products=>_products;

  Product({required totalSize, required typeId, required offset, required products}){
    _totalSize=totalSize;
    _offset=offset;
    _typeId=typeId;
    _products=products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['total_size'] = totalSize;
  //   data['type_id'] = typeId;
  //   data['offset'] = offset;
  //   if (products != null) {
  //     data['products'] = products!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.stars,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    return {
    'id': id,
    'name': name,
    'description':description,
    'price':price,
    'stars':stars,
    'img':img,
    'location':location,
    'created_at':createdAt,
    'updated_at':updatedAt,
    'type_id':typeId,
    };
  }
}
