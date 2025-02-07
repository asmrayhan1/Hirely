import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../generics/signup_generics.dart';

final signupProvider = StateNotifierProvider<SignupController, SignupGenerics> ((ref) => SignupController());

class SignupController extends StateNotifier<SignupGenerics> {
  SignupController() : super(SignupGenerics());

  Future<void> updateStatus({required bool isEmail, required bool isPassword, required bool isConfirmPassword}) async {
    state = state.update(isConfirmPassword: isConfirmPassword, isEmail: isEmail, isPassword: isPassword);
  }
}