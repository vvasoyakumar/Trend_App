import 'package:trend_radar/constants/api_const.dart';
import 'package:trend_radar/helper/api_helper.dart';

import '../models/category_details_model.dart';
import '../models/video_details_model.dart';
import '../utils/custom_print.dart';

class VideoApi {
  static Future<List<CategoryDetailsModel>> getCategoryDetailsVideos(
      {required int pageNumber, int? categories, String? search}) async {
    try {
      var res = await ApiHelper.get(
          api:
              "$getVideosApi?categories=${categories ?? ""}&searchterm=${search ?? ""}&pageSize=10&pageNumber=$pageNumber");
      if (res is List) {
        List<CategoryDetailsModel> list = res.map((e) => CategoryDetailsModel.fromJson(e)).toList();
        return list;
      } else {
        return [];
      }
    } catch (e) {
      customPrint("getCategoryDetailsVideos ===>>> Error $e");
      rethrow;
    }
  }

  static Future<VideoDetailsModel?> getVideoDetails({required String id}) async {
    try {
      var res = await ApiHelper.get(api: "$getVideoDetailsApi/$id/detail");
      if (res is Map<String, dynamic>) {
        return VideoDetailsModel.fromJson(res);
      } else if (res is List) {
        if (res.isNotEmpty) {
          return VideoDetailsModel.fromJson(res[0]);
        }
      }
    } catch (e) {
      customPrint("getVideoDetails ===>>> Error $e");
      rethrow;
    }
  }
}
