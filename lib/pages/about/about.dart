import 'dart:math';
import 'package:daily/components/webview_page.dart';
import 'package:daily/pages/share/share.dart';
import 'package:daily/styles/colors.dart';
import 'package:daily/styles/text_style.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.homeBackGorundColor,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 15,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => Navigator.pop(context, false),
                child: Container(height: 50, width: 50, child: Icon(Icons.arrow_back, color: Colors.black)),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                child: CustomPaint(
                  size: Size(300, 300), //指定画布大小
                  painter: MyPainterTopRight(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                child: CustomPaint(
                  size: Size(200, 200), //指定画布大小
                  painter: MyPainterBottomLeft(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 48,
              child: Container(
                width: 60,
                height: 60,
                child: Image.asset('assets/images/app.png', fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: 160,
              left: 60,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('0.4.0', style: AppTextStyles.aboutStyle),
                    SizedBox(height: 10),
                    Text('这是一款能够留住时光的APP', style: AppTextStyles.aboutStyle),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 50,
              bottom: MediaQuery.of(context).padding.bottom + 200,
              child: Container(
                width: 200,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildMiddleItem(
                        title: '功能介绍',
                        imgUrl: 'assets/images/list.png',
                        size: 36,
                        action: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return WebViewPage(
                              url: 'https://github.com/xieyezi/flutter-Anniversary/blob/master/CHANGELOG.md',
                              title: '功能介绍',
                            );
                          }));
                        }),
                    _buildMiddleItem(
                        title: '与作者联系',
                        imgUrl: 'assets/images/email.png',
                        size: 30,
                        action: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return WebViewPage(
                              url: 'https://github.com/xieyezi/flutter-Anniversary/issues/new',
                              title: '与作者联系',
                            );
                          }));
                        }),
                    _buildMiddleItem(
                        title: '分享给好友',
                        imgUrl: 'assets/images/air.png',
                        size: 30,
                        action: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 300),
                                pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    alignment: Alignment.bottomRight,
                                    child: ShareContentPost(
                                        bgUrl: 'https://i.loli.net/2020/09/09/OvqcBszXgnST2re.png',
                                        qrImageUrl: 'https://i.loli.net/2020/09/09/CZceqMO4GBndJmD.png'),
                                  );
                                }),
                          );
                        }),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom + 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return WebViewPage(
                            url: 'https://juejin.im/user/4248168660738606/posts',
                            title: '觉非',
                          );
                        }));
                      },
                      child: Text('觉非 温情出品', style: AppTextStyles.aboutBottomStyle)),
                  SizedBox(height: 8),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return WebViewPage(
                            url: 'https://github.com/xieyezi/flutter-Anniversary/blob/master/LICENSE',
                            title: '时光',
                          );
                        }));
                      },
                      child: Text('隐私协议 软件使用协议 官方地址', style: AppTextStyles.aboutBottomStyle)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiddleItem({String imgUrl, String title, double size, Function action}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => action(),
      child: Row(
        children: <Widget>[
          Image.asset(
            imgUrl,
            width: size,
            height: size,
          ),
          SizedBox(width: 10),
          Text(title, style: AppTextStyles.aboutMiddleStyle),
        ],
      ),
    );
  }
}

class MyPainterTopRight extends CustomPainter {
  final double screenWitdh;
  final double screenHeight;
  MyPainterTopRight(this.screenWitdh, this.screenHeight);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..color = Color.fromRGBO(93, 92, 238, 0.9)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 80
      ..style = PaintingStyle.stroke;

    /// Offset(),横纵坐标偏移
    /// void drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter, Paint paint)
    /// Rect来确认圆弧的位置, 开始的弧度、结束的弧度、是否使用中心点绘制(圆弧是否向中心闭合)、以及paint.
    final center = new Offset(screenWitdh - 30, 0);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: size.width / 2), pi / 2, 2 * pi * 0.5, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MyPainterBottomLeft extends CustomPainter {
  final double screenWitdh;
  final double screenHeight;
  MyPainterBottomLeft(this.screenWitdh, this.screenHeight);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..color = Color.fromRGBO(33, 255, 217, 1)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 100
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 200), 140, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
