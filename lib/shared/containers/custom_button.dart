import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String buttonColor;
  final String txtColor;
  final double txtSize;
  final FontWeight fntWeight;

  const CustomButton({
    super.key,
    required this.title,
    required this.buttonColor,
    required this.txtColor,
    required this.txtSize,
    required this.fntWeight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      decoration: BoxDecoration(
        color: Color(int.parse(buttonColor)),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: Text(title,
          style: TextStyle(fontSize: txtSize, fontWeight: fntWeight, color: Color(int.parse(txtColor))),
        ),
      ),
    );
  }
}