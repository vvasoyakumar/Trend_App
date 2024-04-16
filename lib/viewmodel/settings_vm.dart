import 'package:flutter/cupertino.dart';

class SettingsVM extends ChangeNotifier {
  bool isLoading = false;
  bool businessMode = false;
  bool allowPushNotification = false;

  setLoadingState(bool val) {
    isLoading = val;
    notifyListeners();
  }

  setBusinessMode(bool val) {
    businessMode = val;
    notifyListeners();
  }

  setAllowPushNotification(bool val) {
    allowPushNotification = val;
    notifyListeners();
  }
}
