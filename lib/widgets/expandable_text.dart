
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = 300;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf=widget.text.substring(0, textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else {
      firstHalf=widget.text;
      secondHalf="";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?Text(firstHalf)
          :Column(
        children: [
          Text(hiddenText?(firstHalf+"..."):(firstHalf+secondHalf),
            textAlign: TextAlign.justify,
            maxLines: 60,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Color(0xFF455A64),
                fontSize: 14.5,
                fontWeight: FontWeight.w100,
                wordSpacing: 7
            ),
          ),
          InkWell(
            onTap: (){
              setState((){
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: const [
                Text('show more',
                style: TextStyle(color: Colors.orangeAccent),
                ),
                Icon(
                    Icons.arrow_drop_down_rounded,
                color: Colors.orangeAccent,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
