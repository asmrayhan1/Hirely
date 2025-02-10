import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/home/view_model/apply_job_generics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/service/auth_service.dart';
import '../model/apply_job_model.dart';

final applyProvider = StateNotifierProvider<JobApplyController, JobApplyGenerics> ((ref) => JobApplyController());

class JobApplyController extends StateNotifier<JobApplyGenerics> {
  JobApplyController() : super(JobApplyGenerics());

  final SupabaseClient supabase = Supabase.instance.client;
  final authService = AuthService();

  Future<void> applyInitialize() async {
    state = state.update(isLoading: true);
    try {
      final data = await supabase.from('apply').select();

      // Convert each record (Map<String, dynamic>) to JobApplyModel
      List<JobApplyModel> tmpApply = data.map<JobApplyModel>((e) {
        return JobApplyModel.fromMap(e); // Converting the map into the jobApplyModel
      }).toList();

      state = state.update(isLoading: false, newApply: tmpApply);

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

  Future<bool> insertApply({required String name, required String email, required String address,
    required String cv,required String phone, required int jobId}) async {

    state = state.update(isLoading: true);
    try {
      final response = await supabase.from('apply').insert(
          {
            'email': email,
            'name': name,
            'address': address,
            'phone': phone,
            'job_id': jobId,
            'cv': cv
          }
      );
      await applyInitialize();

      if (kDebugMode) {
        print(response);
      }
      state = state.update(isLoading: false);
      return true;
    } catch (e) {
      state = state.update(isLoading: false);
      if (kDebugMode) {
        print("Insert Apply = $e");
      }
      return false;
    }
  }
}