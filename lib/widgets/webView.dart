import 'package:flutter/material.dart';

class MyWebView extends StatefulWidget {
  final String url;
  const MyWebView({this.url}) ;

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: WebView(
      //   initialUrl: "${widget.url}",
      // ),
    );
  }
}
