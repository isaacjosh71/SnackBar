
import 'package:get/get.dart';

//Responsive with GetX
class Dimensions{
  //print('your current height is MediaQuery.of(context).size.height.toString()')
  //the current height of emulator device is 802.9
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  //screenWidth becomes responsive with Get
  //assuming a container height is 40
  // then divide screenHeight by (844 by 40 i.e 21.1) to get responsive container
  //note: divide first before you divide with screenHeight (2 divisions)
  /*
  static double containerHeight40 = screenHeight/21.1;
   */
  //so wherever my container of height 40 is,
  // i replace with Dimensions.containerHeight40
  //same goes for icon size, radius, font size, width, sized box etc

}