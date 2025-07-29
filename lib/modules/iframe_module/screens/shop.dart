import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/modules/iframe_module/screens/provider/iframe_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';


import 'package:provider/provider.dart';
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
    final provider = Provider.of<WebViewProvider>(context, listen: false);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => provider.setLoading(true),
          onPageFinished: (_) => provider.setLoading(false),
        ),
      )
      ..loadRequest(Uri.parse("https://foundsoulsofficial.com/shop/"));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<WebViewProvider>().isLoading;

    return Scaffold(
      appBar:  CustomAppBar(title: "Shop", showBackButton: false,actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppTheme.textPrimary),
            onPressed: () => Navigator.pushNamed(context, '/notification'),
          ),
        ],),
      body: Stack(
        children: [
          // 1. Background color to prevent white flash
          Container(color: Colors.black),

          // 2. WebView with fade-in transition
          AnimatedOpacity(
            opacity: isLoading ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: WebViewWidget(controller: _controller),
          ),

          // 3. Fullscreen loader
          if (isLoading)
            Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
