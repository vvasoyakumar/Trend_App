import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../utils/custom_print.dart';
import 'local_notification_helper.dart';

class NotificationHelper {
  /// initNotification Call This Function in MyApp init

  static initNotification() async {
    await NotificationHelper().initFCM();
    await LocalNotificationHelper.initLocalNotification();
    await FirebaseMessaging.instance.subscribeToTopic("AllUsers");
    if (Platform.isAndroid) {
      await FirebaseMessaging.instance.subscribeToTopic("AndroidUsers");
    }
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.subscribeToTopic("IOSUsers");
    }
    customPrint("Notification Initialize");
  }

  Future<void> initFCM() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    await Future.delayed(const Duration(seconds: 1), () async {
      final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        handleDataAndRoute(initialMessage.data);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) => handleDataAndRoute(event.data));
    FirebaseMessaging.onMessage.listen(showNotification);
  }

  Future<void> showNotification(RemoteMessage message) async {
    customPrint("===>>> Notification Data = ${message.data}");
    try {
      await LocalNotificationHelper.simpleNotification(
        id: message.notification.hashCode,
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        payload: jsonEncode(message.data),
      );
    } catch (e) {
      customPrint("===>>> Notification Error = ${e.toString()}");
    }
  }

  /// getFirebaseToken

  static Future<String> getFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    customPrint("===>>> FCM Token :: $fcmToken");
    return fcmToken;
  }

  /// handleDataAndRoute Get Data After Press User on Notification (Add Route Hear Or Use Data For Specific Task)

  static handleDataAndRoute(Map data) {
    customPrint("===>>> Notification handleDataAndRoute ===>> $data");
    if (data["type"] == "lead_sent_history") {
      // if (payload["lead_id"] != null) {
      //   AppConstants.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      //       PackageScreen.name, arguments: {"lead_id": payload["lead_id"]}, (route) => false);
      // }
    }
    if (data["type"] == "announcement") {
      // AppConstants.navigatorKey.currentState
      //     ?.pushNamedAndRemoveUntil(NotificationPage.name, (route) => false);
    }
  }
}
