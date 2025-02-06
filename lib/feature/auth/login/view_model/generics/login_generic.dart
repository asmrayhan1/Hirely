class LoginGeneric{
  bool isEmail;
  bool isPassword;
  LoginGeneric({this.isEmail = false, this.isPassword = false});
  LoginGeneric update({bool? isEmail, bool? isPassword}) {
    return LoginGeneric(
        isEmail: isEmail?? this.isEmail,
        isPassword: isPassword?? this.isPassword
    );
  }
}