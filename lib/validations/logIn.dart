
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_bar/helpers/custom_loader.dart';
import 'package:snack_bar/helpers/router.dart';
import 'package:snack_bar/models/auth_models/login_body.dart';
import 'package:snack_bar/validations/signIn.dart';

import '../data/controllers/auth_ctlr.dart';

class LogInEmail extends StatefulWidget {
  const LogInEmail({Key? key}) : super(key: key);

  @override
  State<LogInEmail> createState() => _LogInEmailState();
}

class _LogInEmailState extends State<LogInEmail> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _obscureText = true;
  bool buttonIsActive = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _onPressed;
    if(buttonIsActive){
      _onPressed=() async{
        try {
          var authController = Get.find<AuthController>();
          String mail = _mailController.text.trim();
          String password = _passController.text.trim();
          String phone = _phoneController.text.trim();

          if(mail.isEmpty || !GetUtils.isEmail(mail)){
            Get.snackbar('Email', 'Please type in a valid email');}
          else if(phone.isEmpty || !GetUtils.isPhoneNumber(phone)) {
            Get.snackbar('Phone', 'Please type in a valid phone number');}
          else if(password.length < 6){
            Get.snackbar('Password', 'Password can\'t be less than 6 characters');}
          else{
            LogInBody logInBody = LogInBody(email: mail, password: password, phone: phone);
            print(logInBody);
            authController.loginUser(logInBody).then((status){
              if(status.isSuccess){
                print('successful registration');
                Get.offNamed(RouteHelper.getInitial());
              } else{Get.snackbar('Error', 'Wrong Authentication');}
            });
          }
        }
        catch(e){
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      };
    }
    return Scaffold(
      body:
      GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading ? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.16,),
              Image.asset('assets/images/25.png', height: size.height*0.125,
                color: Colors.brown.shade700,),
              SizedBox(
                height: size.height * 0.035,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: size.width*0.1),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Email',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF767676)
                        ),),
                      TextFieldContainer(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          controller: _mailController,
                          onSaved: (value){},
                          decoration: const InputDecoration(
                            hintText: 'Input email',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Phone number',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF767676)
                        ),),
                      TextFieldContainer(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          onSaved: (value){},
                          decoration: const InputDecoration(
                            hintText: 'Input phone number',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Password',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF767676)
                        ),),
                      TextFieldContainer(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _passController,
                          obscureText: _obscureText,
                          onChanged: (value){
                            setState((){
                              buttonIsActive = value.isNotEmpty?true:false;
                            });
                          },
                          key: const ValueKey('password'),
                          decoration: InputDecoration(
                            hintText: 'Input password',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                            suffixIcon:GestureDetector(
                              onTap: (){
                                setState(() {
                                  _obscureText =!_obscureText;
                                });
                              },
                              child: Icon(_obscureText ? Icons.visibility_off
                                  : Icons.visibility,
                                  size: 20,color: const Color(0xFFB4B4B4)),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: (){},
                          child: Text('Forgot password?',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.brown.shade400,
                                fontWeight: FontWeight.w300, fontSize: 16
                            ),)),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(
                              2,),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.grey),
                            backgroundColor: MaterialStateProperty.all(
                                buttonIsActive ? Colors.orangeAccent : null
                            ),
                          ),
                          child: const Text('Log In',
                            style: TextStyle(color: Colors.white,
                                fontSize: 20),),
                          onPressed: _onPressed),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        children: [
                          const Text('If you don\'t have an account',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Color(0xFF767676),
                                fontSize: 15,
                                fontWeight: FontWeight.w300
                            ),),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getSignUpPage());
                            },
                            child: const Text('  click here',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300
                              ),),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            : const CustomLoader();
      })
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 15, vertical: 2,
      ),
      child: child,
    );
  }
}
