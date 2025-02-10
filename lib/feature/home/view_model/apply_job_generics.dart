import 'package:hirely/feature/home/model/apply_job_model.dart';

class JobApplyGenerics{
  bool isLoading;
  List<JobApplyModel>? applys;
  JobApplyGenerics({this.isLoading = false, this.applys});

  JobApplyGenerics update({bool? isLoading, List<JobApplyModel>? newApply}){
    return JobApplyGenerics(
        isLoading: isLoading ?? this.isLoading,
        applys: newApply ?? applys
    );
  }
}