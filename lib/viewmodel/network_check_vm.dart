import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:trend_radar/constants/constants.dart';
import 'package:trend_radar/view/widgets/no_internet_dialog.dart';

class NetworkCheckVM extends ChangeNotifier {
  bool isOffline = false;
  bool isOpen = false;

  setOfflineState(bool val) {
    isOffline = val;
    notifyListeners();
  }

  initNetworkStateAndStartListen() async {
    await Connectivity().checkConnectivity().then((value) {
      checkAndShowDialog(result: value);
    });

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      checkAndShowDialog(result: result);
    });
  }

  checkAndShowDialog({required ConnectivityResult result}) {
    if (isOpen) {
      navigatorKey.currentState!.pop();
      isOpen = false;
    }
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet) {
      setOfflineState(false);
      print("Network State isOffline ===>>> $isOffline");
    } else {
      setOfflineState(true);
      print("Network State isOffline ===>>> $isOffline");
      if (isOpen == false) {
        isOpen = true;
        showDialog(
          barrierDismissible: false,
          context: navigatorKey.currentState!.context,
          builder: (context) => noInternetDialog(),
        ).then((value) {
          isOpen = false;
        });
      }
    }
  }
}
