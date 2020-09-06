import 'dart:io';
import 'package:flutter/material.dart';

class FileImageFormPath extends StatelessWidget {
  final String imgPath;
  const FileImageFormPath({Key key, this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imgPath),
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      color: Colors.black.withOpacity(0.5),
      colorBlendMode: BlendMode.colorBurn,
    );
  }
}
