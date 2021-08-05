import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../extra/style/style.dart';
import '../../../extra/utils/unawaited.dart';

class DetailsBody extends StatefulWidget {
  const DetailsBody({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  _DetailsBodyState createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Palette.amaranth,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          unawaited(webViewController?.reload());
        } else if (Platform.isIOS) {
          unawaited(webViewController?.loadUrl(
            urlRequest: URLRequest(url: await webViewController?.getUrl()),
          ));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          initialOptions: options,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT,
            );
          },
          onLoadStop: (controller, url) {
            pullToRefreshController.endRefreshing();
          },
          onLoadError: (controller, url, code, message) {
            pullToRefreshController.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController.endRefreshing();
            }
            setState(() {
              this.progress = progress / 100;
            });
          },
        ),
        if (progress < 1.0) ...[
          LinearProgressIndicator(
            value: progress,
            color: Palette.amaranth,
          ),
        ] else ...[
          const SizedBox(),
        ],
      ],
    );
  }
}
