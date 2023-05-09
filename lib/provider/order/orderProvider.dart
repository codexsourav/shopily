import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  bool _isCartorder = false;
  Map _address = {};
  List _product = [];
  List get product => _product;
  Map get address => _address;
  bool get iscart => _isCartorder;

  setOrderType({iscart, product}) {
    _isCartorder = iscart;
    _product = product;
    notifyListeners();
  }

  setAddress({address}) {
    _address = address;
    notifyListeners();
  }
}
