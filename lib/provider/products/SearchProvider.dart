import 'package:ecomarce/helpers/apihelper.dart';
import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  String _query = '';
  bool _isloading = true;
  List _searchProducts = [];

  bool get isLoading => _isloading;
  List get searchProducts => _searchProducts;
  String get query => _query;

  Future getsearch(qu, {body}) async {
    _query = qu;
    _isloading = true;
    notifyListeners();

    var res = await ApiHelper.callapi(
        path: "/products/search/$qu", method: "POST", body: body);
    _searchProducts = res;
    _isloading = false;
    notifyListeners();
    print(_searchProducts);
  }
}
