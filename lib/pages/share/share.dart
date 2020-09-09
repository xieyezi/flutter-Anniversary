// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:daily/components/bottom_button.dart';
// import 'package:daily/pages/share/post_enter.dart';
// import 'package:daily/styles/colors.dart';
// import 'package:daily/styles/text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'dart:ui' as ui;

// import 'package:image_picker_saver/image_picker_saver.dart';
// import 'package:oktoast/oktoast.dart';

// class ShareContentPost extends StatefulWidget {
//   String bgUrl;
//   String qrImageUrl;

//   ShareContentPost({this.bgUrl, this.qrImageUrl});

//   @override
//   _ShareContentPostState createState() => _ShareContentPostState();
// }

// class _ShareContentPostState extends State<ShareContentPost> {
//   GlobalKey globalKey = GlobalKey();

//   Future<void> _capturePng() async {
//     // '保存中...'
//     RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
//     ui.Image image = await boundary.toImage(pixelRatio: window.devicePixelRatio);
//     ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData.buffer.asUint8List();

//     print(pngBytes);
//     var filePath = await ImagePickerSaver.saveFile(fileData: pngBytes).catchError((error) {
//       throw error;
//     });
//     var savedFile = File.fromUri(Uri.file(filePath));
//     setState(() {
//       Future<File>.sync(() => savedFile);
//     });
//     // '保存成功'
//     showToast('保存成功');
//     // Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.homeBackGorundColor,
//         title: Text('分享', style: AppTextStyles.shareTitleStyle),
//         centerTitle: true,
//         elevation: 0,
//         leading: GestureDetector(
//           behavior: HitTestBehavior.translucent,
//           onTap: () => Navigator.pop(context),
//           child: Container(height: 50, width: 50, child: Icon(Icons.arrow_back, color: Colors.black)),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height - 150,
//           width: MediaQuery.of(context).size.width - 60,
//           color: AppColors.homeBackGorundColor,
//           child: Column(
//             children: <Widget>[
//               Expanded(
//                 child: RepaintBoundary(
//                   key: globalKey,
//                   child: EnterPostPage(bgUrl: widget.bgUrl, qrImageUrl: widget.qrImageUrl),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(top: 20),
//                 child: BottomButton(
//                   text: '保存',
//                   height: 50,
//                   handleOk: () => _capturePng(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
