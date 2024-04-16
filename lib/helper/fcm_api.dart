import 'package:dio/dio.dart';
import 'package:trend_radar/helper/notification/notification_helper.dart';

import '../constants/api_const.dart';
import '../models/guides_model.dart';
import '../utils/custom_print.dart';
import 'api_helper.dart';

class FcmApi {
  static Future<GuidesModel?> setFcmToken() async {
    try {
      String fcmToken = await NotificationHelper.getFcmToken();

      var res = await ApiHelper.post(
        api: fcmTokenApi,
        formData: FormData.fromMap(
          {"user_id": "12345", "fcm_token": fcmToken},
        ),
        options: Options(
          headers: {
            "Authorization": "3978846951945868dc73c4ea2a7e2fe3b5d2a8de5ed50e04e1743a727ce09376",
          },
        ),
      );
    } catch (e) {
      customPrint("getGuides ===>>> Error $e");
      // rethrow;
    }
    return null;
  }
}
