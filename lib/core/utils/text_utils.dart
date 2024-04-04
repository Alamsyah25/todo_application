extension TextUtilsStringExtension on String? {
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
