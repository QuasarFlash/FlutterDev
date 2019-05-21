import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/gestures.dart';

class NewsWebView extends StatefulWidget {
  final String newsUrl;
  final double height;
  NewsWebView({Key key, this.newsUrl, this.height = 0.0}) : super(key: key);

  _NewsWebViewState createState() =>
      _NewsWebViewState(this.newsUrl, this.height);
}

class _NewsWebViewState extends State<NewsWebView> {
  String newsUrl;
  double height;
  final _key = UniqueKey();
  num _view = 1;
  _NewsWebViewState(this.newsUrl, this.height);
  Completer<WebViewController> _controller = Completer<WebViewController>();

  void _handleWebViewLoad(String value) {
    setState(() {
      _view = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _view,
      children: <Widget>[
        // Column(
        // children: <Widget>[
        // Expanded(
        // child:
        handleWebViewType(),
        // ),
        // ],
        // ),
        Container(
          // color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget handleWebViewType() {
    return height == 0.0
        ? WebView(
            key: _key,
            initialUrl: newsUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageFinished: _handleWebViewLoad,
          )
        : Container(
            child: WebView(
              initialUrl: newsUrl,
              javascriptMode: JavascriptMode.unrestricted,
              gestureRecognizers: Set()
                ..add(
                  Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer(),
                  ),
                ),
              onPageFinished: _handleWebViewLoad,
            ),
            height: height,
          );
  }
}
