import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/pages/share/utils.dart';
import 'package:flutter/material.dart';

class PostAvatar {
  ui.Image image;
  String nickName;

  PostAvatar();

  @override
  void init() async {
    nickName = '时光';
    image = await Utils.loadImageByProvider(
        CachedNetworkImageProvider('https://i.loli.net/2020/09/09/ERKPs9iMJGSvk8V.png'));
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    Paint paint = new Paint();
    canvas.scale(0.35, 0.35);
    print(image.width);

    var textLeft = 180.0;
    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: 36.0,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      ),
    )
      ..pushStyle(
        ui.TextStyle(color: Colors.white, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText(nickName);
    ui.Paragraph paragraph = paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: 500.0));
    canvas.drawParagraph(paragraph, Offset(textLeft, 1330.0));

    ui.ParagraphBuilder paragraphBuilder2 = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: 36.0,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      ),
    )
      ..pushStyle(
        ui.TextStyle(color: Colors.white, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText('邀您一起加入时光旅行');
    ui.Paragraph paragraph2 = paragraphBuilder2.build()..layout(ui.ParagraphConstraints(width: 500.0));
    canvas.drawParagraph(paragraph2, Offset(textLeft, 1380.0));

    ui.ParagraphBuilder paragraphBuilder3 = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: 32.0,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      ),
    )
      ..pushStyle(
        ui.TextStyle(color: Colors.white, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText('阿里云技术支持');
    ui.Paragraph paragraph3 = paragraphBuilder3.build()..layout(ui.ParagraphConstraints(width: 500.0));
    canvas.drawParagraph(paragraph3, Offset(textLeft, 1430.0));

    var radius = image.width.toDouble() / 2;
    var top = 1350.0;
    var left = 30.0;
    canvas.clipRRect(
        RRect.fromRectXY(Rect.fromLTWH(left, top, image.width.toDouble(), image.width.toDouble()), radius, radius),
        doAntiAlias: false);
    canvas.drawImageRect(image, Offset(0.0, 0.0) & Size(400, 400), Offset(left, top) & Size(400.0, 400.0), paint);
    canvas.restore();
  }
}
