import 'dart:io';
import 'package:flutter/material.dart';

class FileImageFormPath extends StatelessWidget {
  final String imgPath;
  const FileImageFormPath({Key key, this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imgPath),
      color: Colors.black.withOpacity(0.4),
      fit: BoxFit.cover,
      filterQuality: FilterQuality.low,
      colorBlendMode: BlendMode.multiply,
    );
  }
}
