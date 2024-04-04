// ignore_for_file: unnecessary_null_comparison

extension StringExtension on String {
  /// UpperCase karakter pertama pada string
  String toUpperCaseFirstCharacterOfString() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// UpperCase karakter pertama pada tiap kata
  String toUpperCaseFirstCharacterOfEachWord() {
    final stringBuffer = StringBuffer();

    var capitalizeNext = true;
    for (final letter in toLowerCase().codeUnits) {
      // UTF-16: A-Z => 65-90, a-z => 97-122.
      if (capitalizeNext && letter >= 97 && letter <= 122) {
        stringBuffer.writeCharCode(letter - 32);
        capitalizeNext = false;
      } else {
        // UTF-16: 32 == space
        if (letter == 32) capitalizeNext = true;
        stringBuffer.writeCharCode(letter);
      }
    }

    return stringBuffer.toString();
  }

  bool hasRegexEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  /// panjang 5-25 karakter
  /// mengandung setidak nya 1 symbol !@#\$&*~
  /// mengandung setidak nya 1 huruf A-Z
  /// mengandung setidak nya 1 huruf a-z
  /// mengandung setidak nya 1 angka 0-9
  bool hasRegexPassword() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,25}$')
        .hasMatch(this);
  }

  bool isNumber() {
    if (isEmpty) return false;
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(this);
  }

  /// Awal dan akhir karakter gaboleh ada spasi
  /// gaboleh ada spesial karakter
  /// gaboleh ada angka
  bool isPersonNameValidate() {
    final numericRegex = RegExp(r'''^[a-zA-Z]+(([ ][a-zA-Z ])?[a-zA-Z]*)*$''');
    return numericRegex.hasMatch(this);
  }

  /// Returns true if string is (null, empty, whitespace string):
  bool get isNullEmpty {
    var currentString = this;
    if (currentString == null) {
      return true;
    }
    return currentString.isEmpty || currentString.trim().isEmpty;
  }

  /// Returns true if string is not (null, empty, whitespace string):
  bool get isNotNullEmpty {
    return !isNullEmpty;
  }
}
