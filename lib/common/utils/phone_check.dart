class PhoneUtils {
  static const prefixList = ['+1', '+81', '+86', '+852'];

  /// Check if the phone number is valid based on the prefix
  static bool isPhoneNumberValid(String? prefix, String? value) {
    print('prefix: $prefix, value: $value');
    if (value == null || value.isEmpty) {
      return false;
    }
    if (prefix == null || prefix.isEmpty) {
      return false;
    }
    if (prefix == '+1') {
      return RegExp(r'^\d{10}$').hasMatch(value);
    }
    if (prefix == '+81') {
      return RegExp(r'^0\d{9,10}$').hasMatch(value);
    }
    if (prefix == '+86') {
      return RegExp(r'^1[3-9]\d{9}$').hasMatch(value);
    }
    if (prefix == '+852') {
      return RegExp(r'^5\d{7}$').hasMatch(value);
    }
    // if (prefix == '+853') {
    //   return RegExp(r'^6\d{7}$').hasMatch(value);
    // }
    // if (prefix == '+886') {
    //   return RegExp(r'^9\d{8}$').hasMatch(value);
    // }
    return false;
  }
}
