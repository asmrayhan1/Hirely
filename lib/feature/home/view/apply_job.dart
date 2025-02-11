import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/home/view_model/apply_job_controller.dart';
import 'package:hirely/shared/widgets/utils/toast.dart';
import '../../../core/validation/validation.dart';
import '../../../shared/containers/custom_container.dart';
import '../components/job_field.dart';

class ApplyJob extends ConsumerStatefulWidget {
  final int jobId;
  const ApplyJob({super.key, required this.jobId});

  @override
  ConsumerState<ApplyJob> createState() => _ApplyJobState();
}

class _ApplyJobState extends ConsumerState<ApplyJob> {
  String _name = "", _email = "", _phone = "", _location = "", _cv = "";
  bool isEmail = false, isPhone = false;

  void _onName(String name) {
    setState(() {
      _name = name;
    });
  }
  void _onEmail(String email) {
    setState(() {
      _email = email;
      isEmail = Validation.email(email: email);
    });
  }
  void _onPhone(String phone) {
    setState(() {
      _phone = phone;
      isPhone = Validation.phone(phone: _phone);
    });
  }
  void _onLocation(String location) {
    setState(() {
      _location = location;
    });
  }
  void _onCv(String cv) {
    setState(() {
      _cv = cv;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text("Apply Now", style: TextStyle(color: Color(0xff188273), fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: JobField(
                    hintText: "Name", onSubmittedValue: _onName, icon: Icon(Icons.person, size: 24)
                ),
              ),
              const SizedBox(height: 16.74),
              SizedBox(
                height: 60,
                child: JobField(
                    hintText: "Email", onSubmittedValue: _onEmail, icon: Icon(Icons.email_outlined, size: 24)
                ),
              ),
              const SizedBox(height: 16.74),
              SizedBox(
                height: 60,
                child: JobField(
                    hintText: "Phone", onSubmittedValue: _onPhone, icon: Icon(Icons.phone, size: 24)
                ),
              ),
              const SizedBox(height: 16.74),
              SizedBox(
                height: 60,
                child: JobField(
                    hintText: "Address", onSubmittedValue: _onLocation, icon: Icon(Icons.location_on_outlined, size: 24)
                ),
              ),
              const SizedBox(height: 16.74),
              SizedBox(
                height: 60,
                child: JobField(
                    hintText: "Attach CV Link", onSubmittedValue: _onCv, icon: Icon(Icons.file_copy_outlined, size: 24)
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  if (_name.length < 3){
                    Toast.showToast(context: context, message: "Name at least consists 3 characters!", isWarning: true);
                  } else if (!isEmail){
                    Toast.showToast(context: context, message: "Invalid email Address!", isWarning: true);
                  } else if (!isPhone){
                    Toast.showToast(context: context, message: "Invalid phone number!", isWarning: true);
                  } else if (_location.length < 4){
                    Toast.showToast(context: context, message: "Address at least consists 4 characters!", isWarning: true);
                  } else if (_cv.length < 10){
                    Toast.showToast(context: context, message: "CV link at least consists 10 characters!", isWarning: true);
                  } else {
                    bool isApply = await ref.read(applyProvider.notifier).insertApply(name: _name, email: _email, address: _location, cv: _cv, phone: _phone, jobId: widget.jobId);
                    if (isApply){
                      Navigator.of(context).pop();
                      Toast.showToast(context: context, message: "Apply done successfully!");
                    }
                  }
                },
                child: Center(child: CustomContainer(status: ref.watch(applyProvider).isLoading? true : false, fntWeight: FontWeight.w600, fntSize: 16, txt: "Submit", containerColor: Color(0xff188273), containerWidth: MediaQuery.of(context).size.width - 30, containerHeight: 50)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
