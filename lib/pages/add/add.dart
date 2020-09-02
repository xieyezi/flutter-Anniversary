import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/components/bottom_button.dart';
import 'package:daily/model/categroy.dart';
import 'package:daily/styles/colors.dart';
import 'package:daily/styles/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddNew extends StatefulWidget {
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> with TickerProviderStateMixin {
  int imgCurrentIndex;
  DateTime targetDay;
  GlobalKey _formKey = GlobalKey<FormState>();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  TextEditingController _titleController = TextEditingController();
  TextEditingController _headTextController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  final List<CateGory> _imgList = [
    CateGory(
      name: '恋爱',
      imgUrl:
          'https://images.unsplash.com/photo-1535507005612-9b796a99f4f1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=633&q=80',
    ),
    CateGory(
      name: '工作',
      imgUrl:
          'https://images.unsplash.com/photo-1521737711867-e3b97375f902?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    ),
    CateGory(
      name: '生活',
      imgUrl:
          'https://images.unsplash.com/photo-1514845505178-849cebf1a91d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    ),
    CateGory(
      name: '学习',
      imgUrl:
          'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    ),
  ];

  @override
  void initState() {
    imgCurrentIndex = 0;
    targetDay = DateTime.now();
    _titleController.addListener(() {
      setState(() {});
    });
    _headTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleController.removeListener(() {});
    _headTextController.removeListener(() {});
    super.dispose();
  }

  void _clearInput(TextEditingController controller) {
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColors.homeBackGorundColor,
          child: Stack(
            children: <Widget>[
              Container(
                  color: Colors.black.withOpacity(0.5),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          color: Colors.black.withOpacity(0.5),
                          imageUrl: _imgList[imgCurrentIndex].imgUrl,
                          placeholder: (context, url) => Text('loading...'),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.colorBurn,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      Center(
                        child: Text('每个日子都值得纪念', style: AppTextStyles.headTextStyle),
                      )
                    ],
                  )),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 15,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              Positioned.fill(
                top: MediaQuery.of(context).size.height * 0.25 + 30,
                child: Form(
                  key: _formKey, //设置globalKey，用于后面获取FormState
                  autovalidate: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildSelcetItem(
                        label: '类别',
                        value: _imgList[imgCurrentIndex].name,
                        onTap: () => _cateGorySelect(context),
                      ),
                      _buildSelcetItem(
                        label: '日期',
                        value: formatter.format(targetDay),
                        onTap: () => _seletDate(context, targetDay),
                      ),
                      _buildItemInput(
                        label: '标题',
                        placeHolder: '为纪念日写个标题吧~',
                        controller: _titleController,
                      ),
                      _buildItemInput(
                        label: '描述',
                        placeHolder: '我还没想好要写什么...',
                        controller: _headTextController,
                      ),
                      _buildContentTextFiled(
                        controller: _contentController,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: BottomButton(
                          text: '保存',
                          height: 60,
                          handleOk: () => {},
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  /// _buildSelcetItem
  Widget _buildSelcetItem({String label, String value, Function onTap}) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Container(
              width: MediaQuery.of(context).size.width - 60,
              child: Row(
                children: <Widget>[
                  Text(label, style: AppTextStyles.inputLabelStyle),
                  SizedBox(width: 32),
                  Text(value, style: AppTextStyles.inputLabelStyle),
                ],
              ),
            ),
          ),
          Icon(Icons.chevron_right, size: 20, color: Colors.grey)
        ],
      ),
    );
  }

  // Input Item
  Widget _buildItemInput({
    String label,
    String placeHolder,
    String errorTipText,
    TextEditingController controller,
  }) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Text(label, style: AppTextStyles.inputLabelStyle),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.text,
                style: AppTextStyles.inputValueStyle,
                decoration: InputDecoration(
                  hintText: placeHolder,
                  hintStyle: AppTextStyles.inputHintStyle,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  suffixIcon: GestureDetector(
                    onTap: () => _clearInput(controller),
                    child: controller.text != '' ? Icon(Icons.cancel, size: 18) : SizedBox(),
                  ),
                ),
                cursorColor: AppColors.homeBackGorundColor,
                // 校验用户名
                validator: (v) {
                  return v.trim().length > 0 ? null : errorTipText;
                }),
          ),
        ],
      ),
    );
  }

  /// Content
  Widget _buildContentTextFiled({TextEditingController controller}) {
    return Container(
      height: 170,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          maxLines: 5,
          maxLength: 500,
          controller: controller,
          cursorColor: AppColors.homeBackGorundColor,
          style: AppTextStyles.inputValueStyle,
          decoration: InputDecoration(
              hintText: '在这里写下有关这个日子的故事吧～',
              hintStyle: AppTextStyles.inputHintStyle,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10)
              // border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
        ),
      ),
    );
  }

  /// Date Select
  void _seletDate(BuildContext context, DateTime targetDay) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16),
                  SfDateRangePicker(
                    backgroundColor: Colors.white,
                    initialSelectedDate: targetDay,
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      _dateChange(args.value);
                    },
                  ),
                ],
              ));
        });
  }

  /// date OnChange
  void _dateChange(DateTime date) {
    setState(() {
      targetDay = date;
    });
    Navigator.pop(context);
  }

  /// cateGory Select
  void _cateGorySelect(BuildContext context) {
    var _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    var _animation = Tween<double>(begin: 1, end: 0.98).animate(_animationController);
    showModalBottomSheet(
        context: context,
        elevation: 10,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (_, setModalBottomSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Container(
                padding: EdgeInsets.only(
                  top: 40,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onPanDown: (details) {
                          _animationController.forward();
                        },
                        onPanCancel: () {
                          _animationController.reverse();
                        },
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return ScaleTransition(
                              scale: _animation,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: CachedNetworkImage(
                                  imageUrl: _imgList[index].imgUrl,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                          itemCount: _imgList.length,
                          viewportFraction: 0.6,
                          scale: 0.6,
                          onIndexChanged: (index) {
                            setModalBottomSheetState(() {
                              imgCurrentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      // TODO: 抽字体样式
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        _imgList[imgCurrentIndex].name,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w200,
                          fontFamily: 'Dongqing',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: BottomButton(
                        text: '确定',
                        height: 50,
                        handleOk: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
