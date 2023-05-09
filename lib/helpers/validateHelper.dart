class ValidateHelper {
  static bool isValidEmail(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool chackLength(String value, {required int min}) {
    if (value == null || value.isEmpty) {
      return false;
    } else if (value.length >= min) {
      return false;
    }
    return true;
  }
}
