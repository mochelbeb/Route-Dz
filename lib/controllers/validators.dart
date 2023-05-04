import 'package:get/get.dart';

class PasswordValidator extends GetxController{
  var password = "".obs;
  var repeatPassword = "".obs;
  static RxString passwordError = "".obs;

  @override void onInit() {
    super.onInit();
    ever(password, (_) {
    if (password != repeatPassword) {
      passwordError.value = 'Passwords do not match';
    } else {
      validatePassword();
    }
    });
    ever(repeatPassword, (_) {
    if (password != repeatPassword) {
      passwordError.value = 'Passwords do not match';
    } else {
      validatePassword();
    }
    });
  }

  void validatePassword(){
    if (password.value.isEmpty || repeatPassword.value.isEmpty) {
      passwordError.value = "Password can't be empty";
    } else if (password.value != repeatPassword.value) {
      passwordError.value = "Passwords don't match";
    } else if (password.value.length < 8) {
      passwordError.value = "Password must be at least 8 characters long";
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password.value)) {
      passwordError.value = "Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character";
    } else {
      passwordError.value = '';
    }
  }

  bool get isPasswordValid => passwordError.value.isEmpty;

}