import 'package:flutter/cupertino.dart';

class DashBoardVM extends ChangeNotifier {
  int bottomNavigationIndex = 0;

  setBottomNavigationIndex(int val) {
    bottomNavigationIndex = val;
    notifyListeners();
  }
}
