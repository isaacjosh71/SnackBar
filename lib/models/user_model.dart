

class UserModel{
  int id;
  String name;
  String phone;
  String email;
  Null password;
  int orderCount;

  UserModel({
    required this.id,
    required this.phone,
    required this.name,
    required this.orderCount,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['id'],
        phone: json['phone'],
        name: json['f_name'],
        orderCount: json['order_count'],
        email: json['email'],
        password: json['password']);
  }
}