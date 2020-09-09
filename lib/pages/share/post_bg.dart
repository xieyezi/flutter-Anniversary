// 背景图
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/pages/share/utils.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Background {
  // 屏幕的宽度
  double screenWidth;

  // 屏幕的高度
  double screenHeight;

  // 加载的背景图片
  ui.Image image;

  String url;

  // 构造函数
  Background({this.url, this.screenWidth, this.screenHeight});

  // 初始化, 各种资源
  Future<VoidCallback> init() async {
    image = await Utils.loadImageByProvider(CachedNetworkImageProvider(url));
  }

  // 绘图函数
  paint(Canvas canvas, Size size) async {
    Rect screenWrap = Offset(0.0, 0.0) & Size(screenWidth, screenHeight);
    Paint screenWrapPainter = new Paint();
    screenWrapPainter.color = Colors.white;
    screenWrapPainter.style = PaintingStyle.fill;
    canvas.drawRect(screenWrap, screenWrapPainter);
    canvas.save();
    // canvas.scale(1, 1);
    Paint paint = new Paint();
    canvas.drawImageRect(image, Offset(0.0, 0.0) & Size(image.width.toDouble(), image.height.toDouble()),
        Offset(0.0, 0.0) & Size(screenWidth, screenHeight), paint);
    canvas.restore();
  }
}
