import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DropboxViewerPage extends StatefulWidget {
  const DropboxViewerPage({super.key});

  @override
  State<DropboxViewerPage> createState() => _DropboxViewerPageState();
}

class _DropboxViewerPageState extends State<DropboxViewerPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.dropbox.com/scl/fo/xvxrwrtl1zo2uqkfe8lsy/AKAGtKGgFyj_FDfsyY5Zh2w?rlkey=p132p2f42v0b3q3ezwqwaj2qv&dl=0',
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dropbox Viewer')),
      body: SafeArea(
        child: WebViewWidget(controller: _controller), // ✅ FIXED: controller passed here
      ),
    );
  }
}
