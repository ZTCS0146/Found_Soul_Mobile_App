import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/modules/iframe_module/screens/provider/iframe_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';

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
      appBar: const CustomAppBar(title: "Shop", showBackButton: false),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: AppTheme.textPrimary
              ),
            ),
        ],
      ),
    );
  }
}
