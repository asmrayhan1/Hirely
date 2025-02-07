import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/validation/validation.dart';
import '../../../shared/containers/custom_container.dart';
import '../../../shared/widgets/utils/toast.dart';
import '../components/custom_field.dart';
import '../view_model/user_controller.dart';

class EditInfoScreen extends ConsumerStatefulWidget {
  const EditInfoScreen({super.key});

  @override
  ConsumerState<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends ConsumerState<EditInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _name = "", _bio = "", _phone = "", _address = "";
  bool isName = false, isPhone = false, isBio = false, isAddress = false;
  void _onName(String name, BuildContext context){
    setState(() {
      _name = name;
      isName = Validation.nameValidity(name: name, context: context);
    });
  }
  void _onBio(String bio, BuildContext context){
    setState(() {
      _bio = bio;
      isBio = Validation.bioValidity(bio: bio, context: context);
    });
  }
  void _onPhone(String phone, BuildContext context){
    setState(() {
      _phone = phone;
      isPhone = Validation.phoneValidity(phone: phone, context: context);
    });
  }
  void _onAddress(String address, BuildContext context){
    setState(() {
      _address = address;
      isAddress = Validation.addressValidity(address: address, context: context);
    });
  }
  File? _image;

  // Function to pick an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();

    // Pick image from gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      final user = ref.watch(userProvider).users;
      if (user != null){
        setState(() {
          isName = isBio = isAddress = isPhone = true;
          _name = user.name!; _phone = user.phone!; _bio = user.bio!; _address = user.address!;
          _nameController.text = _name; _phoneController.text = _phone; _addressController.text = _address; _bioController.text = _bio;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(userProvider).users;
    return Scaffold(
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
      backgroundColor: Color(0xfff2f4f7),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the picked image in a square container
              _image == null ? Center(
                child: status?.imgUrl == null ? Container(
                  width: 200,
                  height: 200,
                  color: Colors.grey[200], // Placeholder when no image is selected
                  child: Center(child: Text("No Image")),
                ) : SizedBox(
                  width: 200,
                  height: 200,
                  child: ClipRRect(
                    child: Image.network(
                        "https://cldryweohlzpfeteqesz.supabase.co/storage/v1/object/public/${status?.imgUrl}"
                    ),
                  ),
                ),
              ) : Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover, // Ensure image covers the square box
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Custom Styled Button
              Center(
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black), // Custom Color
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                    )),
                    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 32, vertical: 5)), // Padding for the button
                  ),
                  child: Text("Pick Image", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              Text(" Name", style: TextStyle(color: Color(0xff101828), fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              CustomField(maxLine: 1, controller: _nameController, context: context, hintTxt: "Name", onSubmittedValue: _onName),
              SizedBox(height: 20),
              Text(" Bio", style: TextStyle(color: Color(0xff101828), fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              CustomField(maxLine: 1, controller: _bioController, context: context, hintTxt: "Bio", onSubmittedValue: _onBio),
              SizedBox(height: 20),
              Text(" Phone", style: TextStyle(color: Color(0xff101828), fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              CustomField(maxLine: 1, controller: _phoneController, context: context, hintTxt: "Phone", onSubmittedValue: _onPhone),
              SizedBox(height: 20),
              Text(" Address", style: TextStyle(color: Color(0xff101828), fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              CustomField(maxLine: 1, controller: _addressController, context: context, hintTxt: "Address", onSubmittedValue: _onAddress),
              SizedBox(height: 40),

              Center(
                  child: GestureDetector(
                      onTap: () async {
                        if (!isName) {
                          Toast.showToast(context: context, message: "invalid Name!", isWarning: true);
                        } else if (!isBio){
                          Toast.showToast(context: context, message: "Invalid Bio!", isWarning: true);
                        } else if (!isPhone){
                          Toast.showToast(context: context, message: "Invalid Phone Number!", isWarning: true);
                        } else if (!isAddress){
                          Toast.showToast(context: context, message: "Invalid Address!", isWarning: true);
                        } else {
                          bool isUpdated = await ref.read(userProvider.notifier).updateUser(name: _name, phone: _phone, bio: _bio, imgFile: _image, address: _address);
                          if (isUpdated){
                            Toast.showToast(context: context, message: "Profile Updated Successfully");
                            Navigator.of(context).pop();
                          } else {
                            Toast.showToast(context: context, message: "Server Error", isWarning: true);
                          }
                        }
                      },
                      child:  CustomContainer(status: ref.watch(userProvider).isLoading ? true : false, fntWeight: FontWeight.w600, fntSize: 16, txt: "Save", containerColor: Color(0xff188273), containerWidth: MediaQuery.of(context).size.width - 40, containerHeight: 45)
                  )
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
