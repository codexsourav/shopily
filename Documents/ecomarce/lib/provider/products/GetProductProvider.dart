import 'dart:convert';

import 'package:ecomarce/helpers/apihelper.dart';
import 'package:flutter/foundation.dart';

class GetProductProvider with ChangeNotifier {
  bool _isloading = true;
  List _productsList = [];

  bool get isLoading => _isloading;
  List get productsList => _productsList;

  GetProductProvider() {
    getProduct();
  }

  Future getProduct() async {
    _isloading = true;
    notifyListeners();

    var res = await ApiHelper.callapi(path: "/products", method: "GET");
    _productsList = res;
    _isloading = false;
    notifyListeners();
  }
}
