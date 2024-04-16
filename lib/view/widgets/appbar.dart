import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../utils/text_helper.dart';
import 'common.dart';

Widget customAppbar(
    {VoidCallback? onTapBack, VoidCallback? onTapFavourite, required String title, String? subTitle}) {
  return Container(
    height: subTitle != null ? 70 : 56,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            if (onTapBack != null)
              IconButton(
                onPressed: onTapBack,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: primary,
                ),
              ),
            const Spacer(),
            if (onTapFavourite != null)
              blackBackgroundIconButton(icon: Icons.favorite_border, onTap: onTapFavourite),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            robotoText(text: title, fontSize: 20, fontWeight: FontWeight.w900, maxLines: 1),
            if (subTitle != null)
              robotoText(text: subTitle, fontSize: 12, fontWeight: FontWeight.w700, maxLines: 1),
          ],
        ),
      ],
    ),
  );
}
