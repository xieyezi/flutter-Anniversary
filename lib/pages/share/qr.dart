import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import './utils.dart';
import 'dart:ui' as ui;

class MainQR {
  ui.Image image;
  String url;

  MainQR({this.url});

  @override
  void init() async {
    image = await Utils.loadImageByProvider(CachedNetworkImageProvider(url));
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    Paint paint = new Paint();
    canvas.scale(0.25, 0.25);
    canvas.drawImageRect(image, Offset(0.0, 0.0) & Size(400, 400), Offset(850.0, 1770.0) & Size(400.0, 400.0), paint);

    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: 36.0,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      ),
    )
      ..pushStyle(
        ui.TextStyle(color: Colors.white, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText('长按识别');
    ui.Paragraph paragraph = paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: 200.0));

    canvas.drawParagraph(paragraph, Offset(885.0, 2050.0));
    canvas.restore();
  }
}
