
import 'package:flutter/material.dart';
import 'package:snack_bar/screens/Home/home_page.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      bottomNavigationBar: getFooter(),
      body: IndexedStack(
        index: pageIndex,
        children: const [
          HomePage(),
          Center(
            child: Text('Discover',
            style: TextStyle(
              fontSize: 15
            ),),
          ),
          Center(
            child: Text('Magazine',
            style: TextStyle(
              fontSize: 15
            ),),
          ),
          Center(
            child: Text('Profile',
            style: TextStyle(
              fontSize: 15
            ),),
          )
        ],
      ),
    );
  }

  Widget getFooter(){
    List bottomIcons = [
      Entypo.home,
      Entypo.location,
      Entypo.book_open,
      Entypo.user,
    ];
    List bottomTexts = [
      'Home',
      'Discover',
      'Magazines',
      'Profile',
    ];
    return Container(
      width: double.infinity,
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border(
          top: BorderSide(
            width: 2, color: const Color(0xFF2B3849).withOpacity(0.06),
          ),
      ),
      ),
      child: Padding(
        padding:  EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.013,
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08,
            bottom: MediaQuery.of(context).size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomIcons.length,
                  (index) => InkWell(
                    onTap: (){
                      setState(() {
                        pageIndex = index;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                        bottomIcons[index],
                          color: pageIndex == index ?
                          Colors.orange : const Color(0xFF2B3849).withOpacity(0.8),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                        bottomTexts[index],
                          style: TextStyle(
                            fontSize: 13,
                            color: pageIndex == index ?
                            Colors.orange : const Color(0xFF2B3849).withOpacity(0.8),
                          ),),
                      ],
                    ),
                  ),),
        ),
      ),
    );
  }
}

