import 'package:intl/intl.dart';

class NumberFormatter {
  static String rupiah(int data) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0)
        .format(data);
  }

  static String decimalThreePoint(int data) {
    return NumberFormat.currency(symbol: '', decimalDigits: 0).format(data);
  }
}
