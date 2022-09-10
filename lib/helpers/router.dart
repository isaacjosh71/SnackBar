
import 'package:get/get.dart';
import 'package:snack_bar/screens/Home/most_popular.dart';
import 'package:snack_bar/screens/Home/recommended.dart';
import 'package:snack_bar/screens/Home/root_app.dart';

class RouteHelper{
  static const String initial ="/";
  static const String mostPopular = '/mostPopular';
  static const String recommended = '/recommended';

  static String getInitial()=> '$initial';
  static String getMostPopular(int pageId)=> '$mostPopular?pageId=$pageId';
  static String getRecommended(int pageId)=> '$recommended?pageId=$pageId';

  static List<GetPage> routes =[
    GetPage(name: initial, page: ()=>const RootApp()),

    GetPage(name: mostPopular, page: (){
      var pageId = Get.parameters['pageId'];
      return MostPopular(pageId:int.parse(pageId!));
    }, transition: Transition.fadeIn),

    GetPage(name: recommended, page: (){
      var pageId = Get.parameters['pageId'];
      return Recommended(pageId:int.parse(pageId!));
    }, transition: Transition.fadeIn),
  ];
}