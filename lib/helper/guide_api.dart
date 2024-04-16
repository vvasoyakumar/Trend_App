import '../constants/api_const.dart';
import '../models/guide_details_model.dart';
import '../models/guides_model.dart';
import '../utils/custom_print.dart';
import 'api_helper.dart';

class GuideApi {
  static Future<GuidesModel?> getGuides() async {
    try {
      var res = await ApiHelper.get(api: getGuidesApi);
      if (res is Map<String, dynamic>) {
        return GuidesModel.fromJson(res);
      } else if (res is List) {
        if (res.isNotEmpty) {
          return GuidesModel.fromJson(res[0]);
        }
      }
    } catch (e) {
      customPrint("getGuides ===>>> Error $e");
      rethrow;
    }
    return null;
  }

  static Future<GuideDetailsModel?> getGuidesDetails({required String name}) async {
    try {
      var res = await ApiHelper.get(api: "$getGuidesApi/$name");
      if (res is Map<String, dynamic>) {
        return GuideDetailsModel.fromJson(res);
      } else if (res is List) {
        if (res.isNotEmpty) {
          return GuideDetailsModel.fromJson(res[0]);
        }
      }
    } catch (e) {
      customPrint("getGuidesDetails ===>>> Error $e");
      rethrow;
    }
    return null;
  }
}
