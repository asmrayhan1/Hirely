import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../containers/custom_image.dart';

class CustomTextField extends StatefulWidget {
  final Color borderColor;
  final String hintText;
  final String iconUrl;
  final BuildContext context;
  final Function(String, BuildContext) onSubmittedValue;

  const CustomTextField({super.key, required this.hintText, required this.iconUrl, required this.borderColor, required this.context, required this.onSubmittedValue});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      if (!_focusNode.hasFocus) {
        widget.onSubmittedValue(_textController.text.trim(), widget.context);
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
      controller: _textController,
      focusNode: _focusNode,
      style: const TextStyle(
          color: Color(0xff262626),
          fontSize: 17,
          fontWeight: FontWeight.w400
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        prefixIcon:  Container(margin: const EdgeInsets.all(15), child: CustomImage(height: 24, width: 24, imagePath: widget.iconUrl)),
        hintStyle: const TextStyle(color: Colors.blueGrey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _focusNode.hasFocus && widget.borderColor != Colors.red ? const Color(0xff296ffd) : widget.borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _focusNode.hasFocus && widget.borderColor != Colors.red ? const Color(0xff296ffd) : widget.borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      ),
      onChanged: (text){
        widget.onSubmittedValue(_textController.text.trim(), widget.context);
      },
    );
  }
}