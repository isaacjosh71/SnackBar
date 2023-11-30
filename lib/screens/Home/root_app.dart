
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snack_bar/screens/Cart/cart_history.dart';
import 'package:snack_bar/screens/Discover/address_page.dart';
import 'package:snack_bar/screens/Home/home_page.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:snack_bar/screens/Profile/profile_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  late PersistentTabController _controller;

  @override
  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const CartHistory(),
      const AddressPage(),
      const ProfilePage()
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
        icon: const Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
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

