import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShareContentPost extends StatefulWidget {
  String bgUrl;
  String qrImageUrl;

  ShareContentPost({this.bgUrl, this.qrImageUrl});

  @override
  _ShareContentPostState createState() => _ShareContentPostState();
}

class _ShareContentPostState extends State<ShareContentPost> {
  GlobalKey globalKey = GlobalKey();

  Future<void> _capturePng() async {
    // '保存中...'
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image =
        await boundary.toImage(pixelRatio: window.devicePixelRatio);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);

    var filePath = await ImagePickerSaver.saveFile(fileData: pngBytes);

    var savedFile = File.fromUri(Uri.file(filePath));
    setState(() {
      Future<File>.sync(() => savedFile);
    });

    // '保存成功'

    NavigatorUtil.goBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: "生成海报",
        actionName: "保存到相册",
        onPressed: () {
          _capturePng();
        },
      ),
      body: Center(
        child: Container(
          height: 1334 * 0.4,
          width: 750 * 0.4,
          child: RepaintBoundary(
            key: globalKey,
            child: EnterPostPage(
                bgUrl: widget.bgUrl,
                qrImageUrl: widget.qrImageUrl),
          ),
        ),
      ),
    );
  }
}