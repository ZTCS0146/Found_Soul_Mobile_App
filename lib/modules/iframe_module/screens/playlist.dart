import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
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
    _controller = WebViewController()
      ..loadRequest(Uri.parse("https://foundsoulsofficial.com/playlists/"))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Playlist",showBackButton:false),
      body: WebViewWidget(controller: _controller),
    );
  }
}
