import 'package:intl/intl.dart';

class Utils {
  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    return date;
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
  }

  static int dateTimeToInt(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  static DateTime intToDateTime(int dateTime) {
    return DateTime.fromMillisecondsSinceEpoch(dateTime);
  }
}
