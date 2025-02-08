
import 'package:hirely/feature/post/model/job_model.dart';

class JobGenerics{
  bool isLoading;
  List<JobModel>? jobs;
  JobGenerics({this.isLoading = false, this.jobs});

  JobGenerics update({bool? isLoading, List<JobModel>? newJob}){
    return JobGenerics(
        isLoading: isLoading ?? this.isLoading,
        jobs: newJob ?? jobs
    );
  }
}