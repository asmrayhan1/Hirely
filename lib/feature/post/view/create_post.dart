import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/post/view_model/job_controller.dart';
import 'package:hirely/feature/profile/view_model/user_controller.dart';
import '../../../core/extentions/image_path.dart';
import '../../../shared/containers/custom_container.dart';
import '../../../shared/containers/custom_image.dart';
import '../../../shared/widgets/utils/toast.dart';
import '../../profile/components/custom_field.dart';

class CreatePost extends ConsumerStatefulWidget {
  const CreatePost({super.key});

  @override
  ConsumerState<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends ConsumerState<CreatePost> {
  String _title = "", _about = "", _requirements = "", _salary = "";
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _requirementController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  void _onTitle(String title, BuildContext context){
    setState(() {
      _title = title;
    });
  }
  void _onAbout(String about, BuildContext context){
    setState(() {
      _about = about;
    });
  }
  void _onRequirements(String requirements, BuildContext context){
    setState(() {
      _requirements = requirements;
    });
  }
  void _onSalary(String salary, BuildContext context){
    setState(() {
      _salary = salary;
    });
  }

  void _resetForm() {
    setState(() {
      _title = _about = _requirements = _salary = "";
      _titleController.clear(); _aboutController.clear(); _requirementController.clear(); _salaryController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(jobProvider);
    final user = ref.watch(userProvider).users;
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" Title", style: TextStyle(color: Color(0xff101828), fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 5),
                SizedBox(height: 50, child: CustomField(maxLine: 1, controller: _titleController, context: context, hintTxt: "Title", onSubmittedValue: _onTitle)),
                SizedBox(height: 20),
                Text(" About the job", style: TextStyle(color: Color(0xff101828), fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 5),
                CustomField(maxLine: 10, controller: _aboutController, context: context, hintTxt: "About", onSubmittedValue: _onAbout),
                SizedBox(height: 20),
                Text(" Requirements for the role", style: TextStyle(color: Color(0xff101828), fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 5),
                CustomField(maxLine: 10, controller: _requirementController, context: context, hintTxt: "Requirements", onSubmittedValue: _onRequirements),
                SizedBox(height: 20),
                Text(" Expected Salary", style: TextStyle(color: Color(0xff101828), fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 5),
                SizedBox(height: 50, child: CustomField(maxLine: 1, controller: _salaryController, context: context, hintTxt: "Salary Range", onSubmittedValue: _onSalary)),
                SizedBox(height: 50),
                Center(
                    child: GestureDetector(
                        onTap: (){
                          _resetForm();
                        },
                        child: CustomContainer(fntWeight: FontWeight.w600, fntSize: 16, txt: "Clear", containerColor: Colors.blueGrey, containerWidth: MediaQuery.of(context).size.width - 40, containerHeight: 50)
                    )
                ),
                SizedBox(height: 10),
                Center(
                    child: GestureDetector(
                        onTap: () async {
                          if (_title.isEmpty) {
                            Toast.showToast(context: context, message: "Title field can't empty!", isWarning: true);
                          } else if (_about.isEmpty){
                            Toast.showToast(context: context, message: "About field can't empty!", isWarning: true);
                          } else if (_requirements.isEmpty){
                            Toast.showToast(context: context, message: "Requirements field can't empty!", isWarning: true);
                          } else if (_salary.isEmpty){
                            Toast.showToast(context: context, message: "Salary field can't empty!", isWarning: true);
                          } else {
                            if (user?.imgUrl != null) {
                              bool isInserted = await ref.read(
                                  jobProvider.notifier).insertJob(title: _title,
                                  about: _about,
                                  requirement: _requirements,
                                  salary: _title,
                                  userName: user!.name!,
                                  img: user.imgUrl!);
                              if (isInserted) {
                                Toast.showToast(context: context,
                                    message: "Post Successfully Added!");
                                _resetForm();
                              } else {
                                Toast.showToast(context: context,
                                    message: "Server Error, Try again later!",
                                    isWarning: true);
                              }
                            } else {
                              Toast.showToast(context: context, message: "Please Fill your Profile", isWarning: true);
                            }
                          }
                        },
                        child: CustomContainer(status: status.isLoading? true : false, fntWeight: FontWeight.w600, fntSize: 16, txt: "Add Post", containerColor: Color(0xff188273), containerWidth: MediaQuery.of(context).size.width - 40, containerHeight: 50)
                    )
                ),
                SizedBox(height: 10),
              ],
            )
        ),
      ),
    );
  }
}
