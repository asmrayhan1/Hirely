class SignupGenerics{
  bool isEmail;
  bool isPassword;
  bool isName;
  bool isConfirmPassword;
  bool isPhone;
  SignupGenerics({this.isName = false, this.isConfirmPassword = false, this.isPhone = false, this.isEmail = false, this.isPassword = false});
  SignupGenerics update({bool? isName, bool? isConfirmPassword, bool? isPhone, bool? isEmail, bool? isPassword}) {
    return SignupGenerics(
      isName: isName?? this.isName,
      isConfirmPassword: isConfirmPassword?? this.isConfirmPassword,
      isPhone: isPhone?? this.isPhone,
      isEmail: isEmail?? this.isEmail,
      isPassword: isPassword?? this.isPassword,
    );
  }
}