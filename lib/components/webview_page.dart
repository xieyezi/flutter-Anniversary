import 'package:daily/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final bool autoGetTitle;

  // 可以拿webviewcontroller
  final ValueChanged<WebViewController> onWebViewCreated;

  // 新url跳转时是否允许
  final ValueChanged<NavigationRequest> navigationDelegate;

  const WebViewPage(
      {Key key, this.url, this.title, this.autoGetTitle = false, this.onWebViewCreated, this.navigationDelegate})
      : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> with AutomaticKeepAliveClientMixin {
  String title;
  // 是否首次加载
  bool _isFirstLoad = true;
  WebViewController _controller;

  @override
  void initState() {
    title = widget.title;
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => Navigator.pop(context, false),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(height: 30, width: 30, child: Icon(Icons.arrow_back, color: Colors.black)),
                    ),
                    Container(width: MediaQuery.of(context).size.width - 70, child: Center(child: Text(title)))
                  ],
                ),
              ),
              Divider(),
              Visibility(visible: _isFirstLoad, child: _progressIndicator()),
              Expanded(child: _webview()),
            ],
          ),
        ),
      ),
    );
  }

  WebView _webview() {
    return WebView(
      onWebViewCreated: (controller) {
        _controller = controller;
        widget.onWebViewCreated?.call(controller);
      },
      onPageFinished: _onPageFinished,
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: widget.navigationDelegate,
    );
  }

  // 页面加载完成
  _onPageFinished(String url) {
    if (_isFirstLoad && widget.autoGetTitle) {
      _getDocumentTiele();
    }
    setState(() => _isFirstLoad = false);
  }

  // 获取文档标题
  _getDocumentTiele() {
    _controller.getTitle().then((value) {
      setState(() => title = value);
    });
  }

  _progressIndicator() {
    return SizedBox(
      height: 2,
      child: LinearProgressIndicator(
        backgroundColor: Colors.black45,
        valueColor: AlwaysStoppedAnimation(Colors.black45),
      ),
    );
  }
}
