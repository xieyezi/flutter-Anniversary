import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/model/daily.dart';
import 'package:daily/styles/iconfont.dart';
import 'package:flutter/material.dart';

class HeroDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Daliy daliy = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'hero${daliy.title}',
                  child: Container(
                    height: 400,
                    child: Stack(
                      children: <Widget>[
                        _buildTopBg(context, daliy),
                        _buildTopContent(context, daliy),
                      ],
                    ),
                  ),
                ),
                _buildBottomContent(daliy),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 顶部背景图
  Widget _buildTopBg(BuildContext context, Daliy daliy) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: CachedNetworkImage(
        color: Colors.black.withOpacity(0.5),
        imageUrl: daliy.imageUrl,
        placeholder: (context, url) => Text('loading...'),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        colorBlendMode: BlendMode.colorBurn,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  /// 顶部内容
  Widget _buildTopContent(BuildContext context, Daliy daliy) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              daliy.headText,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
            Text(
              daliy.title,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
            _buildMiddleYear(senceWidth: MediaQuery.of(context).size.width),
            // _buildMiddleDay(senceWidth: MediaQuery.of(context).size.width),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Iconfont.daily, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text(
                  daliy.targetDay,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///  年月日
  Widget _buildMiddleYear({double senceWidth}) {
    TextStyle bottomTitle =
        TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500, decoration: TextDecoration.none);
    TextStyle bottomDay =
        TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500, decoration: TextDecoration.none);

    return Expanded(
      child: Center(
        child: Container(
          width: (senceWidth - 36) * 0.6,
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('28', style: bottomTitle),
                        Text('Year', style: bottomDay),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('11', style: bottomTitle),
                        Text('Month', style: bottomDay),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('28', style: bottomTitle),
                        Text('Day', style: bottomDay),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 天
  Widget _buildMiddleDay({double senceWidth}) {
    TextStyle bottomTitle =
        TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500, decoration: TextDecoration.none);
    TextStyle bottomDay =
        TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500, decoration: TextDecoration.none);
    return Expanded(
      child: Center(
        child: Container(
          width: (senceWidth - 36) * 0.6,
          padding: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('296', style: bottomTitle),
              SizedBox(width: 2),
              Text('天', style: bottomDay),
              Icon(Iconfont.up2, color: Colors.white, size: 14),
            ],
          ),
        ),
      ),
    );
  }

  /// 底部内容
  Widget _buildBottomContent(Daliy daliy) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        daliy.content,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
