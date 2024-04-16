import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:trend_radar/utils/custom_print.dart';

class FirebaseAnalyticsHelper {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future trackScreen({required String screenName}) async {
    customPrint("FirebaseAnalyticsHelper || trackScreen ===>>> $screenName");
    await analytics.setCurrentScreen(screenName: screenName);
  }

  static Future logEventVideoOpen({required String videoId}) async {
    customPrint("FirebaseAnalyticsHelper || log event ||VideoOpen => video_id => $videoId");
    await FirebaseAnalytics.instance.logEvent(
      name: "VideoOpen",
      parameters: {
        "video_id": videoId,
      },
    );
  }

  static Future logEventVideoDetails({required String videoId}) async {
    customPrint("FirebaseAnalyticsHelper || log event || VideoDetails ===>>> video_id => $videoId");
    await FirebaseAnalytics.instance.logEvent(
      name: "VideoDetails",
      parameters: {
        "video_id": videoId,
      },
    );
  }

  static Future logEventCategoryOpen({required String categoryName}) async {
    customPrint("FirebaseAnalyticsHelper || log event || CategoryOpen ===>>> category_name => $categoryName");
    await FirebaseAnalytics.instance.logEvent(
      name: "CategoryOpen",
      parameters: {
        "category_name": categoryName,
      },
    );
  }
}
