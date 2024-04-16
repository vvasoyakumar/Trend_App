import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_helper.dart';

class LocalNotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initLocalNotification() async {
    AndroidNotificationChannel channel;

    channel = const AndroidNotificationChannel('high_importance_channel', 'High Importance Notifications',
        importance: Importance.high, playSound: true);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(badge: true, sound: true, alert: true);
    const androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOs =
        DarwinInitializationSettings(defaultPresentAlert: true, requestAlertPermission: true);
    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOs,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        Map<String, dynamic> payload = jsonDecode(response.payload ?? "{}");
        NotificationHelper.handleDataAndRoute(payload);
      },
    );
  }

  static Future<void> simpleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    var android = const AndroidNotificationDetails(
      'id',
      'channel ',
      channelDescription: 'description',
      priority: Priority.max,
      importance: Importance.max,
    );

    var iOS = const DarwinNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platform,
      payload: payload,
    );
  }
}
