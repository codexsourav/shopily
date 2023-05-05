import 'dart:convert';

import 'package:ecomarce/helpers/apihelper.dart';
import 'package:flutter/foundation.dart';

class RatingProvider with ChangeNotifier {
  bool _isloading = true;
  List _ratings = [];

  bool get isLoading => _isloading;
  List get ratings => _ratings;
  RatingProvider(id) {
    getRaings(id);
  }

  Future getRaings(id) async {
    _isloading = true;
    notifyListeners();

    var res = await ApiHelper.callapi(path: "/rating/show/$id", method: "GET");
    _ratings = res;
    _isloading = false;
    notifyListeners();
  }
}
