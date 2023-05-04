import 'package:get/get.dart';

bool OnPressSignupHandle(String email , String password , String repeatPassword){
  bool _emailVerification = GetUtils.isEmail(email); // ! verification of email 
  bool _passwordVerification = validatePassword(password, repeatPassword);
  return _emailVerification && _passwordVerification;
}



bool validatePassword(String password, String repeatPassword) {
  if (password.isEmpty || repeatPassword.isEmpty) {
    return false; // if either field is empty, return false
  }

  if (password != repeatPassword) {
    return false; // if the passwords don't match, return false
  }

  // password rules: 
  // at least 8 characters
  // at least 1 uppercase letter
  // at least 1 lowercase letter
  // at least 1 number
  final passwordRegex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  if (!passwordRegex.hasMatch(password)) {
    return false; // if the password doesn't meet the rules, return false
  }

  return true; // if all checks pass, return true
}