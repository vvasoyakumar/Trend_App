import 'package:flutter/cupertino.dart';

class SearchVM extends ChangeNotifier {
  bool isLoading = false;
  String searchText = "";

  setLoadingState(bool val) {
    isLoading = val;
    notifyListeners();
  }

  changeSearchText(String val) {
    searchText = val;
    notifyListeners();
  }
}
