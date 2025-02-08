import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extentions/image_path.dart';
import '../../../shared/containers/custom_container.dart';
import '../../../shared/containers/custom_image.dart';
import '../../post/view_model/job_controller.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final int index;
  const DetailsScreen({super.key, required this.index});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(jobProvider).jobs![widget.index];
    double w = MediaQuery.of(context).size.width - 30;
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

                },
                child: Center(child: CustomContainer(txt: "Apply Now", fntSize: 14, fntWeight: FontWeight.w400, containerColor: Color(0xff188273), containerWidth: w, containerHeight: 50))
              )
            ],
          ),
        ),
      ),
    );
  }
}
