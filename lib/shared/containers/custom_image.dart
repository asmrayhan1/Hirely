import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imagePath;
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  const CustomImage({super.key, this.imagePath, this.imageUrl, this.height = 100, this.width = 100, this.fit = BoxFit.cover, this.color});

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return imagePath != null ? Image.network(imagePath!, height: height, width: width, fit: fit, color: color) : const Center(child: Icon(Icons.error));
    } else {
      return imagePath != null ? Image.asset(imagePath!, height: height, width: width, fit: fit, color: color) : const Center(child: Icon(Icons.error));
    }
  }
}