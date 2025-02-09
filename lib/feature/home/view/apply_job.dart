import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/shared/widgets/utils/toast.dart';

import '../../../shared/containers/custom_container.dart';

class ApplyJob extends ConsumerStatefulWidget {
  const ApplyJob({super.key});

  @override
  ConsumerState<ApplyJob> createState() => _ApplyJobState();
}

class _ApplyJobState extends ConsumerState<ApplyJob> {

  File? _pdfFile; // To store the selected PDF file

  // Function to pick a PDF file and check its size
  Future<void> pickPdfFile() async {
    // Open file picker to select PDF
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      // Check if the file size is less than 2MB
      int fileSize = await file.length();
      if (fileSize <= 2 * 1024 * 1024) {  // 2MB in bytes
        setState(() {
          _pdfFile = file;
        });
      } else {
        // Show a dialog or toast to inform the user
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("File too large"),
            content: Text("The selected file exceeds the 2MB limit."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: [
              ElevatedButton(
                onPressed: pickPdfFile,
                child: Text("Upload CV in PDF Format"),
              ),
              SizedBox(height: 20),
              // If a PDF is selected, show it in a container
              _pdfFile != null ? Container(
                height: 400,
                child: PDFView(
                  filePath: _pdfFile?.path,
                ),
              ) : Container(
                height: 400,
                color: Colors.grey[300],  // Placeholder
                child: Center(
                  child: Text("No PDF selected"),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: (){
                  if (_pdfFile == null){
                    Toast.showToast(context: context, message: "Please Upload your CV in Pdf format!", isWarning: true);
                  } else {
                    
                  }
                },
                child: CustomContainer(fntWeight: FontWeight.w600, fntSize: 16, txt: "Submit", containerColor: Color(0xff188273), containerWidth: MediaQuery.of(context).size.width - 30, containerHeight: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
