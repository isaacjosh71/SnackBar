
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({Key? key, required this.text, required this.tileIcon}) : super(key: key);
  final String text;
  final tileIcon;

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return SizedBox(
      height: size.height*0.085,
      width: double.infinity,
      child: Card(
        elevation: 0.5,
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(tileIcon, color: Colors.black87, size: 25,),
              const SizedBox(width: 23,),
              Text(text,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18,
                    fontWeight: FontWeight.w400, color: Color(0xFF455A64)),)
            ],
          ),
        ),
      ),
    );
  }
}
