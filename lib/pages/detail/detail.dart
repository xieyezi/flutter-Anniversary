import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/styles/iconfont.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({Key key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: CachedNetworkImage(
              color: Colors.black.withOpacity(0.5),
              imageUrl: 'https://cdn.xieyezi.com/daily3.jpg',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fitHeight,
              colorBlendMode: BlendMode.colorBurn,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        _buildInfo(context)
      ],
    );
  }

  Widget _buildInfo(BuildContext context) {
    final double senceWidth = MediaQuery.of(context).size.width;
    TextStyle headIntro = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
    TextStyle title = TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500);
    TextStyle day = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
    TextStyle bottomTitle = TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500);
    TextStyle bottomDay = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
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
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 16),
            child: Icon(Iconfont.daily, color: Colors.white),
          ),
          Container(
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
          Container(
            child: Icon(Iconfont.dwon1, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildDivier({double width, double height, Color color}) {
    return Container(height: height, width: width, color: color);
  }
}
