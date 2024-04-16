import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:trend_radar/view/widgets/appbar.dart';
import 'package:trend_radar/view/widgets/common.dart';

import '../../../helper/firebase/firebase_analytics_helper.dart';

class WebViewPage extends StatefulWidget {
  static const name = "WebViewPage";
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late Map data;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseAnalyticsHelper.trackScreen(screenName: data["title"]);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)?.settings.arguments as Map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customBackground(
        child: Column(
          children: [
            customAppbar(
              title: data["title"],
              onTapBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(data["link"]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
