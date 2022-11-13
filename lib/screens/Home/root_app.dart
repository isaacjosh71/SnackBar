
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snack_bar/screens/Cart/cart_history.dart';
import 'package:snack_bar/screens/Home/home_page.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  late PersistentTabController _controller;
  int pageIndex = 0;

  @override
  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white.withOpacity(0.85),
  //     bottomNavigationBar: getFooter(),
  //     body: IndexedStack(
  //       index: pageIndex,
  //       children: const [
  //         HomePage(),
  //         Center(
  //           child: Text('Discover',
  //           style: TextStyle(
  //             fontSize: 15
  //           ),),
  //         ),
  //         Center(
  //           child: Text('Magazine',
  //           style: TextStyle(
  //             fontSize: 15
  //           ),),
  //         ),
  //         Center(
  //           child: Text('Profile',
  //           style: TextStyle(
  //             fontSize: 15
  //           ),),
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget getFooter(){
  //   List bottomIcons = [
  //     Entypo.home,
  //     Entypo.location,
  //     Entypo.book_open,
  //     Entypo.user,
  //   ];
  //   List bottomTexts = [
  //     'Home',
  //     'Discover',
  //     'Magazines',
  //     'Profile',
  //   ];
  //   return Container(
  //     width: double.infinity,
  //     height: 72,
  //     decoration: BoxDecoration(
  //       color: const Color(0xFFFFFFFF),
  //       border: Border(
  //         top: BorderSide(
  //           width: 2, color: const Color(0xFF2B3849).withOpacity(0.06),
  //         ),
  //     ),
  //     ),
  //     child: Padding(
  //       padding:  EdgeInsets.only(
  //           top: MediaQuery.of(context).size.height * 0.013,
  //           left: MediaQuery.of(context).size.width * 0.08,
  //           right: MediaQuery.of(context).size.width * 0.08,
  //           bottom: MediaQuery.of(context).size.height * 0.01),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: List.generate(bottomIcons.length,
  //                 (index) => InkWell(
  //                   onTap: (){
  //                     setState(() {
  //                       pageIndex = index;
  //                     });
  //                   },
  //                   child: Column(
  //                     children: [
  //                       Icon(
  //                       bottomIcons[index],
  //                         color: pageIndex == index ?
  //                         Colors.orange : const Color(0xFF2B3849).withOpacity(0.8),
  //                       ),
  //                       SizedBox(
  //                         height: MediaQuery.of(context).size.height * 0.01,
  //                       ),
  //                       Text(
  //                       bottomTexts[index],
  //                         style: TextStyle(
  //                           fontSize: 13,
  //                           color: pageIndex == index ?
  //                           Colors.orange : const Color(0xFF2B3849).withOpacity(0.8),
  //                         ),),
  //                     ],
  //                   ),
  //                 ),),
  //       ),
  //     ),
  //   );
  // }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const Center(
        child: Text('Discover',
          style: TextStyle(
              fontSize: 15
          ),),
      ),
      const CartHistory(),
      const Center(
        child: Text('Profile',
          style: TextStyle(
              fontSize: 15
          ),),
      )
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Entypo.home),
        title: ("Home"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: const Color(0xFF2B3849).withOpacity(0.8),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Entypo.location),
        title: ("Discover"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: const Color(0xFF2B3849).withOpacity(0.8),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: const Color(0xFF2B3849).withOpacity(0.8),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Entypo.user),
        title: ("Profile"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: const Color(0xFF2B3849).withOpacity(0.8),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
  return PersistentTabView(
  context,
  controller: _controller,
  screens: _buildScreens(),
  items: _navBarsItems(),
  confineInSafeArea: true,
  backgroundColor: Colors.white, // Default is Colors.white.
  handleAndroidBackButtonPress: true, // Default is true.
  resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  stateManagement: true, // Default is true.
  hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  decoration: NavBarDecoration(
  borderRadius: BorderRadius.circular(10.0),
  colorBehindNavBar: Colors.white,
  ),
  popAllScreensOnTapOfSelectedTab: true,
  popActionScreens: PopActionScreensType.all,
  itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
  duration: Duration(milliseconds: 200),
  curve: Curves.ease,
  ),
  screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
  animateTabTransition: true,
  curve: Curves.ease,
  duration: Duration(milliseconds: 200),
  ),
  navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
  );
  }
  }

