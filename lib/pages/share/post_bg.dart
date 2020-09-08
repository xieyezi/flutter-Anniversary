// 背景图
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Background {
  // 屏幕的宽度
  double screenWidth = 750;

  // 屏幕的高度
  double screenHeight = 1334;

  // 加载的背景图片
  ui.Image image;

  String url;

  // 构造函数
  Background({this.url});

  // 初始化, 各种资源
  Future<VoidCallback> init() async {
    image = await Utils.loadImageByProvider(CachedNetworkImageProvider(url));
  }

  // 绘图函数
  paint(Canvas canvas, Size size) async {
    Rect screenWrap =
        Offset(0.0, 0.0) & Size(screenWidth * 0.4, screenHeight * 0.4);
    Paint screenWrapPainter = new Paint();
    screenWrapPainter.color = Colors.red;
    screenWrapPainter.style = PaintingStyle.fill;
    canvas.drawRect(screenWrap, screenWrapPainter);
    canvas.save();
    canvas.scale(0.4, 0.4);
    Paint paint = new Paint();
    canvas.drawImageRect(
        image,
        Offset(0.0, 0.0) &
            Size(image.width.toDouble(), image.height.toDouble()),
        Offset(0.0, 0.0) & Size(screenWidth, screenHeight),
        paint);
    canvas.restore();
  }
}