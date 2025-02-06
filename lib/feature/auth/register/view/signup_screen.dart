import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/extentions/image_path.dart';
import '../../../../core/validation/validation.dart';
import '../../../../home.dart';
import '../../../../shared/containers/custom_button.dart';
import '../../../../shared/containers/custom_image.dart';
import '../../../../shared/text_field/custom_password_field.dart';
import '../../../../shared/text_field/custom_text_field.dart';
import '../../../../shared/widgets/utils/toast.dart';
import '../../login/view/login_screen.dart';
import '../view_model/controller/signup_controller.dart';

String insertName = "";
String insertPhone = "";
String insertEmail = "";

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignupScreen> {
  bool isName = false, isPhone = false, isEmail = false, isPassword = false, isConfirmPassword = false;
  String _name = "", _phone = "", _email = "", _password = "", _confirmPassword = "";

  void _onName(String name, BuildContext context) {
    setState(() {
      _name = name;
      isName = Validation.nameValidity(name: name, context: context);
      late final status = ref.watch(signupProvider);
      ref.read(signupProvider.notifier).updateStatus(isEmail: status.isEmail, isPassword: status.isPassword, isName: false, isConfirmPassword: status.isConfirmPassword, isPhone: status.isPhone);
    });
  }

  void _onPhone(String phone, BuildContext context) {
    setState(() {
      _phone = phone;
      isPhone = Validation.phoneValidity(phone: phone, context:  context);
      late final status = ref.watch(signupProvider);
      ref.read(signupProvider.notifier).updateStatus(isEmail: status.isEmail, isPassword: status.isPassword, isName: status.isName, isConfirmPassword: status.isConfirmPassword, isPhone: false
      );
    });
  }
  void _onEmail(String email, BuildContext context) {
    setState(() {
      _email = email;
      isEmail = Validation.emailValidity(email: email, context: context);
      late final status = ref.watch(signupProvider);
      ref.read(signupProvider.notifier).updateStatus(isEmail: false, isPassword: status.isPassword, isName: status.isName, isConfirmPassword: status.isConfirmPassword, isPhone: status.isPhone);
    });
  }
  void _onPassword(String password, BuildContext context) {
    setState(() {
      _password = password;
      isPassword = Validation.passwordValidity(password: password, context: context);
      late final status = ref.watch(signupProvider);
      ref.read(signupProvider.notifier).updateStatus(isEmail: status.isEmail, isPassword: false, isName: status.isName, isConfirmPassword: status.isConfirmPassword, isPhone: status.isPhone);
    });
  }
  void _onConfirmPassword(String password, BuildContext context) {
    setState(() {
      _confirmPassword = password;
      isConfirmPassword = Validation.passwordValidity(password: password, context: context);
      late final status = ref.watch(signupProvider);
      ref.read(signupProvider.notifier).updateStatus(isEmail: status.isEmail, isPassword: status.isPassword, isName: status.isName, isConfirmPassword: false, isPhone: status.isPhone);
    });
  }
   bool isClicked1 = false;
   bool isClicked2 = false;
  void _isClicked(int op){
    setState(() {
      if (op == 1) {
        isClicked1 = !isClicked1;
        isClicked2 = false;
      } else if (op == 2) {
        isClicked2 = !isClicked2;
        isClicked1 = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 2.25;
    final status = ref.watch(signupProvider);
    return Scaffold(
      backgroundColor: const Color(0xfff2f6fb),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 69, right: 56, top: 67),
                child: CustomImage(
                  height: w,
                  width: w,
                  imagePath: ImagePath.logo,
                ),
              ),
              const SizedBox(height: 20.59),
              SizedBox(height: 63, child: CustomTextField(hintText: "Name", borderColor: (!isName && status.isName)? Colors.red : Colors.white60, context: context, onSubmittedValue: _onName, iconUrl: ImagePath.user)),
              const SizedBox(height: 16.74),
              SizedBox(height: 63, child: CustomTextField(hintText: "Phone", borderColor: (!isPhone && status.isPhone)? Colors.red : Colors.white60, context: context, onSubmittedValue: _onPhone, iconUrl: ImagePath.phone)),
              const SizedBox(height: 16.74),
              SizedBox(height: 63, child: CustomTextField(hintText: "Email", borderColor: (!isEmail && status.isEmail)? Colors.red : Colors.white60, context: context, onSubmittedValue: _onEmail, iconUrl: ImagePath.email)),
              const SizedBox(height: 16.74),
              SizedBox(height: 63, child: CustomPasswordField(hintText: "Password", borderColor: (!isPassword && status.isPassword)? Colors.red : Colors.white60, context: context, onSubmittedValue: _onPassword, iconUrl: ImagePath.lock)),
              const SizedBox(height: 16.74),
              SizedBox(height: 63, child: CustomPasswordField(hintText: "Confirm Password", borderColor: (!isConfirmPassword && status.isConfirmPassword)? Colors.red : Colors.white60, context: context, onSubmittedValue: _onConfirmPassword, iconUrl: ImagePath.lock)),
              const SizedBox(height: 12.74),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Select Your Role?', style: TextStyle(fontSize: 12.56, fontWeight: FontWeight.w400)),
                  SizedBox(width: 16.74),
                  GestureDetector(
                    onTap: (){
                      _isClicked(1);
                    },
                    child: Icon(isClicked1? Icons.check_box : Icons.check_box_outline_blank_outlined, size: 20),
                  ),
                  SizedBox(width: 3),
                  Text('Recruiter', style: TextStyle(fontSize: 12.56, fontWeight: FontWeight.w400)),
                  SizedBox(width: 16.74),
                  GestureDetector(
                    onTap: (){
                      _isClicked(2);
                    },
                    child: Icon(isClicked2? Icons.check_box : Icons.check_box_outline_blank_outlined, size: 20),
                  ),
                  SizedBox(width: 3),
                  Text('Talent', style: TextStyle(fontSize: 12.56, fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(height: 30.73),
              GestureDetector(
                onTap: () async {
                  ref.read(signupProvider.notifier).updateStatus(isName: true, isConfirmPassword: true, isPhone: true, isEmail: true, isPassword: true);
                  if (!isName){
                    Toast.showToast(context: context, message: "Invalid Name!", isWarning: true);
                  } else if (!isPhone){
                    Toast.showToast(context: context, message: "Invalid Phone number", isWarning: true);
                  } else if (!isEmail){
                    Toast.showToast(context: context, message: "Invalid Email format!", isWarning: true);
                  } else if (!isPassword){
                    Toast.showToast(context: context, message: "Password at least contains 6 characters!", isWarning: true);
                  } else if (!isConfirmPassword){
                    Toast.showToast(context: context, message: "Password at least contains 6 characters!", isWarning: true);
                  } else if (_password != _confirmPassword){
                    Toast.showToast(context: context, message: "Password & Confirmed Password not matched!", isWarning: true);
                  } else if (!isClicked1 || !isClicked2 || (isClicked1 && isClicked2)){
                    Toast.showToast(context: context, message: "Please select your role!", isWarning: true);
                  } else {
                    try {
                      // await authService.signUpWIthEmailPassword(_email, _password);
                      //
                      // setState(() {
                      //   insertName = _name;
                      //   insertPhone = _phone;
                      //   insertEmail = _email;
                      // });
                      //   Toast.showToast(context: context,
                      //       message: "Registered Successfully!");
                      //   if (_email == "rc295908@gmail.com") {
                      //     isAdmin = true;
                      //     Navigator.of(context).pushReplacement(
                      //       MaterialPageRoute(
                      //         builder: (context) => const AdminDashboard(),
                      //       ),
                      //     );
                      //     Toast.showToast(
                      //         context: context, message: "Successfully Login");
                      //   } else {
                      //     isAdmin = false;
                      //     Navigator.of(context).pushReplacement(
                      //       MaterialPageRoute(
                      //         builder: (context) => const UserDashboard(),
                      //       ),
                      //     );
                      //     Toast.showToast(
                      //         context: context, message: "Successfully Login");
                      //   }
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                      Toast.showToast(context: context, message: "Please provide valid information!", isWarning: true);
                    }
                  }
                  if (kDebugMode) {
                    print("SignUp Button Working. $isName $isConfirmPassword $isPhone  $isEmail $isPassword");
                  }
                },
                child: const CustomButton(
                  title: "Sign Up",
                  buttonColor: "0xff17a38f",
                  txtSize: 16.74,
                  fntWeight: FontWeight.w500,
                  txtColor: "0xffffffff"),
              ),
              const SizedBox(height: 8.37),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Already have an account? ", style: TextStyle(fontSize: 12.56, fontWeight: FontWeight.w400)),
                      GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                          child: const Text("Log In", style: TextStyle(fontSize: 12.56, fontWeight: FontWeight.bold, color: Color(0xff188273)))
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}