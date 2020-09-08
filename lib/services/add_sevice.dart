import 'package:daily/model/img.dart';
import 'package:daily/utils/request.dart';

class API {
  /// imgList
  static Future<List<ImageModel>> getData() async {
    var response = await RequestUtil().get('/category_list');
    return imageModelFromJson(response);
  }
}
