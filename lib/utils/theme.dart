import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: buildMaterialColor(primary),
    primaryColor: primary,
    fontFamily: GoogleFonts.roboto().fontFamily,
    colorScheme: lightColorScheme,
  );
}

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: buildMaterialColor(primary),
    primaryColor: primary,
    fontFamily: GoogleFonts.roboto().fontFamily,
    colorScheme: darkColorScheme,
  );
}
