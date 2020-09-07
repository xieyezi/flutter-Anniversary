import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/components/bottom_button.dart';
import 'package:daily/components/file_image.dart';
import 'package:daily/model/categroy.dart';
import 'package:daily/model/daily.dart';
import 'package:daily/styles/colors.dart';
import 'package:daily/styles/text_style.dart';
import 'package:daily/utils/sqlite_help.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddNew extends StatefulWidget {
  final List<CategoryModel> categoryList;
  AddNew({Key key, this.categoryList}) : super(key: key);
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> with TickerProviderStateMixin {
  final picker = ImagePicker();
  final sqlLiteHelper = SqlLiteHelper();
  DateTime targetDay;
  int imgCurrentIndex;
  File _imageBg = File('');
  PickedFile pickedFile;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  TextEditingController _titleController = TextEditingController();
  TextEditingController _headTextController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  Future getImage() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageBg = File(pickedFile.path);
      print(pickedFile.path);
    });
  }

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
                    color: AppColors.addBackGorundColor,
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => getImage(),
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            height: 400,
                            width: MediaQuery.of(context).size.width,
                            child: _imageBg.existsSync()
                                ? FileImageFormPath(imgPath: pickedFile.path)
                                : _buildNotChooseImage(),
                          ),
                        ),
                        Center(
                          child: _imageBg.existsSync()
                              ? Text('每个日子都值得纪念', style: AppTextStyles.headTextStyle)
                              : SizedBox(),
                        )
                      ],
                    )),
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 15,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => Navigator.pop(context, false),
                    child: Container(height: 50, width: 50, child: Icon(Icons.arrow_back, color: Colors.white)),
                  ),
                ),
                Positioned.fill(
                  top: MediaQuery.of(context).size.height * 0.25 + 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                          handleOk: () => _addAction(context, widget.categoryList),
                        ),
                      ),
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

  /// not choose Image
  Widget _buildNotChooseImage() {
    return Container(
      color: Colors.black45.withOpacity(0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: 50,
              width: 50,
              child: Icon(Icons.add, size: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text('选择一张背景图片', style: AppTextStyles.headTextStyle),
        ],
      ),
    );
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
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              style: AppTextStyles.inputValueStyle,
              decoration: InputDecoration(
                hintText: placeHolder,
                hintStyle: AppTextStyles.inputHintStyle,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: GestureDetector(
                  onTap: () => _clearInput(controller),
                  child: controller.text != '' ? Icon(Icons.cancel, size: 18, color: Colors.black) : SizedBox(),
                ),
              ),
              cursorColor: AppColors.homeBackGorundColor,
              // // 标题
              // validator: (v) {
              //   return validateFunc(v);
              // }
            ),
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
        backgroundColor: AppColors.dateSelectBackGorundColor,
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
                    initialSelectedDate: targetDay,
                    initialDisplayDate: targetDay,
                    backgroundColor: AppColors.dateSelectBackGorundColor,
                    selectionColor: AppColors.dateSelectHlight,
                    todayHighlightColor: AppColors.dateSelectHlight,
                    monthCellStyle: DateRangePickerMonthCellStyle(todayTextStyle: AppTextStyles.dateSelectStyle),
                    yearCellStyle: DateRangePickerYearCellStyle(todayTextStyle: AppTextStyles.dateSelectStyle),
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

  /// cateGory Select (version 0.1)
  void _cateGorySelect(BuildContext context, List<CategoryModel> categoryList) {
    var _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    var _animation = Tween<double>(begin: 1, end: 0.98).animate(_animationController);
    showModalBottomSheet(
        context: context,
        elevation: 10,
        isScrollControlled: true,
        backgroundColor: AppColors.cateGroySelectBackGorundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (_, setModalBottomSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Container(
                padding: EdgeInsets.only(
                  top: 30,
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
                              child: Container(
                                decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, -5),
                                      color: Colors.grey,
                                      blurRadius: 30,
                                      spreadRadius: -20,
                                    )
                                  ],
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl: categoryList[index].imgUrl,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                        colorBlendMode: BlendMode.colorBurn,
                                        color: Colors.black.withOpacity(0.3),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 30),
                                        child: Text(categoryList[imgCurrentIndex].name,
                                            style: AppTextStyles.cateGoryTextStyle),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: categoryList.length,
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
                      margin: EdgeInsets.all(20),
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

  /// addAction
  void _addAction(BuildContext context, List<CategoryModel> categoryList) async {
    if (_titleController.text.length == 0) {
      showToast('标题名是必须填写的哦～');
      return;
    }
    if (pickedFile == null) {
      showToast('必须选择一张背景图片哦～');
      return;
    }
    //insert to sqlite
    final headTextNull = '生如夏花之灿烂';
    final remarkNull = '只要面对着阳光努力向上，日子就会变得单纯而美好。';
    final Daliy daliy = Daliy(
      title: _titleController.text,
      targetDay: formatter.format(targetDay),
      imageUrl: pickedFile.path,
      remark: _contentController.text == '' ? remarkNull : _contentController.text,
      headText: _headTextController.text == '' ? headTextNull : _headTextController.text,
    );
    await sqlLiteHelper.open();
    await sqlLiteHelper.insert(daliy);
    showToast('添加成功');
    Navigator.pop(context, true);
  }
}
