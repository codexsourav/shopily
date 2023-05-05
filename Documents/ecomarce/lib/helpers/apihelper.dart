import 'dart:convert';

import 'package:ecomarce/constents/urls.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future callapi({path = '/', method = "GET", body}) async {
    try {
      var headersList = {
        'Accept': '*/*',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MzM5ZDM2OTNmN2E0OGIzODNkY2MxNSIsImlhdCI6MTY4MTExMTg2OX0.djGqfYUSqa1B15SxW-5JmDOOv1Pxs7XzVGwx9LAnIdwr',
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
