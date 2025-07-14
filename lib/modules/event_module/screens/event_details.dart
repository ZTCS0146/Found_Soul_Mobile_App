import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  bool _isControllerInitialized = false;

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
      );

    // Ensure loadRequest only happens once
    if (!_isControllerInitialized) {
      _controller.loadRequest(Uri.parse("https://foundsoulsofficial.com/upcoming-events-app/"));
      _isControllerInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<EventProvider>().isEventLoading;

    return 
    Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: AppTheme.textPrimary),
            ),
        ],
      
    );
  }
}
