import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopWebViewPage extends StatefulWidget {
  @override
  _ShopWebViewPageState createState() => _ShopWebViewPageState();
}

class _ShopWebViewPageState extends State<ShopWebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse("https://foundsoulsofficial.com/shop/"))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Shop",showBackButton:false),
      body: WebViewWidget(controller: _controller),
    );
  }
}
