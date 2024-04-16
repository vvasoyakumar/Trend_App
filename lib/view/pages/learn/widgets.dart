import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../models/guides_model.dart';
import '../../../utils/size_utils.dart';
import '../../../utils/text_helper.dart';
import '../../widgets/common.dart';

Widget selectionContainer(
    {required String title, required String desc, required bool selected, VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selected ? primary : unSelectedColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            robotoText(
              text: title,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            robotoText(
              text: desc,
              fontSize: 15,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget learnContainer(
    {required BuildContext context, required Vodtopic e, VoidCallback? onTap, bool? isUnlocked}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            imageContainer(image: e.thumbnail ?? "", height: sizer(context, 0.2)),
            if (isUnlocked != true)
              Container(
                padding: const EdgeInsets.all(3.5),
                margin: const EdgeInsets.only(right: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: greyBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.lock_rounded, color: white, size: 20),
              ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 10),
          color: white.withOpacity(0.9),
          child: robotoText(
            text: e.title ?? "",
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: black,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            decoration: BoxDecoration(
              color: black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 3),
            child: robotoText(text: "${e.duration} min", fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}
