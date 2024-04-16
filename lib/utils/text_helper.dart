import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trend_radar/constants/constants.dart';

import '../constants/colors.dart';

AppLocalizations get getLocalText => AppLocalizations.of(navigatorKey.currentState!.context)!;

Text robotoText(
    {required String text,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    int? maxLines,
    TextAlign? textAlign}) {
  return Text(
    text,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    textAlign: textAlign,
    maxLines: maxLines,
    textScaleFactor: 1,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        color: color ?? white,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}

TextStyle robotoStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  TextDecoration? decoration,
}) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      color: color ?? white,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
    ),
  );
}

String formatNumber(int number) {
  if (number >= 1000000) {
    return '${number ~/ 1000000}M';
  } else if (number >= 1000) {
    return '${number ~/ 1000}K';
  } else {
    return number.toString();
  }
}
