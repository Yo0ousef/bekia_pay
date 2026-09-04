import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get chatFormat {
    final DateTime now = DateTime.now();
    final DateTime date = DateTime(year, month, day);
    final DateTime today = DateTime(now.year, now.month, now.day);
    final int difference = today.difference(date).inDays;
    if (difference == 0) {
      return DateFormat("h:mm a").format(this);
    }
    if (difference == 1) {
      return "Yesterday";
    }
    if (difference < 7) {
      return DateFormat("EEEE").format(this);
    }
    if (year == now.year) {
      return DateFormat("MMM d").format(this);
    }
    return DateFormat("MMM d, yyyy").format(this);
  }
}
