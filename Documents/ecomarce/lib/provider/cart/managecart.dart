import 'package:flutter/material.dart';

import '../auth/AuthProvider.dart';
import '../storage/CartStorage.dart';

class ManagecartProvider with ChangeNotifier {
  ManagecartProvider() {
    getCart();
  }
  CartStorage _cartStorage = CartStorage();
  var _CartItems = [];
  final Auth = AuthProvider();
  List get CartItems => _CartItems;

  getCart() async {
    _CartItems = await _cartStorage.getCart() as List;
    notifyListeners();
  }

  AddRemove(product) async {
    bool res = await _cartStorage.manageItem(product);
    getCart();
    return res;
  }
}
