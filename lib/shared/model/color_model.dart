import 'dart:ui';

class ColorModel {
  final Color borderColor;
  final Color insideColor;

  ColorModel({required this.borderColor, required this.insideColor});
}

List<ColorModel> colorList = [
  ColorModel(borderColor: Color(0xff296ffd), insideColor: Color(0xffdce3fa)),
  ColorModel(borderColor: Color(0xfff04438), insideColor: Color(0xfffee4e2)),
  ColorModel(borderColor: Color(0xfff79009), insideColor: Color(0xfffffaeb)),
  ColorModel(borderColor: Color(0xff17b26a), insideColor: Color(0xffecfdf3)),
];