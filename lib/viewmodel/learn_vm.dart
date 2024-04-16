import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:trend_radar/helper/guide_api.dart';
import 'package:video_player/video_player.dart';

import '../models/guide_details_model.dart';
import '../models/guides_model.dart';
import '../utils/custom_print.dart';

class LearnVM extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadingDetails = false;
  String selectedButton = "";
  String error = "";
  String errorDetails = "";
  GuidesModel? guidesData;
  int selectedSelectionIndex = 0;
  GuideDetailsModel? guideDetailsModel;
  FlickManager? flickManager;

  setLoadingState(bool val) {
    isLoading = val;
    notifyListeners();
  }

  setLoadingDetailsState(bool val) {
    isLoadingDetails = val;
    notifyListeners();
  }

  setSelectedButton(String val) {
    selectedButton = val;
    notifyListeners();
  }

  setErrorSate(String val) {
    error = val;
    notifyListeners();
  }

  setErrorDetailsSate(String val) {
    errorDetails = val;
    notifyListeners();
  }

  setSelectedSelectionIndex(int val) {
    selectedSelectionIndex = val;
    notifyListeners();
  }

  Future getGuides({bool? isRefresh}) async {
    setErrorSate("");
    if (isRefresh == null) setLoadingState(true);
    try {
      await GuideApi.getGuides().then(
        (value) {
          if (value?.error != "") {
            setErrorSate(value?.error ?? "");
          }
          guidesData = value;
          notifyListeners();
          if (isRefresh == null) setLoadingState(false);
        },
      );
    } catch (e) {
      if (isRefresh == null) setLoadingState(false);
      setErrorSate(e.toString());
    }
  }

  Future getGuidesDetails({required String title}) async {
    setLoadingDetailsState(true);
    setErrorDetailsSate("");
    try {
      await GuideApi.getGuidesDetails(name: title).then(
        (value) {
          setLoadingDetailsState(false);
          if (value != null) {
            if ((value.error ?? "") != "") {
              setErrorDetailsSate(value.error ?? "");
            }
            if ((value.vod ?? []).isNotEmpty) {
              setFlickerManager(url: value.vod?[0].url);
            }
          } else {
            setErrorDetailsSate("Details Not Found");
          }
          guideDetailsModel = value;
          notifyListeners();
        },
      );
    } catch (e) {
      setLoadingDetailsState(false);
      setErrorDetailsSate(e.toString());
    }
  }

  disposeFlickerManager() {
    flickManager?.dispose();
    flickManager = null;
    customPrint("disposeFlickerManager ==>> ${flickManager}");
  }

  setFlickerManager({required String? url}) {
    customPrint("===>>> setFlickerManager $url");
    if (url != null && url != "") {
      if (flickManager == null) {
        flickManager = FlickManager(
          autoPlay: false,
          videoPlayerController: VideoPlayerController.networkUrl(
            Uri.parse(
              // "https://media.istockphoto.com/id/1455772765/video/waterfall-with-fresh-water-in-the-romantic-and-idyllic-tropical-jungle-rainforest-blue.mp4?s=mp4-640x640-is&k=20&c=-ufHs0M4TG0HCyntsf3RwpHP08EEtAlSv8APcZe6Ciw=",
              url,
            ),
          ),
        );
      } else {
        flickManager?.handleChangeVideo(VideoPlayerController.networkUrl(
          Uri.parse(
            // "https://media.istockphoto.com/id/1455772765/video/waterfall-with-fresh-water-in-the-romantic-and-idyllic-tropical-jungle-rainforest-blue.mp4?s=mp4-640x640-is&k=20&c=-ufHs0M4TG0HCyntsf3RwpHP08EEtAlSv8APcZe6Ciw=",
            url,
          ),
        ));
      }
    } else {
      setErrorDetailsSate("Url not Found");
    }
  }
}
