import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/profile/view_model/user_generics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/service/auth_service.dart';
import '../model/user_model.dart';

final userProvider = StateNotifierProvider<UserController, UserGenerics> ((ref) => UserController());

class UserController extends StateNotifier<UserGenerics> {
  UserController() : super(UserGenerics());

  final SupabaseClient supabase = Supabase.instance.client;
  final authService = AuthService();

  Future<void> userInitialize() async {
    state = state.update(isLoading: true);
    try {
      final data = await supabase.from('users').select().eq('email', authService.getCurrentUserEmail().toString()).single();
      UserModel user = UserModel.fromMap(data);
      state = state.update(isLoading: false, newUser: user);

      if (kDebugMode) {
        print(data);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      state = state.update(isLoading: false);
    }
  }

  Future<bool> updateUser({required String name, required String phone, required String bio, required File? imgFile, required String address}) async {
    String imgUrl = "";

    state = state.update(isLoading: true);
    if (imgFile != null) {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

      try {
        imgUrl = await supabase.storage.from('images').upload(fileName, imgFile);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        state = state.update(isLoading: false);
        return false;
      }
    }

    UserModel user = UserModel(email: authService.getCurrentUserEmail().toString(), name: name, phone: phone, imgUrl: imgUrl, bio: bio, address: address);
    try {
      final response = await supabase.from('users').update(user.toJson()).eq('email', authService.getCurrentUserEmail().toString());

      await userInitialize();

      if (kDebugMode) {
        print(response);
      }
      state = state.update(isLoading: false);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      state = state.update(isLoading: false);
      return false;
    }
  }

  Future<bool> insertUser({required String email, required String name, required String phone}) async {
    state = state.update(isLoading: true);
    UserModel user = UserModel(email: email, name: name, phone: phone, imgUrl: "", bio: "", address: "");
    try {
      final response = await supabase.from('users').insert({user.toJson()});

      await userInitialize();

      if (kDebugMode) {
        print(response);
      }
      state = state.update(isLoading: false);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      state = state.update(isLoading: false);
      return false;
    }
  }
}