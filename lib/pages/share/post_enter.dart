import 'package:daily/pages/share/post_avatar.dart';
import 'package:daily/pages/share/post_bg.dart';
import 'package:daily/pages/share/qr.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

enum Status { loading, complete }

class MainPainter extends CustomPainter {
  final Background background;
  final MainQR hero;
  final PostAvatar postAvatar;
  final Size size;
  final String url;

  MainPainter({this.background, this.hero, this.url, this.size, this.postAvatar});

  @override
  void paint(Canvas canvas, Size size) {
    background.paint(canvas, size);
    postAvatar.paint(canvas, size);
    hero.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class EnterPostPage extends StatefulWidget {
  String bgUrl;
  String qrImageUrl;

  EnterPostPage({this.bgUrl, this.qrImageUrl});

  _EnterPostPage createState() => _EnterPostPage();
}

class _EnterPostPage extends State<EnterPostPage> with TickerProviderStateMixin {
  Status gameStatus = Status.loading;
  int index = 0;
  Background background;
  MainQR hero;
  PostAvatar postAvatar;

  initState() {
    initPost();
  }

  Widget build(BuildContext context) {
    if (gameStatus == Status.loading) {
      return SizedBox();
    }
    return CustomPaint(
        painter: MainPainter(background: background, hero: hero, postAvatar: postAvatar, size: Size(750, 1334)),
        size: Size(750, 1334));
  }

  void initPost() async {
    background = new Background(url: widget.bgUrl);
    hero = new MainQR(url: widget.qrImageUrl);
    postAvatar = new PostAvatar();
    await hero.init();
    await postAvatar.init();
    await background.init();
    setState(() {
      gameStatus = Status.complete;
    });
  }
}
