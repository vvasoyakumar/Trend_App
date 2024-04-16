import 'package:flutter/material.dart';

const primary = Color(0xff57BF74);
const red = Color(0xffE8261B);
const purple = Color(0xff4935F6);
const grey = Colors.grey;
const imageBackGround = Colors.grey;
const greyBackground = Color(0xff808080);
const bottomBackground = Color(0xff282828);
const textFiledBackground = Color(0xffCCCCCC);
const unSelectedColor = Color(0xff2E2E2E);
const textFiledText = Color(0xff9AA1A8);
const gradiant1 = Color(0xff1C283E);
const black = Colors.black;
const white = Colors.white;

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006D33),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF90F9A7),
  onPrimaryContainer: Color(0xFF00210B),
  secondary: Color(0xFF506352),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD3E8D2),
  onSecondaryContainer: Color(0xFF0E1F12),
  tertiary: Color(0xFF39656E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFBDEAF4),
  onTertiaryContainer: Color(0xFF001F25),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFDF7),
  onBackground: Color(0xFF191C19),
  surface: Color(0xFFFCFDF7),
  onSurface: Color(0xFF191C19),
  surfaceVariant: Color(0xFFDDE5DA),
  onSurfaceVariant: Color(0xFF414941),
  outline: Color(0xFF717970),
  onInverseSurface: Color(0xFFF0F1EC),
  inverseSurface: Color(0xFF2E312E),
  inversePrimary: Color(0xFF74DC8D),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006D33),
  outlineVariant: Color(0xFFC1C9BE),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF74DC8D),
  onPrimary: Color(0xFF003918),
  primaryContainer: Color(0xFF005225),
  onPrimaryContainer: Color(0xFF90F9A7),
  secondary: Color(0xFFB7CCB7),
  onSecondary: Color(0xFF233426),
  secondaryContainer: Color(0xFF394B3B),
  onSecondaryContainer: Color(0xFFD3E8D2),
  tertiary: Color(0xFFA2CED8),
  onTertiary: Color(0xFF00363E),
  tertiaryContainer: Color(0xFF204D55),
  onTertiaryContainer: Color(0xFFBDEAF4),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C19),
  onBackground: Color(0xFFE2E3DE),
  surface: Color(0xFF191C19),
  onSurface: Color(0xFFE2E3DE),
  surfaceVariant: Color(0xFF414941),
  onSurfaceVariant: Color(0xFFC1C9BE),
  outline: Color(0xFF8B9389),
  onInverseSurface: Color(0xFF191C19),
  inverseSurface: Color(0xFFE2E3DE),
  inversePrimary: Color(0xFF006D33),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF74DC8D),
  outlineVariant: Color(0xFF414941),
  scrim: Color(0xFF000000),
);
