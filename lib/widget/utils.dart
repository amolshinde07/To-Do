//@dart=2.9
import 'package:intl/intl.dart';
class Utils{
  static RegExp regExpDateWithTime = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d[ ](0[0-9]|1[0-9]|2[0-4])[:](0[0-9]|[1-4][0-9]|5[0-9])$');
  /////   dd-MM-yyyy
  static RegExp regExpDate = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$');
  static DateTime stringToUtcDate(String dateString) {
    if (regExpDate.hasMatch(dateString))
      return DateFormat("dd-MM-yyyy").parse(dateString).toUtc();
    else if (regExpDateWithTime.hasMatch(dateString))
      return DateFormat("dd-MM-yyyy H:m").parse(dateString).toUtc();
    else
      print("Invalid Date");
    return null;
  }

  static String dateToLocalString(DateTime date,
      {String format = "dd-MM-yyyy"}) {
    return DateFormat(format).format(date.isUtc ? date.toLocal() : date);
  }

  static String dateToLocalTimeString(DateTime date,
      {bool is12H = false, String format}) {
    return DateFormat(format != null
        ? format
        : is12H
        ? "j:m"
        : "H:m")
        .format(date.isUtc ? date.toLocal() : date);
  }
}