
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:snack_bar/validations/logIn.dart';
import 'package:snack_bar/validations/signIn.dart';

class LogInPhone extends StatefulWidget {
  const LogInPhone({Key? key}) : super(key: key);

  @override
  State<LogInPhone> createState() => _LogInPhoneState();
}

class _LogInPhoneState extends State<LogInPhone> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _obscureText = true;
  bool buttonIsActive = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _onPressed;
    // if(buttonIsActive){
    //   _onPressed=() async{
    //     try {
    //       var authController = Get.find<AuthController>();
    //       String phone = _phoneController.text.trim();
    //       String password = _passController.text.trim();
    //
    //       if(phone.isEmpty || !GetUtils.isPhoneNumber(phone)) {
    //         Get.snackbar('Phone', 'Please type in a valid phone number');}
    //       else if(password.length < 6){
    //         Get.snackbar('Password', 'Password can\'t be less than 6 characters');}
    //       else{
    //         SignUpBody signUpBody = SignUpBody(phone: phone, password: password,);
    //         print(signUpBody);
    //         authController.registration(signUpBody).then((status){
    //           if(!status.isError){
    //             print('successful registration');
    //             Get.offAll(()=> SignUpOtp(phoneNo: phone,));
    //           } else{Get.snackbar('Error', 'Wrong Authentication');}
    //         });
    //       }
    //     }
    //     catch(e){
    //       final snackBar = SnackBar(content: Text(e.toString()));
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     }
    //   };
    // }
    return Scaffold(
      body:
      SingleChildScrollView(
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
                    const Text('Phone Number',
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
                    GestureDetector(
                        onTap: (){
                          Get.to(const LogInEmail());
                        },
                        child: Text('Log in with email',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.brown.shade400,
                              fontWeight: FontWeight.w300, fontSize: 16
                          ),)),
                    const SizedBox(
                      height: 20,
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
                        onSaved: (value){},
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
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(
                              2,),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.grey),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orangeAccent,)
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
                            Get.to(const SignIn());
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
      ),
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
