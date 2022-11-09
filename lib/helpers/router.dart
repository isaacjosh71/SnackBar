
import 'package:get/get.dart';
import 'package:snack_bar/screens/Cart/cart_page.dart';
import 'package:snack_bar/screens/Home/most_popular.dart';
import 'package:snack_bar/screens/Home/recommended.dart';
import 'package:snack_bar/screens/Home/root_app.dart';
import 'package:snack_bar/validations/splash.dart';

class RouteHelper{
  static const String initial ="/";
  static const String mostPopular = '/mostPopular';
  static const String recommended = '/recommended';
  static const String cartPage = '/cart-page';
  static const String splashPage = '/splashPage';

  static String getInitial()=> '$initial';
  static String getCartPage()=> '$cartPage';
  static String getMostPopular(int pageId, String page)=> '$mostPopular?pageId=$pageId&page=$page';
  static String getRecommended(int pageId, String page)=> '$recommended?pageId=$pageId&page=$page';
  static String getSplashScreen()=> '$splashPage';

  static List<GetPage> routes =[
    GetPage(name: initial, page: ()=>const RootApp()),

    GetPage(name: splashPage, page: ()=>const Splash()),

    GetPage(name: mostPopular, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return MostPopular(pageId:int.parse(pageId!), page:page!);
    }, transition: Transition.fadeIn),

    GetPage(name: recommended, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return Recommended(pageId:int.parse(pageId!), page:page!);
    }, transition: Transition.fadeIn),

    GetPage(name: cartPage, page: (){
      return const CartPage();
    }, transition: Transition.fadeIn),
  ];
}