import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/profile/view_model/user_controller.dart';
import '../../../shared/containers/custom_container.dart';
import '../../../shared/widgets/utils/toast.dart';
import '../../profile/components/custom_field.dart';
import '../view_model/job_controller.dart';

class EditPost extends ConsumerStatefulWidget {
  final int index;
  final int id;
  const EditPost({super.key, required this.id, required this.index});

  @override
  ConsumerState<EditPost> createState() => _EditPostState();
}

class _EditPostState extends ConsumerState<EditPost> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      setState(() {
        final tmp = ref.watch(jobProvider).jobs![widget.index];
        _title = tmp.title; _about = tmp.about; _requirements = tmp.requirement; _salary = tmp.salary;
        _titleController.text = _title; _aboutController.text = _about; _requirementController.text = _requirements; _salaryController.text = _salary;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(jobProvider);
    final user = ref.watch(userProvider).users;
    return Scaffold(
      backgroundColor: Color(0xfff2f4f5),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F6FB),
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
                      bool isUpdated = await ref.read(jobProvider.notifier).updateJob(id: widget.id, title: _title, about: _about, requirement: _requirements, salary: _salary, userName: user!.name!, img: user.imgUrl!);
                      if (isUpdated){
                        Toast.showToast(context: context, message: "Update Successfully Added!");
                        Navigator.of(context).pop();
                      } else {
                        Toast.showToast(context: context, message: "Server Error, Try again later!", isWarning: true);
                      }
                    }
                  },
                    child: CustomContainer(status: status.isLoading? true : false, fntWeight: FontWeight.w600, fntSize: 16, txt: "Update", containerColor: Color(0xff188273), containerWidth: MediaQuery.of(context).size.width - 40, containerHeight: 50)
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