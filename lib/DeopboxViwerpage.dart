import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class DropboxViewerPage extends StatefulWidget {
  const DropboxViewerPage({super.key});

  @override
  State<DropboxViewerPage> createState() => _DropboxViewerPageState();
}

class _DropboxViewerPageState extends State<DropboxViewerPage> {
  late final WebViewController _controller;
  bool isLoading = true;

  static const platform = MethodChannel('com.example.dropbox/check');

  final String dropboxUrl =
      'https://www.dropbox.com/scl/fo/xvxrwrtl1zo2uqkfe8lsy/AKAGtKGgFyj_FDfsyY5Zh2w?rlkey=p132p2f42v0b3q3ezwqwaj2qv&dl=0';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: _handleNavigationRequest,
        onPageStarted: (_) => setState(() => isLoading = true),
        onPageFinished: (_) => setState(() => isLoading = false),
        onWebResourceError: (_) => setState(() => isLoading = false),
      ))
      ..loadRequest(Uri.parse(dropboxUrl));
  }

  Future<bool> isDropboxInstalled() async {
    try {
      final bool result = await platform.invokeMethod('isDropboxInstalled');
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<NavigationDecision> _handleNavigationRequest(NavigationRequest request) async {
    final uri = Uri.parse(request.url);

    // For non-HTTP(S), likely trying to open Dropbox app
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      final installed = await isDropboxInstalled();

      if (installed) {
        // Instead of launchUrl(uri), use platform channels to open the Dropbox app directly
        const platform = MethodChannel('com.example.dropbox/check');
        try {
          await platform.invokeMethod('launchDropboxApp');
        } catch (e) {
          // Fallback: show it in WebView
          return NavigationDecision.navigate;
        }
      } else {
        // Open Play Store ONLY if not installed
        final playStoreUri = Uri.parse('https://play.google.com/store/apps/details?id=com.dropbox.android');
        if (await canLaunchUrl(playStoreUri)) {
          await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
        }
      }

      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropbox Viewer',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xff9d2a8a),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
