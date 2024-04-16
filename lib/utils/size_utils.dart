import 'package:flutter/material.dart';

double sizer(BuildContext context, double size) {
  if ((MediaQuery.of(context).orientation == Orientation.portrait)) {
    return MediaQuery.of(context).size.height * size;
  } else {
    return MediaQuery.of(context).size.width * size;
  }
}

double height(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * height;
}

double width(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * width;
}

bool isPortrait(BuildContext context) {
  if ((MediaQuery.of(context).orientation == Orientation.portrait)) {
    return true;
  } else {
    return false;
  }
}

SizedBox h(double h) {
  return SizedBox(height: h);
}

SizedBox w(double w) {
  return SizedBox(width: w);
}

Widget constHeight10() {
  return h(10);
}

Widget constWidth10() {
  return w(10);
}

Widget constHeight20() {
  return h(20);
}

Widget constWidth20() {
  return w(20);
}
