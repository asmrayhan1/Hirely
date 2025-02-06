import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final int maxLine;
  final TextEditingController controller;  // Pass the controller from parent
  final BuildContext context;
  final String hintTxt;
  final Function(String, BuildContext) onSubmittedValue;
  const CustomField({super.key, required this.maxLine, required this.controller, required this.context, required this.hintTxt, required this.onSubmittedValue});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      if (!_focusNode.hasFocus) {
        widget.onSubmittedValue(widget.controller.text.trim(), widget.context);
      }
      if (kDebugMode) {
        print("Password Working");
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
      controller: widget.controller,
      focusNode: _focusNode,
      maxLines: widget.maxLine,
      style: const TextStyle(
          color: Color(0xff262626),
          fontSize: 17,
          fontWeight: FontWeight.w400
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintTxt,
        hintStyle: const TextStyle(color: Colors.blueGrey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _focusNode.hasFocus? const Color(0xff188273) : Colors.white60, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _focusNode.hasFocus? const Color(0xff188273) : Colors.white60, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      ),
    );
  }
}
