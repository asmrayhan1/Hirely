import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/core/service/auth_generics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider = StateNotifierProvider<AuthController, AuthGenerics> ((ref) => AuthController());

class AuthController extends StateNotifier<AuthGenerics> {
  AuthController() : super(AuthGenerics());

  final SupabaseClient authService = Supabase.instance.client;

  Future<void> authInitialize({required String email}) async {
    try {
      final data = await authService.from('info').select().eq('email', email);
      AuthModel user = AuthModel.fromMap(data[0]);
      state = state.update(isRole: user.role, newEmail: user.email);

      if (kDebugMode) {
        print(data);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> insertUser({required String email, required bool role}) async {
    AuthModel user = AuthModel(email: email, role: role);
    try {
      // Check if the email already exists in the database
      final response = await authService.from('info').select('email').eq('email', email);
      if (kDebugMode) {
        print("============ 1 ===========");
      }
      if (response.isNotEmpty){
        if (kDebugMode) {
          print("Insert User Sign in Info $response");
        }
        return;
      }

      if (kDebugMode) {
        print("Insert User Sign in Info $response");
      }

      if (kDebugMode) {
        print("============ 2 ===========");
      }

      final data = await authService.from('info').insert({
        'email': email,
        'role': role,
      });
      if (kDebugMode) {
        print("Data = $data");
      }
      if (kDebugMode) {
        print("============ 3 ===========");
      }
    } catch (e) {
      if (kDebugMode) {
        print("============ 4  $e ===========");
      }
    }
  }
}