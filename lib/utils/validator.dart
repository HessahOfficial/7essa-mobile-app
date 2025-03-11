class Validator {
  static String validateEmailAddress({required String email}) {
    String message = "";
    RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.isEmpty) {
      message = "Email field is required!";
    } else if (!regex.hasMatch(email)) {
      message = "Invalid email Address!";
    }
    return message;
  }

  static String validatePassword({required String password}) {
    String message = "";
    RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$');
    if (password.isEmpty) {
      message = "Password Field is required!";
    } else if (!regex.hasMatch(password)) {
      message = "Requires at least 8 characters, including uppercase, lowercase, digits, and special characters.";
    }
    return message;
  }

  static String validateUsername({required String username}) {
    String message = "";
    RegExp regex = RegExp(r'^.{3,}$');
    if (username.isEmpty) {
      message = "Username field is required!";
    } else if (!regex.hasMatch(username)) {
      message = "Requires at least 3 characters!";
    }
    return message;
  }
}
