// bool validateEmail(String value) {
//   String pattern =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   RegExp regex = RegExp(pattern);
//   return (!regex.hasMatch(value)) ? false : true;
// }
// bool validateName(String value){
//   String pattern = r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
//   RegExp regex = RegExp(pattern);
//   return (!regex.hasMatch(value)) ? false : true;
// }

// ignore: camel_case_extensions
extension extString on String {
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
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^\+?0[0-9]{9}$");
    return phoneRegExp.hasMatch(this);
  }

}