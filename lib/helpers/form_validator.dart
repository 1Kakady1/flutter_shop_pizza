mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;
  bool isStringLen(String string, int len) => string.length > len;
  bool isRequired(dynamic value) => value != null && value != "";
  bool isEmailValid(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  bool isEqualsNumber(int a, int b) => a == b;
}
