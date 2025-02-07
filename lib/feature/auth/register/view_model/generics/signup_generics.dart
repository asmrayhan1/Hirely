class SignupGenerics{
  bool isEmail;
  bool isPassword;
  bool isConfirmPassword;
  SignupGenerics({this.isConfirmPassword = false, this.isEmail = false, this.isPassword = false});
  SignupGenerics update({bool? isName, bool? isConfirmPassword, bool? isPhone, bool? isEmail, bool? isPassword}) {
    return SignupGenerics(
      isConfirmPassword: isConfirmPassword?? this.isConfirmPassword,
      isEmail: isEmail?? this.isEmail,
      isPassword: isPassword?? this.isPassword,
    );
  }
}