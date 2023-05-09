import 'dart:convert';

import 'package:ecomarce/helpers/apihelper.dart';
import 'package:flutter/foundation.dart';

class GetAProduct with ChangeNotifier {
  bool _isloading = true;
  Map _product = {};

  bool get isLoading => _isloading;
  Map get product => _product;
  GetAProduct(id) {
    getProduct(id);
  }

  Future getProduct(id) async {
    _isloading = true;
    notifyListeners();

    var res = await ApiHelper.callapi(path: "/product/$id", method: "GET");
    _product = res;
    _isloading = false;
    notifyListeners();
  }
}
