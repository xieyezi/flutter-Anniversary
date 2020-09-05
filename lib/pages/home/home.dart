import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/model/daily.dart';
import 'package:daily/pages/add/add.dart';
import 'package:daily/pages/detail/detail.dart';
import 'package:daily/styles/colors.dart';
import 'package:daily/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final List<Daliy> _daliyList = [
    Daliy(
      id: 1,
      title: '我们在一起',
      headText: '第一次的相遇是最美的时刻',
      targetDay: '2019-01-31',
      imageUrl: 'https://cdn.xieyezi.com/daily_love.jpg',
      remark: """每刻的相遇都是最美的时刻
你是我生命中最善良的音符，我的生活因为你而精彩，愿美好的乐章谱满我们以后的每一个清晨与黄昏。""",
    ),
    Daliy(
      id: 2,
      title: '第一次工作',
      headText: '努力赚钱钱哦',
      targetDay: '2019-07-10',
      imageUrl: 'https://cdn.xieyezi.com/daily_work.jpg',
      remark: """职场中，最重要的一件事：努力；最重要的两个字：我能；最重要的三宝：自信、诚实、微笑；最重要的四句话：你好、请问、谢谢、没问题。愿你第一天上班顺利，工作开心！""",
    ),
    Daliy(
      id: 3,
      title: '她的生日',
      headText: '爱你每一天',
      targetDay: '2020-08-21',
      imageUrl: 'https://cdn.xieyezi.com/daily_birthday.jpg',
      remark: """一定不要忘记准备惊喜和礼物哦""",
    ),
    Daliy(
      id: 4,
      title: '第一次买房',
      headText: '努力奋斗',
      targetDay: '2021-09-01',
      imageUrl: 'https://cdn.xieyezi.com/daily_other.jpg',
      remark: """革命尚未成功，加油奋斗！！""",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.buttonPrimary,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return AddNewPage();
                },
                fullscreenDialog: true,
                settings: RouteSettings(arguments: ''),
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.homeBackGorundColor,
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
                  child: Text('Daily', style: AppTextStyles.appTitle),
                ),
                Text('每一个平凡的日子，都值得纪念', style: AppTextStyles.appTip),
              ],
            ),
          ),
          ClipOval(
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              // placeholder: (context, url) => Text('loading...'),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageUrl:
                  'https://images.unsplash.com/photo-1536590158209-e9d615d525e4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
            ),
          )
        ],
      ),
    );
  }

  /// 列表
  Widget createListView() {
    return MediaQuery.removePadding(
      //  去除shrinkWrap产生的顶部padding
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
              return HeroDetailPage(daliy: daliy);
            },
            fullscreenDialog: true,
            // settings: RouteSettings(arguments: daliy),
          ),
        );
      },
      child: Container(
        height: 400,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ScaleTransition(
          scale: _animation,
          child: Hero(
            tag: 'hero${daliy.id}',
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
                      Text(daliy.headText, style: AppTextStyles.headTextStyle),
                      Expanded(
                        child: Text(daliy.title, style: AppTextStyles.titleTextStyle),
                      ),
                      Text(daliy.targetDay, style: AppTextStyles.targetDayStyle),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
