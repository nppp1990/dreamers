import 'package:dreamer/common/utils/phone_check.dart';
import 'package:flutter/material.dart';

class SignupData with ChangeNotifier {
  String? phonePrefix;
  String? phoneNumber;

  SignupData({this.phonePrefix, this.phoneNumber});

  void setPhonePrefix(String prefix) {
    phonePrefix = prefix;
    notifyListeners();
  }

  void setPhoneNumber(String number) {
    phoneNumber = number;
    notifyListeners();
  }
}
