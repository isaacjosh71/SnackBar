

class SignUpBody{
  String name;
  String phone;
  String mail;
  String password;

  SignUpBody({
    required this.name,
    required this.phone,
    required this.mail,
    required this.password,
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.name;
    data['email'] = this.mail;
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }
}