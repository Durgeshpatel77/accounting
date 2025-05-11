import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DropboxViewerPage extends StatefulWidget {
  final String driveLink;

  const DropboxViewerPage({Key? key, required this.driveLink}) : super(key: key);

  @override
  State<DropboxViewerPage> createState() => _DropboxViewerPageState();
}

class _DropboxViewerPageState extends State<DropboxViewerPage> {
  late final WebViewController _controller;
  bool isLoading = true; // ⬅️ Track loading state

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.driveLink.replaceFirst('?dl=0', '?preview=1')));
  }

  Future<bool> _handleBackNavigation() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackNavigation,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("File Viewer", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xff9d2a8a),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
