import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utils/text_helper.dart';

Widget noInternetDialog() {
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: AlertDialog(
      backgroundColor: gradiant1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: robotoText(
        text: "No Internet",
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
      content: robotoText(
        text: "This app only works with an internet connection. Please ensure that you are connected.",
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
