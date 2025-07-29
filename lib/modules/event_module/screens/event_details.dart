import 'package:flutter/material.dart';
import 'package:found_soul_mobile_app/helper_widget/appbar.dart';
import 'package:found_soul_mobile_app/modules/event_module/providers/event_provider.dart';
import 'package:found_soul_mobile_app/theme/app_theme.dart';

import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventDetailsScreen extends StatefulWidget {
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<EventProvider>(context, listen: false);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => provider.setLoading(true),
          onPageFinished: (_) => provider.setLoading(false),
        ),
      )
      ..loadRequest(Uri.parse("https://foundsoulsofficial.com/upcoming-events-app/"));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<EventProvider>().isEventLoading;

    return Scaffold(
      appBar:  CustomAppBar(title: "Event Details", showBackButton: false,actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppTheme.textPrimary),
            onPressed: () => Navigator.pushNamed(context, '/notification'),
          ),
        ],),
      body: Stack(
        children: [
          // Background color to avoid white flash
          Container(color: Colors.black),

          // WebView with fade-in effect
          AnimatedOpacity(
            opacity: isLoading ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: WebViewWidget(controller: _controller),
          ),

          // Loader overlay
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
