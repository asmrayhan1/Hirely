
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/post/model/job_model.dart';
import 'package:hirely/feature/post/view_model/job_generics.dart';
import 'package:hirely/feature/profile/model/user_model.dart';
import 'package:hirely/feature/profile/view_model/user_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/service/auth_service.dart';

final jobProvider = StateNotifierProvider<JobController, JobGenerics> ((ref) => JobController());

class JobController extends StateNotifier<JobGenerics> {
  JobController() : super(JobGenerics());

  final SupabaseClient authService = Supabase.instance.client;

  Future<void> jobInitialize() async {
    state = state.update(isLoading: true);
    try {
      final data = await authService.from('job').select();

      // Convert each record (Map<String, dynamic>) to JobModel
      List<JobModel> tmpJobs = data.map<JobModel>((e) {
        return JobModel.fromMap(e); // Converting the map into the jobModel
      }).toList();

      state = state.update(isLoading: false, newJob: tmpJobs);

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

  Future<bool> insertJob({required String title, required String about, required String requirement,
    required String salary, required String userName, required String img}) async {

    state = state.update(isLoading: true);
    try {
      final response = await authService.from('job').insert(
          {
            'email': userEmail,
            'title': title,
            'about': about,
            'requirement': requirement,
            'salary': salary,
            'user_name': userName,
            'img': img
          }
      );
      await jobInitialize();

      if (kDebugMode) {
        print(response);
      }
      state = state.update(isLoading: false);
      return true;
    } catch (e) {
      state = state.update(isLoading: false);
      if (kDebugMode) {
        print("Insert Job = $e");
      }
      return false;
    }
  }

  Future<bool> updateJob({required int id, required String title, required String about, required String requirement,
    required String salary, required String userName, required String img}) async {

    state = state.update(isLoading: true);

    JobModel updateJob = JobModel(
        id: id, email: userEmail!, title: title, about: about,
        requirement: requirement, salary: salary, userName: userName, img: img
    );
    try {
      final response = await authService.from('job').update(updateJob.toMap()).eq('id', id);

      await jobInitialize();

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

  Future<bool> deleteJob({required int id}) async {
    state = state.update(isLoading: true);
    try {
      final data = await authService.from('job').delete().eq('id', id);
      if (kDebugMode) {
        print(data);
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