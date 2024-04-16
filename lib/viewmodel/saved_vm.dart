import 'package:flutter/cupertino.dart';
import 'package:trend_radar/helper/local_db/local_db_helper.dart';
import 'package:trend_radar/models/local_db_model.dart';
import 'package:trend_radar/models/video_details_model.dart';
import 'package:trend_radar/utils/snack_bar.dart';

import '../helper/video_api.dart';

class SavedVM extends ChangeNotifier {
  bool isLoading = false;
  String error = "";
  List<LocalSaveVideoModel> savedVideos = [];

  List<VideoDetailsModel> savedVideosDetails = [];
  bool isLoadingVideoDetails = false;
  String errorVideoDetails = "";

  setLoadingState(bool val) {
    isLoading = val;
    notifyListeners();
  }

  setErrorSate(String val) {
    error = val;
    notifyListeners();
  }

  setLoadingVideoDetailsState(bool val) {
    isLoadingVideoDetails = val;
    notifyListeners();
  }

  setErrorVideoDetailsSate(String val) {
    errorVideoDetails = val;
    notifyListeners();
  }

  checkVideIsSaved({required String videoId}) {
    int i = savedVideos.indexWhere((element) => element.videoId == videoId);
    if (i >= 0) {
      return true;
    } else {
      return false;
    }
  }

  saveVideo({required String videoId, bool? isFromSavePage}) {
    int i = savedVideos.indexWhere((element) => element.videoId == videoId);
    if (i >= 0) {
      LocalDBHelper.unSaveVideo(id: savedVideos[i].id).then((value) {
        print("value :: $value");
        showToast(msg: "Remove Video From Save");
        savedVideos.removeAt(i);
        if (isFromSavePage == true) {
          int i2 = savedVideosDetails.indexWhere((element) => element.video?.videoId == videoId);
          savedVideosDetails.removeAt(i2);
        }
        notifyListeners();
      });
    } else {
      LocalDBHelper.saveVideo(videoId: videoId).then((value) {
        if (value != null) {
          print("value :: $value");
          showToast(msg: "Video Saved Successfully");
          savedVideos.add(LocalSaveVideoModel(id: value, videoId: videoId));
          notifyListeners();
        }
      });
    }
  }

  Future fetchAllSavedVideos({bool? isRefresh}) async {
    setErrorSate("");
    if (isRefresh == null) setLoadingState(true);
    try {
      List<LocalSaveVideoModel> res = await LocalDBHelper.fetchAllSavedVideos();
      if (isRefresh == null) setLoadingState(false);
      savedVideos = res;
      notifyListeners();
    } catch (e) {
      if (isRefresh == null) setLoadingState(false);
      setErrorSate(e.toString());
    }
  }

  getSavedVideoDetails({bool? isRefresh}) async {
    setErrorVideoDetailsSate("");
    if (isRefresh == null) setLoadingVideoDetailsState(true);
    List<VideoDetailsModel> oldData = savedVideosDetails;
    savedVideosDetails = [];
    try {
      for (var element in savedVideos) {
        int iForDetails = oldData.indexWhere((el) => el.video?.videoId == element.videoId);
        if (iForDetails >= 0) {
          savedVideosDetails.add(oldData[iForDetails]);
        } else {
          await VideoApi.getVideoDetails(id: element.videoId).then(
            (value) {
              if (value != null) {
                savedVideosDetails.add(value);
                notifyListeners();
              }
            },
          );
        }
      }
      if (isRefresh == null) setLoadingVideoDetailsState(false);
    } catch (e) {
      if (isRefresh == null) setLoadingVideoDetailsState(false);
      setErrorVideoDetailsSate(e.toString());
    }
  }
}
