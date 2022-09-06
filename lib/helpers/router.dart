
import 'package:get/get.dart';
import 'package:snack_bar/screens/Home/most_popular.dart';
import 'package:snack_bar/screens/Home/recommended.dart';
import 'package:snack_bar/screens/root_app.dart';

class RouteHelper{
  static const String initial ="/";
  static const String mostPopular = '/mostPopular';
  static const String recommended = '/recommended';

  static String getInitial()=> '$initial';
  static String getMostPopular()=> '$mostPopular';
  static String getRecommended()=> '$recommended';

  static List<GetPage> routes =[
    GetPage(name: initial, page: ()=>const RootApp()),
    GetPage(name: mostPopular, page: (){
      return const MostPopular();
    }, transition: Transition.fadeIn),
    GetPage(name: recommended, page: (){
      return const Recommended();
    }, transition: Transition.fadeIn),
  ];
}