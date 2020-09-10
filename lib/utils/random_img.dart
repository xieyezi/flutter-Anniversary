import 'dart:math';
import 'package:daily/model/img.dart';

class RandomImg {
  static String randomImg(List<ImageModel> imgList) {
    var random = new Random();
    return imgList[random.nextInt(imgList.length - 3)].imgUrl;
  }
}
