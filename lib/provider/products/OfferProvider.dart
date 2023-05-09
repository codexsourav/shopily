import 'package:flutter/material.dart';

import '../../helpers/apihelper.dart';

class OfferProvider with ChangeNotifier {
  bool _loading = false;
  List _offers = [];
  bool get isloading => _loading;
  List get offers => _offers;

  OfferProvider() {
    getProduct();
  }

  Future getProduct() async {
    _loading = true;
    notifyListeners();
    var res = await ApiHelper.callapi(path: "/offer", method: "GET");
    _offers = res;
    _loading = false;
    notifyListeners();
  }
}
