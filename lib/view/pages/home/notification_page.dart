import 'package:flutter/material.dart';
import 'package:trend_radar/utils/size_utils.dart';

import '../../../../utils/text_helper.dart';
import '../../../constants/colors.dart';
import '../../../helper/firebase/firebase_analytics_helper.dart';
import '../../widgets/appbar.dart';
import '../../widgets/common.dart';

class NotificationPage extends StatefulWidget {
  static const name = "NotificationPage";
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsHelper.trackScreen(screenName: "NotificationPage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customBackground(
        child: Column(
          children: [
            customAppbar(
              title: getLocalText.notification,
              onTapBack: () => Navigator.pop(context),
              // onTapFavourite: () {},
            ),
            Expanded(child: noDataUI()),
          ],
        ),
      ),
    );
  }

  noDataUI() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notifications, size: 40, color: primary),
          h(5),
          robotoText(
            text: getLocalText.no_notification_available,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
