
class LogInBody{
  String email;
  String password;
  String phone;

  LogInBody({
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    return data;
  }
}