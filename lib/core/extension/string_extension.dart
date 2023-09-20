extension ExtString on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPasswordHasSpecialCharacter{
    final passwordRegExp =
    RegExp(r'[!@#$\><*~]');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPasswordHasCapitalLetter{
    final passwordRegExp =
    RegExp(r'[A-Z]');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPasswordHasLowerCaseLetter{
    final passwordRegExp =
    RegExp(r'[a-z]');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPasswordHasNumber{
    final passwordRegExp =
    RegExp(r'[0-9]');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}