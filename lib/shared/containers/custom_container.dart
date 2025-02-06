import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String txt;
  final double containerHeight;
  final double containerWidth;
  final Color containerColor;
  final FontWeight fntWeight;
  final bool? status;
  final double fntSize;
  const CustomContainer({super.key, this.status, required this.fntWeight, required this.fntSize, required this.txt, required this.containerColor, required this.containerWidth, required this.containerHeight});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.containerHeight,
      width: widget.containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.containerColor,//Color(0xff188273)
      ),
      child: widget.status != null && widget.status! ? Center(child: CircularProgressIndicator()) : Center(
        child: Text(widget.txt, style: TextStyle(fontSize: widget.fntSize, fontWeight: FontWeight.w500, color: Colors.white)),
      ),
    );
  }
}
