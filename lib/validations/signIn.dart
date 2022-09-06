
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        minimum: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  const [
                  Text('SIGN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFCC4B),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),),
                  SizedBox(
                    width: 4,
                  ),
                  Text('UP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextFieldContainer(
                    child: TextField(
                      cursorColor: Colors.black,
                      showCursor: true,
                      decoration: InputDecoration(
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
                    height: 15,
                  ),
                  const Text('Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),),
                  TextFieldContainer(
                    child: Row(
                      children: const [
                        Flexible(
                          child: TextField(
                            cursorColor: Colors.black,
                            showCursor: true,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Input password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.remove_red_eye_outlined,
                          size: 18,)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Confirm Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),),
                  TextFieldContainer(
                    child: Row(
                      children: const [
                        Flexible(
                          child: TextField(
                            cursorColor: Colors.black,
                            showCursor: true,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Re-input password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.remove_red_eye_outlined,
                          size: 18,)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(
                              5,),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.grey),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orangeAccent,)
                        ),
                        child: const Text('SIGN UP',
                          style: TextStyle(color: Colors.white,
                              fontSize: 20),),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/root_app', (route) => false);
                        }),
                  ),
                ],
              ),
            ],
          ),
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
      height: 45,
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
