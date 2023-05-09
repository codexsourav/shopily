import 'dart:async';

import 'package:ecomarce/helpers/apihelper.dart';
import 'package:flutter/material.dart';
import '../auth/AuthProvider.dart';
import '../storage/CartStorage.dart';

final _Auth = AuthProvider();

class ManagecartProvider with ChangeNotifier {
  CartStorage _cartStorage = CartStorage();
  var _CartItems = [];
  final Auth = AuthProvider();
  double _price = 0;
  List get CartItems => _CartItems;
  double get totalPrice => _price;
  ManagecartProvider() {
    Timer(Duration(seconds: 3), () async {
      getCart();
    });
  }

  getCart() async {
    _CartItems = await _cartStorage.getCart() as List;
    setTotal();
    notifyListeners();
  }

  AddRemove(product) async {
    bool res = await _cartStorage.manageItem(product);
    await getCart();
    if (await Auth.chackAuth()) {
      if (res) {
        var ret = await ApiHelper.callapi(
            path: '/cart', method: "POST", body: {"productId": product['_id']});
        print(ret);
      } else {
        var ret = await ApiHelper.callapi(
            path: '/cart/${product['_id']}', method: "DELETE");
        print(ret);
      }
    }
  }

  updateCart({id, quantity}) async {
    await _cartStorage.update(id: id, qunt: quantity);
    getCart();
    if (await Auth.chackAuth()) {
      var ret = await ApiHelper.callapi(
          path: '/cart/',
          method: "PUT",
          body: {"productId": id, "quantity": quantity});
      print(ret);
    }
  }

  setTotal() async {
    double settotal = 0.0;
    for (var i = 0; i < _CartItems.length; i++) {
      var mrp = _CartItems[i]['product']['price'];
      var qun = _CartItems[i]['quantity'];
      settotal = (settotal + mrp) * qun;
    }
    _price = settotal.toDouble();
    notifyListeners();
  }
}
