import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/core/service/auth_controller.dart';
import 'package:hirely/feature/dashboard/view/recruiter/recruiter_dashboard.dart';
import 'package:hirely/feature/dashboard/view/talent/talent_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/extentions/image_path.dart';
import '../../../../core/service/auth_service.dart';
import '../../../../core/validation/validation.dart';
import '../../../../shared/containers/custom_button.dart';
import '../../../../shared/containers/custom_image.dart';
import '../../../../shared/text_field/custom_password_field.dart';
import '../../../../shared/text_field/custom_text_field.dart';
import '../../../../shared/widgets/utils/toast.dart';
import '../../register/view/signup_screen.dart';
import '../view_model/controller/login_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String _email = "", _password = "";
  bool isEmail = false, isPassword = false;

  void _onEmail(String email, BuildContext context) {
    setState(() {
      _email = email;
      isEmail = Validation.emailValidity(email: email, context: context);
      ref.read(loginProvider.notifier).updateStatus(isEmail: false, isPassword: ref.watch(loginProvider).isPassword);
    });
  }
  void _onPassword(String password, BuildContext context) {
    setState(() {
      _password = password;
      isPassword = Validation.passwordValidity(password: password, context: context);
      ref.read(loginProvider.notifier).updateStatus(isEmail: ref.watch(loginProvider).isEmail, isPassword: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 2.25;
    double h = MediaQuery.of(context).size.height / 2.25;
    final home = ref.watch(loginProvider);
    return Scaffold(
      backgroundColor: const Color(0xfff2f6fb),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 69, right: 56, top: h / 6),
                child: CustomImage(
                  height: w,
                  width: w,
                  imagePath: ImagePath.logo,
                ),
              ),
              const SizedBox(height: 40.59),
              SizedBox(
                height: 63,
                child: CustomTextField(
                    hintText: "Email", onSubmittedValue: _onEmail, borderColor: (!isEmail && home.isEmail)? Colors.red : Colors.white60, context: context, iconUrl: ImagePath.email
                ),
              ),
              const SizedBox(height: 16.74),
              SizedBox(height: 63,
                child: CustomPasswordField(
                    hintText: "Password", onSubmittedValue: _onPassword, borderColor: (!isPassword && home.isPassword)? Colors.red : Colors.white60, context: context, iconUrl: ImagePath.lock
                ),
              ),
              const SizedBox(height: 26.73),
              GestureDetector(
                onTap: () async {
                  ref.read(loginProvider.notifier).updateStatus(isEmail: true, isPassword: true);
                  if (!isEmail) {
                    Toast.showToast(context: context,
                        message: "Invalid Email Address!",
                        isWarning: true);
                  } else if (!isPassword) {
                    Toast.showToast(context: context,
                        message: "At least 6 length & 1 special,digit,small,capital character!",
                        isWarning: true);
                  } else {
                    try {
                      AuthServices authServices = AuthServices();
                      // Await the login result
                      final UserCredential credential = await authServices.login(_email, _password);
                      User? user = credential.user;
                      if (user != null) {
                        setState(() {
                          userEmail = user.email;
                        });

                        // Check if the email is verified
                        if (user.emailVerified) {
                          if (kDebugMode) {
                            print("User email: ${user.email}");
                          }
                          await ref.read(authProvider.notifier).authInitialize(email: user.email!);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('email', ref.watch(authProvider).email!);
                          await prefs.setBool('role', ref.watch(authProvider).role!);
                          if (ref.watch(authProvider).role != null && ref.watch(authProvider).role == true) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RecruiterDashboard()));
                          } else {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TalentDashboard()));
                          }
                        } else {
                          // If email is not verified, send the verification email and notify the user
                          await user.sendEmailVerification();
                          Toast.showToast(context: context, message: "A verification link is sent to $_email. Verify your account to login");
                        }
                      }
                    } catch (e) {
                      AuthServices().logout();
                      Toast.showToast(context: context, message: "Server Error! $e}");
                      if (kDebugMode) {
                        print("Login Button Working, $isEmail $isPassword $e");
                      }
                    }
                  }
                },
                child: const CustomButton(
                    title: "Log In",
                    buttonColor: "0xff17a38f",
                    txtSize: 16.74,
                    fntWeight: FontWeight.w500,
                    txtColor: "0xffffffff"
                ),
              ),
              const SizedBox(height: 8.37),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text("Don't have an account? ", style: TextStyle(fontSize: 12.56, fontWeight: FontWeight.w400)),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                        },
                        child: const Text("Sign Up", style: TextStyle(fontSize: 12.56, fontWeight: FontWeight.bold, color: Color(0xff188273)))
                      ),
                    ],
                  ),
                  GestureDetector (
                      onTap: () async {
                        await AuthServices().resetPassword(_email);
                        Toast.showToast(context: context, message: "A password reset link is sent to your email");
                      },
                      child: Text("Forget Password?", style: TextStyle(fontSize: 12.56, fontWeight: FontWeight.w400))
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}