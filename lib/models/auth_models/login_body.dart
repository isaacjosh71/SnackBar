
class LogInBody{
  String email;
  String password;
  String phone;

  LogInBody({
    required this.email,
    required this.password,
    required this.phone
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }
}