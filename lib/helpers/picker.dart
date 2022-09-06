
import 'package:flutter_svg/svg.dart';

const String iconPath = "assets/icons/";
const String imagePath = "assets/images/";

getSvgIcon(icon) {
  return SvgPicture.asset(iconPath + icon,
  );
}

getImage(image) {
  return imagePath + image;
}

getImageNetwork(url) {
  return url;
}

getHeight(width, [String ratio = "16:9"]) {
  var split = ratio.split(":");
  var wr = double.parse(split[0]);
  var hr = double.parse(split[1]);
  return (width / wr) * hr;
}