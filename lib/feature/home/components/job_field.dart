import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JobField extends StatefulWidget {
  final String hintText;
  final Icon icon;
  final Function(String) onSubmittedValue;
  const JobField({super.key, required this.hintText, required this.icon, required this.onSubmittedValue});

  @override
  State<JobField> createState() => _JobFieldState();
}

class _JobFieldState extends State<JobField> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      if (!_focusNode.hasFocus) {
        widget.onSubmittedValue(_textController.text.trim());
      }
      if (kDebugMode) {
        print("Job Apply Working");
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      style: const TextStyle(
          color: Color(0xff262626),
          fontSize: 17,
          fontWeight: FontWeight.w400
      ),
      maxLines: 1,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        prefixIcon:  Container(margin: const EdgeInsets.all(15), child: widget.icon),
        hintStyle: const TextStyle(color: Colors.blueGrey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _focusNode.hasFocus ? const Color(0xff296ffd) : Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _focusNode.hasFocus ? const Color(0xff296ffd) : Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      ),
      onChanged: (text){
        widget.onSubmittedValue(_textController.text.trim());
      },
    );
  }
}
