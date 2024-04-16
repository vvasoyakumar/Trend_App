import 'package:flutter/material.dart';
import 'package:trend_radar/utils/text_helper.dart';

import '../../utils/size_utils.dart';

loadingWidget({bool? isStack}) {
  if (isStack == true) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: loadingWidget(),
    );
  }
  return const Center(child: CircularProgressIndicator());
}

errorWidget({String? error, VoidCallback? onTryAgain}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        robotoText(text: error ?? getLocalText.somethingWentWrong, textAlign: TextAlign.center),
        if (onTryAgain != null) constHeight10(),
        if (onTryAgain != null)
          OutlinedButton.icon(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: onTryAgain,
            label: robotoText(
              text: "Try Aging",
            ),
          ),
      ],
    ),
  );
}

noItemsFoundWidget({String? text, VoidCallback? onTryAgain}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        constHeight20(),
        robotoText(
          text: text ?? getLocalText.itemsNotFound,
          fontSize: 16,
          textAlign: TextAlign.center,
        ),
        constHeight20(),
        if (onTryAgain != null) constHeight10(),
        if (onTryAgain != null)
          OutlinedButton.icon(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: onTryAgain,
            label: robotoText(
              text: "Try Aging",
            ),
          ),
      ],
    ),
  );
}
