import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Coming soon', style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),),),
    );
  }
}
