import 'package:ecomarce/helpers/apihelper.dart';
import 'package:ecomarce/provider/storage/init.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final _localDB = LocalDB.instense;

  bool _isloadingLogin = false;
  bool _isloadingSignup = false;

  bool get loginLoading => _isloadingLogin;
  bool get signupLoading => _isloadingSignup;
// chack user token i set or not
  Future<bool> chackAuth() async {
    var res = await _localDB.getStorege('auth');
    if (res.containsKey('token')) {
      return true;
    } else {
      return false;
    }
  }

  // for login user
  Future login({email, pass}) async {
    try {
      _isloadingLogin = true;
      notifyListeners();
      var data = await ApiHelper.callapi(
          path: "/auth/login",
          method: "POST",
          body: {"email": email, "pass": pass});
      _isloadingLogin = false;
      notifyListeners();
      return data;
    } catch (e) {
      print(e);
      _isloadingLogin = false;
      notifyListeners();
      return {"error": "Sumthing Want Wrong!"};
    }
  }

  // for signup user
  Future signup({name, email, pass}) async {
    try {
      _isloadingSignup = true;
      notifyListeners();
      var data = await ApiHelper.callapi(
          path: "/auth/signup",
          method: "POST",
          body: {"name": name, "email": email, "pass": pass});

      _isloadingSignup = false;
      notifyListeners();
      return data;
    } catch (e) {
      print(e);
      _isloadingSignup = false;
      notifyListeners();
      return {"error": "Sumthing Want Wrong!"};
    }
  }
}
