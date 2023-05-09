import 'dart:convert';
import 'dart:math';

import 'package:ecomarce/constents/urls.dart';
import 'package:ecomarce/provider/storage/init.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future callapi({path = '/', method = "GET", body}) async {
    var data = await LocalDB.instense.getStorege('auth');

    try {
      var headersList = {
        'Accept': '*/*',
        'Authorization': 'Bearer ${data['token'] ?? ''}',
        'Content-Type': 'application/json'
      };
      var url = Uri.parse('${Urls.api}$path');

      var req = http.Request(method, url);
      req.headers.addAll(headersList);
      if (body != null) {
        req.body = json.encode(body);
      }
      var res = await req.send();
      final resBody = await res.stream.bytesToString();
      // print(resBody);
      return jsonDecode(resBody);
    } catch (e) {
      print(e);
      return {"error": "Sumthing Want Wrong!"};
    }
  }
}
