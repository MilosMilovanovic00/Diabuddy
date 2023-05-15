extension StringExtensions on String {
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(this);
  }

  bool isValidPassword() {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$');
    return passwordRegex.hasMatch(this);
  }
}
