import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String getFormattedTime() {
    return DateFormat.Hm().format(this).toString();
  }

  DateTime getStartOfWeek() {
    int currentDayOfWeek = weekday;
    int daysSinceStartOfWeek = currentDayOfWeek - DateTime.monday;
    DateTime startOfWeek = subtract(Duration(days: daysSinceStartOfWeek));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  }

  DateTime getStartOfMonth() {
    return DateTime(year, month, 1);
  }

  DateTime getEndOfMonth() {
    int nextMonth = (month + 1);
    if (nextMonth > 12) {
      return DateTime(year + 1, nextMonth % 13, 1);
    } else {
      return DateTime(year, nextMonth, 1);
    }
  }
}
