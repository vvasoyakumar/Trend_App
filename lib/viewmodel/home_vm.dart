import 'package:flutter/cupertino.dart';
import 'package:trend_radar/models/video_details_model.dart';

import '../helper/video_api.dart';

class HomeVM extends ChangeNotifier {
  // VideoDetails

  bool isLoadingVideoDetails = false;
  String errorVideoDetails = "";
  VideoDetailsModel? videoDetails;

  setLoadingVideoDetailsState(bool val) {
    isLoadingVideoDetails = val;
    notifyListeners();
  }

  setErrorVideoDetailsSate(String val) {
    errorVideoDetails = val;
    notifyListeners();
  }

  Future getVideoDetails({required String id}) async {
    setErrorVideoDetailsSate("");
    setLoadingVideoDetailsState(true);
    try {
      await VideoApi.getVideoDetails(id: id).then(
        (value) {
          setLoadingVideoDetailsState(false);
          if (value?.error != "") {
            setErrorVideoDetailsSate(value?.error ?? "");
          }
          videoDetails = value;
          notifyListeners();
        },
      );
    } catch (e) {
      setLoadingVideoDetailsState(false);
      setErrorVideoDetailsSate(e.toString());
    }
  }
}
