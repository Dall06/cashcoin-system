import 'package:cashcoin_mobile_flutter/config/regex.dart';

class Validator {
  isEmail(String? email) {
    if(email == "") {
      return false;
    }
    RegExp regex = RegExp(Regex.emailRegexPattern);
    if (regex.hasMatch(email!) == false) {
      return false;
    }
    return true;
  }

  isPassword(String? password) {
    if(password == "") {
      return false;
    }
    RegExp regex = RegExp(Regex.passwordRegexPattern);
    if (regex.hasMatch(password!) == false) {
      return false;
    }
    return true;
  }

  isPhone(String? phone) {
    if(phone == "") {
      return true;
    }
    RegExp regex = RegExp(Regex.phoneRegexPattern);
    if (regex.hasMatch(phone!) == false) {
      return false;
    }
    return true;
  }
}
