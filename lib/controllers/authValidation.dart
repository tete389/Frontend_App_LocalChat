
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../models/validationModel.dart';

class AuthValidation extends ChangeNotifier {
  late ValidationModel _name = ValidationModel(null, null);
  late ValidationModel _email = ValidationModel(null, null);
  late ValidationModel _password = ValidationModel(null, null);
  late ValidationModel _confirmPassword = ValidationModel(null, null);

  //getter
  ValidationModel get name => _name;
  ValidationModel get email => _email;
  ValidationModel get password => _password;
  ValidationModel get confirmPassword => _confirmPassword;

  bool get isValid {
    if (_name.value != null &&
        _email.value != null &&
        _password.value != null &&
        _confirmPassword.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidSignIn {
    if (_email.value != null && _password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool get isConfirmPass {
    if (_password.value != null && _password.value == _confirmPassword.value) {
      return true;
    } else {
      return false;
    }
  }

  //setters

  void changeName(String value) {
    if (value.length >= 2) {
      _name = ValidationModel(value, null);
    } else {
      _name = ValidationModel(null, "ตัวอักษรอย่างน้อย 2 ตัวอักษร");
    }
    notifyListeners();
  }

  void changeEmail(String value) {
    if (EmailValidator.validate(value)) {
      _email = ValidationModel(value, null);
    } else {
      _email = ValidationModel(null, "รูปแบบอีเมลไม่ถูกต้อง");
    }
    notifyListeners();
  }

  void changePassword(String value) {
    if (value.length >= 6) {
      _password = ValidationModel(value, null);
    } else {
      _password = ValidationModel(null, "รหัสผ่านอย่างน้อย 6 ตัว");
    }
    notifyListeners();
  }

  void changeConfirmPassword(String value) {
    if (value == _password.value) {
      _confirmPassword = ValidationModel(value, null);
    } else {
      _confirmPassword = ValidationModel(null, "รหัสผ่านไม่ตรงกัน");
    }
    notifyListeners();
  }

  // Future<bool> submitData() async {
  //   print("${name.value},${email.value},${password.value}");
  //    return AuthController().signUp(email.value.toString(),
  //       password.value.toString(), name.value.toString());

  // }

  void resetValid() {
    _name = ValidationModel(null, null);
    _email = ValidationModel(null, null);
    _password = ValidationModel(null, null);
    _confirmPassword = ValidationModel(null, null);

    notifyListeners();
  }
}