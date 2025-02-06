import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../generics/login_generic.dart';

final loginProvider = StateNotifierProvider<LoginController, LoginGeneric> ((ref) => LoginController());

class LoginController extends StateNotifier<LoginGeneric> {
  LoginController() : super(LoginGeneric());

  Future<void> updateStatus({required bool isEmail, required bool isPassword}) async {
    state = state.update(isEmail: isEmail, isPassword: isPassword);
  }
}