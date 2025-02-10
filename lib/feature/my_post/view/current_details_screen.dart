import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/home/model/apply_job_model.dart';
import 'package:hirely/feature/home/view_model/apply_job_controller.dart';
import 'package:hirely/feature/post/view/edit_post.dart';
import 'package:hirely/shared/widgets/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/containers/custom_container.dart';
import '../../post/view_model/job_controller.dart';

class CurrentDetailsScreen extends ConsumerStatefulWidget {
  final int index;
  final int id;
  const CurrentDetailsScreen({super.key, required this.id, required this.index});

  @override
  ConsumerState<CurrentDetailsScreen> createState() => _CurrentDetailsScreenState();
}

class _CurrentDetailsScreenState extends ConsumerState<CurrentDetailsScreen> {
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<JobApplyModel> applicants = [];
    final home = ref.watch(jobProvider).jobs![widget.index];
    double w = MediaQuery.of(context).size.width - 30;
    final applicantList = ref.watch(applyProvider).applys;
    for (int i = 0; i < applicantList!.length; i++){
      if (applicantList[i].jobId == widget.id){
        applicants.add(applicantList[i]);
      }
    }
    return Scaffold(
      backgroundColor: Color(0xfff2f4f5),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F6FB), //Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            margin: EdgeInsets.all(12.0),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: Color(0xffc0c1ce)
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Icon(Icons.arrow_back, color: Colors.black, size: 20)),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditPost(id: widget.id, index: widget.index)));
            },
            child: Icon(Icons.edit_calendar, size: 28),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () async {
              bool isDeleted = await ref.read(jobProvider.notifier).deleteJob(id: widget.id);
              if (isDeleted){
                Navigator.of(context).pop();
                Toast.showToast(context: context, message: "Post deleted successfully!");
              }
            },
            child: Icon(Icons.delete, size: 28),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(home.title, maxLines: 2, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              SizedBox(height: 15),
              Text("About the job", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              SizedBox(height: 5),
              Text(home.about, maxLines: 20, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
              SizedBox(height: 10),
              Text("Requirements for the role", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              SizedBox(height: 5),
              Text(home.requirement, maxLines: 20, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Expected Salary: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                  Text(home.salary, maxLines: 1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
                ],
              ),
              SizedBox(height: 50),
              Center(child: CustomContainer(txt: "List of Applicants", fntSize: 14, fntWeight: FontWeight.w400, containerColor: Colors.black, containerWidth: w, containerHeight: 50)),
              SizedBox(height: 20),
              applicants.isEmpty ? Center(child: Text("No applicant found!", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: applicants.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 2.0, // This gives the shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // Round the corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(applicants[index].name, maxLines: 2, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                              SizedBox(height: 2),
                              Text("Phone: ${applicants[index].phone}", maxLines: 2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
                              SizedBox(height: 2),
                              Text("Email: ${applicants[index].email}", maxLines: 2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
                              SizedBox(height: 2),
                              Text("Address: ${applicants[index].address}", maxLines: 2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
                              SizedBox(height: 8),
                              GestureDetector(
                                onTap: (){
                                  _launchUrl(Uri.parse(applicants[index].cv));
                                },
                                child: Center(child: CustomContainer(txt: "View CV", fntSize: 14, fntWeight: FontWeight.w400, containerColor: Color(0xff188273), containerWidth: w, containerHeight: 40))
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
            ],
          ),
        ),
      ),
    );
  }
}