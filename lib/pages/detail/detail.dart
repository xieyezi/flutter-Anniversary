import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/styles/iconfont.dart';
import 'package:flutter/material.dart';

import 'components/stagger_animation_content.dart';

class Detail extends StatefulWidget {
  const Detail({Key key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> with TickerProviderStateMixin {
  AnimationController _controller;
  bool toogle = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final double senceWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: CachedNetworkImage(
              color: Colors.black.withOpacity(0.5),
              imageUrl:
                  'https://images.unsplash.com/photo-1518050346340-aa2ec3bb424b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
              placeholder: (context, url) => Text('loading...'),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fitHeight,
              colorBlendMode: BlendMode.colorBurn,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        _buildInfo(context, senceWidth),
        Positioned(
          bottom: 50,
          child: Container(
            child: Icon(Iconfont.up, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buildInfo(BuildContext context, double senceWidth) {
    TextStyle headIntro = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
    TextStyle title = TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500);
    TextStyle day = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 16),
            child: Text('恋爱纪念日', style: headIntro),
          ),
          _buildDivier(width: senceWidth * 0.5, height: 1.5, color: Colors.white),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('我们在一起', style: title),
          ),
          _buildDivier(width: senceWidth * 0.5, height: 1.5, color: Colors.white),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('2019-01-30', style: day),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              toogle ? _controller.forward() : _controller.reverse();
              toogle = !toogle;
            },
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: StaggerAnimation(
                controller: _controller,
                animationYear: _buildMiddleYear(senceWidth: senceWidth),
                animationDay: _buildMiddleDay(senceWidth: senceWidth),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleYear({double senceWidth}) {
    TextStyle bottomTitle = TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500);
    TextStyle bottomDay = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
    return Column(
      children: <Widget>[
        Container(
          child: Icon(Iconfont.daily, color: Colors.white),
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          width: senceWidth * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('28', style: bottomTitle),
                  Text('年', style: bottomDay),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('11', style: bottomTitle),
                  Text('月', style: bottomDay),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('28', style: bottomTitle),
                  Text('天', style: bottomDay),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleDay({double senceWidth}) {
    TextStyle bottomTitle = TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500);
    TextStyle bottomDay = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
    return Column(
      children: <Widget>[
        Container(
          child: Icon(Iconfont.clock, color: Colors.white),
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          width: senceWidth * 0.5,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('296', style: bottomTitle),
                  Icon(Iconfont.down1, color: Colors.white, size: 14),
                ],
              ),
              Text('天', style: bottomDay),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivier({double width, double height, Color color}) {
    return Container(height: height, width: width, color: color);
  }
}
