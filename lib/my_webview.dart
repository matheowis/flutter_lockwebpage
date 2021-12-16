import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatelessWidget {
  final String selectedUrl;

  MyWebView({
    required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: selectedUrl,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
