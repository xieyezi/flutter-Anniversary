import 'package:daily/model/categroy.dart';
import 'package:daily/services/add_sevice.dart';

/// 供应商provider
import 'package:flutter/foundation.dart';

class AddProvider with ChangeNotifier {
  bool loading = true;
  List<CategoryModel> categoryList = [];

  AddProvider() {
    /// 数据加载
    initData();
  }

  Future initData({bool refresh = false}) async {
    List<CategoryModel> res = await API.getData();
    categoryList = res;
    loading = false;
    notifyListeners();
  }
}
