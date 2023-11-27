import 'package:email_validator/email_validator.dart';

class Validations {
  static String? emailValidation(String value) {
    if (!EmailValidator.validate(value)) {
      return 'Please enter valid Email';
    } else if (value.isEmpty) {
      return 'Enter your Email';
    }
    return null;
  }

  static String? passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Enter Password';
    } else if (value.length < 8) {
      return 'Must be more than 8 charater';
    }
    return null;
  }
}
