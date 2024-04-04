import 'package:intl/intl.dart';

class DateFormatWasser {
  static const datePattern = 'dd/MM/yyyy';

  static String format(DateTime dateTime) {
    return DateFormat(datePattern).format(dateTime);
  }
}
