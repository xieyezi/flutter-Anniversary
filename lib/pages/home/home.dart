import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/model/daily.dart';
import 'package:daily/pages/detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final List<Daliy> _daliyList = [
    Daliy(
      '我们在一起',
      '每刻的相遇都是最美的时刻',
      '2020-08-23',
      'https://cdn.xieyezi.com/daily1.jpg',
      """每刻的相遇都是最美的时刻
你是我生命中最善良的音符，我的生活因为你而精彩，愿美好的乐章谱满我们以后的每一个清晨与黄昏。""",
    ),
    Daliy(
      '第一次工作',
      '努力赚钱钱哦',
      '2020-08-23',
      'https://images.unsplash.com/photo-1521737711867-e3b97375f902?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      """职场中，最重要的一件事：努力；最重要的两个字：我能；最重要的三宝：自信、诚实、微笑；最重要的四句话：你好、请问、谢谢、没问题。愿你第一天上班顺利，工作开心！""",
    ),
    Daliy(
      '娇娇的生日',
      '爱你每一天',
      '2020-09-21',
      'https://images.unsplash.com/photo-1514845505178-849cebf1a91d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      """一定不要忘记准备惊喜和礼物哦""",
    ),
    Daliy(
      '第一次买房',
      '努力奋斗',
      '2020-09-21',
      'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      """加油奋斗！！""",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildTop(),
                createListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 顶部
  Widget buildTop() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(
                    'Daily',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Conspired'),
                  ),
                ),
                Text(
                  '那些一去不返的日子，都值得纪念',
                  style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          ClipOval(
            child: Image.network(
              'https://images.unsplash.com/photo-1536590158209-e9d615d525e4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  /// 列表
  Widget createListView() {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
        itemCount: _daliyList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return createItemView(index);
        },
      ),
    );
  }

  Widget createItemView(int index) {
    var daliy = _daliyList[index];
    var _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    var _animation = Tween<double>(begin: 1, end: 0.98).animate(_animationController);
    return GestureDetector(
      onPanDown: (details) {
        _animationController.forward();
      },
      onPanCancel: () {
        _animationController.reverse();
      },
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HeroDetailPage();
            },
            fullscreenDialog: true,
            settings: RouteSettings(arguments: daliy),
          ),
        );
      },
      child: Container(
          height: 400,
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: ScaleTransition(
            scale: _animation,
            child: Hero(
              tag: 'hero${daliy.title}',
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: daliy.imageUrl,
                        filterQuality: FilterQuality.high,
                        color: Colors.black.withOpacity(0.2),
                        colorBlendMode: BlendMode.colorBurn,
                        placeholder: (context, url) => Text('loading...'),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
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
                        Expanded(
                          child: Text(
                            daliy.title,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Text(
                          daliy.targetDay,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
