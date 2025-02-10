import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/core/service/auth_service.dart';
import 'package:hirely/feature/my_post/view/current_details_screen.dart';
import 'package:hirely/feature/post/model/job_model.dart';
import 'package:hirely/feature/post/view_model/job_controller.dart';

import '../../../core/extentions/image_path.dart';
import '../../../shared/containers/custom_image.dart';

class MyPost extends ConsumerStatefulWidget {
  const MyPost({super.key});

  @override
  ConsumerState<MyPost> createState() => _MyPostState();
}

class _MyPostState extends ConsumerState<MyPost> {
  @override
  Widget build(BuildContext context) {
    List<JobModel> myPost = [];
    List<int> indx = [];
    String email = AuthService().getCurrentUserEmail().toString();
    final jobList = ref.watch(jobProvider).jobs;
    for (int i = 0; i < jobList!.length; i++){
      if (jobList[i].email == email){
        myPost.add(jobList[i]);
        indx.add(i);
      }
    }
    return Scaffold(
      backgroundColor: Color(0xfff2f4f5),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F6FB), //Colors.white,
        title: Row(
          children: [
            CustomImage(
              height: 35,
              width: 35,
              imagePath: ImagePath.appbar_logo,
            ),
            Text("Hirely", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff188273)),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: myPost.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CurrentDetailsScreen(id: myPost[index].id!, index: indx[index])));
                      },
                      child: Card(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 2, color: Colors.blueAccent),
                                        color: Colors.blueAccent
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        height: 40,
                                        width: 40,
                                        "https://cldryweohlzpfeteqesz.supabase.co/storage/v1/object/public/${myPost[index].img}",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(myPost[index].userName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                      Text(myPost[index].getFormattedDateTime(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400)),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(myPost[index].title, maxLines: 2, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                              SizedBox(height: 2),
                              Text(myPost[index].about, maxLines: 8, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
                            ],
                          ),
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
