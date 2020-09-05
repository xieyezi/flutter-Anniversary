import 'package:daily/model/categroy.dart';
import 'package:daily/utils/request.dart';

class API {
  /// categoryList
  static Future<List<CategoryModel>> getData() async {
    var response = await RequestUtil().get('/category_list');
    return categoryModelFromJson(response);
  }
}
