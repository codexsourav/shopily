import 'package:intl/intl.dart';

class GetDateTime {
  static getDate(date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat.yMEd().format(inputDate);
    return outputDate;
  }
}
