import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../constants/images.dart';
import '../../utils/size_utils.dart';
import '../../utils/text_helper.dart';

Widget customVideoTile({
  required BuildContext context,
  required String image,
  required String title,
  required String number,
  required String savedNumber,
  required int hotness,
  VoidCallback? onTap,
  VoidCallback? onTapPlay,
  VoidCallback? onTapSave,
  bool? isUp,
  bool? isDown,
  bool? isCircle,
  bool? isSaved,
}) {
  String hotIconList = "";

  for (int i = 0; i <= hotness; i++) {
    hotIconList += "🔥";
  }

  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Column(
              children: [
                Image.asset(
                  AppImages.arrowUp,
                  height: 16,
                  color: isUp == true ? null : Colors.transparent,
                ),
                h(5),
                robotoText(
                  text: number,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
                h(5),
                // Image.asset(AppImages.arrowDown, height: 16),
                Image.asset(
                  isCircle == true ? AppImages.circle : AppImages.arrowDown,
                  height: 16,
                  color: isCircle == true
                      ? null
                      : isDown == true
                          ? null
                          : Colors.transparent,
                ),
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constWidth20(),
                  imageContainer(
                    image: image,
                    width: sizer(context, 0.105),
                    height: sizer(context, 0.105),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  w(13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        robotoText(text: title, fontWeight: FontWeight.w700, fontSize: 20, maxLines: 2),
                        robotoText(text: hotIconList)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onTapSave,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AppImages.label, height: 30, color: isSaved == true ? primary : null),
                  robotoText(text: savedNumber, fontSize: 9.5, fontWeight: FontWeight.w900),
                ],
              ),
            ),
            constWidth20(),
            GestureDetector(onTap: onTapPlay, child: Image.asset(AppImages.play, height: 28)),
          ],
        ),
      ),
      const Divider(color: white),
    ],
  );
}

Widget customBackground({required Widget child}) {
  return Stack(
    children: [
      Ink(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              gradiant1,
              black,
            ],
          ),
        ),
      ),
      SafeArea(
        child: child,
      )
    ],
  );
}

Widget titleTile({required String title, VoidCallback? seeAll, required BuildContext context}) {
  return Container(
    padding: paddingH,
    margin: const EdgeInsets.only(top: 16, bottom: 8),
    child: Row(
      children: [
        robotoText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
        const Spacer(),
        if (seeAll != null)
          InkWell(
            onTap: seeAll,
            child: robotoText(
              text: getLocalText.seAll,
              fontSize: 14,
            ),
          ),
      ],
    ),
  );
}

Widget imageContainer({double? width, double? height, required String image, BorderRadius? borderRadius}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: imageBackGround,
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(
          image,
        ),
      ),
    ),
  );
}

Widget horizontalScrollView({required List<Widget> list, bool? removePadding}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (removePadding != true) w(16),
        ...list,
      ],
    ),
  );
}

searchTextFiled(
    {Function(String val)? onChange, required BuildContext context, TextEditingController? controller}) {
  return TextField(
    controller: controller,
    onChanged: onChange,
    style: robotoStyle(color: grey.shade800),
    decoration: InputDecoration(
      fillColor: textFiledBackground,
      filled: true,
      hintText: getLocalText.search,
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        gapPadding: 0,
        borderSide: const BorderSide(width: 0, color: Colors.transparent, strokeAlign: 0),
        borderRadius: BorderRadius.circular(100),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 0,
        borderSide: const BorderSide(width: 0, color: Colors.transparent, strokeAlign: 0),
        borderRadius: BorderRadius.circular(100),
      ),
      hintStyle: robotoStyle(color: grey.shade700),
      prefixIcon: Icon(Icons.search, color: grey.shade600),
    ),
  );
}

Widget selectedButton({required String text, required bool selected, VoidCallback? onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(100),
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: selected ? primary : unSelectedColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: robotoText(text: text, fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
}

Widget blackBackgroundIconButton({VoidCallback? onTap, required IconData icon}) {
  return Container(
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: black,
    ),
    child: IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: white,
      ),
    ),
  );
}

Widget customButton({required String name, required double width, VoidCallback? onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(100),
    onTap: onTap,
    child: Ink(
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.7),
            offset: const Offset(0, 5),
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: robotoText(text: name, fontSize: 22, textAlign: TextAlign.center),
      ),
    ),
  );
}

Widget customDialogButton(
    {required String name,
    required double width,
    VoidCallback? onTap,
    Color? color,
    Color? textColor,
    Color? splashColor}) {
  return InkWell(
    focusColor: splashColor,
    splashColor: splashColor,
    borderRadius: BorderRadius.circular(100),
    onTap: onTap,
    child: Ink(
      decoration: BoxDecoration(
        color: color ?? primary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: robotoText(
            text: name,
            fontSize: 16,
            textAlign: TextAlign.center,
            color: textColor,
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}
