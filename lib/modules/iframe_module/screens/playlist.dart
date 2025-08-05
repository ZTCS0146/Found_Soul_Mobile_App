import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/modules/iframe_module/screens/provider/iframe_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlaylistWebViewPage extends StatefulWidget {
  @override
  _PlaylistWebViewPageState createState() => _PlaylistWebViewPageState();
}

class _PlaylistWebViewPageState extends State<PlaylistWebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<WebViewProvider>(context, listen: false);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => provider.setPlayListLoading(true),
          onPageFinished: (_) => provider.setPlayListLoading(false),
        ),
      )
      ..loadRequest(Uri.parse("https://foundsoulsofficial.com/app-playlists/"));
  }

  @override
  Widget build(BuildContext context) {
    final isPlayListLoading = context.watch<WebViewProvider>().isPlayListLoading;

    return Scaffold(
      appBar:  CustomAppBar(title: "Playlist", showBackButton: false,
          actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppTheme.textPrimary),
            onPressed: () => Navigator.pushNamed(context, '/notification'),
          ),
        ],
      
      ),
      body: Stack(
        children: [
          // Background to prevent white flash
          Container(color: Colors.black),

          // WebView with fade-in animation
          AnimatedOpacity(
            opacity: isPlayListLoading ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: WebViewWidget(controller: _controller),
          ),

          // Loader overlay
          if (isPlayListLoading)
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

