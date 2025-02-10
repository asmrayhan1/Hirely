import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/home/model/apply_job_model.dart';
import 'package:hirely/feature/home/view_model/apply_job_controller.dart';
import 'package:hirely/feature/post/view/edit_post.dart';

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
  List<JobApplyModel> applicants = [];
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(jobProvider).jobs![widget.index];
    double w = MediaQuery.of(context).size.width - 30;
    final applicantList = ref.watch(applyProvider).applys;
    for (int i = 0; i < applicantList!.length; i++){
      if (applicantList[i].id == widget.id){
        applicants.add(applicantList[i]);
      }
    }
    return Scaffold(
      backgroundColor: Colors.white, //Color(0xfff2f4f5),
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
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPost(id: widget.id, index: widget.index)));
                },
                child: Center(child: CustomContainer(txt: "Edit", fntSize: 14, fntWeight: FontWeight.w400, containerColor: Color(0xff188273), containerWidth: w, containerHeight: 50))
              ),
              SizedBox(height: 50),
              Center(child: CustomContainer(txt: "List of Applicants", fntSize: 14, fntWeight: FontWeight.w400, containerColor: Color(0xff188273), containerWidth: w, containerHeight: 50)),
              SizedBox(height: 20),

              // ListView.builder(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemCount: applicantList.length,
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //         onTap: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentDetailsScreen(id: myPost[index].id!, index: indx[index])));
              //         },
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 Container(
              //                   height: 42,
              //                   width: 42,
              //                   decoration: BoxDecoration(
              //                       shape: BoxShape.circle,
              //                       border: Border.all(width: 2, color: Colors.blueAccent),
              //                       color: Colors.blueAccent
              //                   ),
              //                   child: ClipOval(
              //                     child: Image.network(
              //                       fit: BoxFit.cover,
              //                       height: 40,
              //                       width: 40,
              //                       "https://cldryweohlzpfeteqesz.supabase.co/storage/v1/object/public/${myPost[index].img}",
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(width: 8),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Text(myPost[index].userName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              //                     Text(myPost[index].getFormattedDateTime(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400)),
              //                   ],
              //                 )
              //               ],
              //             ),
              //             SizedBox(height: 5),
              //             Text(myPost[index].title, maxLines: 2, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
              //             SizedBox(height: 2),
              //             Text(myPost[index].about, maxLines: 8, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
              //             SizedBox(height: 8),
              //             if (index != myPost.length - 1) Divider(height: 1, color: Colors.grey),
              //             if (index != myPost.length - 1) SizedBox(height: 8),
              //           ],
              //         ),
              //       );
              //     }
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
