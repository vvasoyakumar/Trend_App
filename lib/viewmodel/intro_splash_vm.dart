import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:trend_radar/constants/constants.dart';
import 'package:trend_radar/utils/shared_pref_helper.dart';

import '../utils/text_helper.dart';
import '../view/pages/dashboard.dart';
import '../view/pages/webview/webview_page.dart';

class IntroVM extends ChangeNotifier {
  int introSliderIndex = 0;

  setIntroSliderIndex(int val) {
    introSliderIndex = val;
    notifyListeners();
  }

  bool privacyPolicy = false;
  bool termsAndCondition = false;

  setPrivacyPolicy(bool val) {
    privacyPolicy = val;
    notifyListeners();
  }

  setTermsAndCondition(bool val) {
    termsAndCondition = val;
    notifyListeners();
  }

  VoidCallback onTapNext({required CarouselController carouselController}) {
    return () {
      if (introSliderIndex != 2) {
        carouselController.animateToPage(introSliderIndex + 1);
      } else {
        onTapSkip();
      }
    };
  }

  onTapSkip() async {
    await SharedPrefHelper.saveBool(key: SharedPrefHelper.isVisitedIntro, value: true);
    navigatorKey.currentState?.pushNamedAndRemoveUntil(DashBoard.name, (route) => false);
  }

  onTapTermsAndConditions() {
    navigatorKey.currentState?.pushNamed(
      WebViewPage.name,
      arguments: {"title": getLocalText.generalTermsAndConditions, "link": "https://example.com"},
    );
  }

  onTapDataProtectionRegulations() {
    navigatorKey.currentState?.pushNamed(
      WebViewPage.name,
      arguments: {"title": getLocalText.dataProtectionRegulations, "link": "https://example.com"},
    );
  }
}
