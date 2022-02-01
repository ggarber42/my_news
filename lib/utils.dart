class Utils {
  static String sanatizeValue(dynamic value) {
    if (value != null) {
      return value;
    } else {
      return '';
    }
  }
}
