import 'dart:io';
import 'package:daily/components/file_image.dart';
import 'package:daily/components/placeholder_image.dart';
import 'package:daily/model/categroy.dart';
import 'package:daily/model/daily.dart';
import 'package:daily/pages/add/add.dart';
import 'package:daily/pages/detail/detail.dart';
import 'package:daily/services/add_sevice.dart';
import 'package:daily/styles/colors.dart';
import 'package:daily/styles/iconfont.dart';
import 'package:daily/styles/text_style.dart';
import 'package:daily/utils/sqlite_help.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oktoast/oktoast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool loading = false;
  List<Daliy> _daliyList = [];
  List<CategoryModel> categoryList;
  final sqlLiteHelper = SqlLiteHelper();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    loadAllformSqlite();
    loadCategroyList();
    super.initState();
  }

  // loadAll from sqflite
  Future<void> loadAllformSqlite() async {
    _daliyList = [];
    await sqlLiteHelper.open();
    _daliyList = await sqlLiteHelper.queryAll();
    setState(() {});
  }

  // load category from netWork
  Future<void> loadCategroyList() async {
    loading = true;
    List<CategoryModel> res = await API.getData();
    categoryList = res;
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 首次加载，初始化一个daliy
    if (_daliyList.length == 0 && !loading) {
      final Daliy daliy = Daliy(
        id: 0,
        title: '欢迎来到时光',
        headText: '这是你的第一个纪念日',
        targetDay: formatter.format(DateTime.now()),
        imageUrl: categoryList[5].imgUrl,
        remark: '''欢迎来到时光!
这是一款功能简洁的纪念日APP，你可以首页右下角的按钮，新增一个纪念日，赶紧体验起来吧～，
祝福你的每个日子都开开心心！
        ''',
      );
      _daliyList.add(daliy);
      setState(() {});
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        floatingActionButton: loading ? SizedBox() : _buildFoaltButton(context),
        body: loading
            ? Center(child: SpinKitPumpingHeart(color: Colors.black))
            : Container(
                color: AppColors.homeBackGorundColor,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 20),
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
      ),
    );
  }

  /// FloatingActionButton
  Widget _buildFoaltButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, size: 24),
      backgroundColor: AppColors.buttonPrimary,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return AddNew(categoryList: categoryList);
          }),
        ).then((value) {
          if (value) loadAllformSqlite();
        });
      },
    );
  }

  /// 顶部
  Widget buildTop() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Forever', style: AppTextStyles.appTitle),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showToast('努力更新中，请期待～');
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(Iconfont.wish, size: 40),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: PopupMenuButton<String>(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        itemBuilder: (context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'about',
                              child: Text('关于', style: AppTextStyles.inputValueStyle),
                            ),
                            PopupMenuItem<String>(
                              value: 'heart',
                              child: Text('飞往心愿的银河', style: AppTextStyles.inputValueStyle),
                            ),
                          ];
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 18),
          Text('每一个平凡的日子，都值得纪念', style: AppTextStyles.appTip),
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
              return HeroDetailPage(
                daliy: daliy,
                categoryList: categoryList,
              );
            },
            fullscreenDialog: true,
            // settings: RouteSettings(arguments: daliy),
          ),
        );
      },
      child: Container(
        height: 200,
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
                    child: File(daliy.imageUrl).existsSync()
                        ? FileImageFormPath(imgPath: daliy.imageUrl)
                        : PlaceHolderImage(imgUrl: categoryList[5].imgUrl),
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

  @override
  bool get wantKeepAlive => true;
}
