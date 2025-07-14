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
        final provider = Provider.of<WebViewProvider>(context, listen: false);

    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => provider.setPlayListLoading(true),
          onPageFinished: (_) => provider.setPlayListLoading(false),
        ),
      )
      ..loadRequest(Uri.parse("https://foundsoulsofficial.com/playlists/"))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
        
       final isPlayListLoading = context.watch<WebViewProvider>().isPlayListLoading;

    return Scaffold(
      appBar: const CustomAppBar(title: "Playlist",showBackButton:false),
      body: isPlayListLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppTheme.textPrimary
              ))
          : WebViewWidget(controller: _controller),
    );
  }
}
