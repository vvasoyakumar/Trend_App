import 'package:dio/dio.dart';

import '../constants/api_const.dart';
import '../utils/custom_print.dart';
// import '../generated_code/video_api.swagger.dart' as video_api;

class ApiHelper {
  // static video_api.VideoApi videoApi = video_api.VideoApi.create(baseUrl: Uri.parse(baseUrl));

  static final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {"accept": "application/json"},
  ));

  static Future<dynamic> get({required String api}) async {
    try {
      Response response = await dio.get(api);
      customPrint("Dio get ===>>> $baseUrl$api || Response || ${response.statusCode} ${response.data}");
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        customPrint("DioException ===>>> $baseUrl$api || Response || ${e.response?.data} || ${e.error}");
        return e.response;
      } else {
        customPrint("DioException ===>>> $baseUrl$api || Response || Something Went Wrong");
        return {"status": "error", "message": "Something Went Wrong"};
      }
    }
  }

  static Future<dynamic> post({required String api, FormData? formData, Options? options}) async {
    try {
      customPrint(
          "Dio post ===>>> $baseUrl$api || Request || ${formData?.fields.map((e) => "${e.key} : ${e.value}")}");
      Response response = await dio.post(api, data: formData, options: options);
      customPrint("Dio post ===>>> $baseUrl$api || Response || ${response.statusCode} ${response.data}");
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        customPrint("DioException ===>>> $baseUrl$api || Response || ${e.response?.data} || ${e.error}");
        return e.response;
      } else {
        customPrint("DioException ===>>> $baseUrl$api || Response || Something Went Wrong");
        return {"status": "error", "message": "Something Went Wrong"};
      }
    }
  }
}
