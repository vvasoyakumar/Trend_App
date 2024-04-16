import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/constants/colors.dart';
import 'package:trend_radar/constants/constants.dart';

import '../../../utils/size_utils.dart';
import '../../../utils/text_helper.dart';
import '../../../viewmodel/intro_splash_vm.dart';
import '../../widgets/common.dart';
import 'intro_page.dart';

showApprovalDialog({required BuildContext context}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: gradiant1,
          surfaceTintColor: gradiant1,
          title: robotoText(
            text: getLocalText.approval,
            textAlign: TextAlign.center,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: paddingV,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              privacyPolicyTile(
                value: context.watch<IntroVM>().privacyPolicy,
                onChanged: (value) {
                  context.read<IntroVM>().setPrivacyPolicy(value!);
                },
                text: getLocalText.iAgreeWithThe,
                hyperLinkText: getLocalText.dataProtectionRegulations,
                hyperLinkOnTap: context.read<IntroVM>().onTapDataProtectionRegulations,
              ),
              privacyPolicyTile(
                value: context.watch<IntroVM>().termsAndCondition,
                onChanged: (value) {
                  context.read<IntroVM>().setTermsAndCondition(value!);
                },
                text: getLocalText.iAgreeWithThe,
                hyperLinkText: getLocalText.generalTermsAndConditions,
                hyperLinkOnTap: context.read<IntroVM>().onTapTermsAndConditions,
              ),
            ],
          ),
          actions: [
            customDialogButton(
              name: getLocalText.cancel,
              width: 80,
              onTap: () {
                SystemNavigator.pop();
                // Navigator.pop(context);
              },
              color: Colors.transparent,
              textColor: primary,
              splashColor: primary.withOpacity(0.2),
            ),
            customDialogButton(
              name: getLocalText.next,
              width: 80,
              onTap: context.watch<IntroVM>().privacyPolicy && context.watch<IntroVM>().termsAndCondition
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
              color: context.watch<IntroVM>().privacyPolicy && context.watch<IntroVM>().termsAndCondition
                  ? null
                  : grey.withOpacity(0.2),
              textColor: context.watch<IntroVM>().privacyPolicy && context.watch<IntroVM>().termsAndCondition
                  ? null
                  : grey,
            ),
          ],
        ),
      );
    },
  );
}

Widget privacyPolicyTile(
    {required bool value,
    Function(bool?)? onChanged,
    required String text,
    required String hyperLinkText,
    required VoidCallback hyperLinkOnTap}) {
  return ListTile(
    leading: Checkbox(
      activeColor: primary,
      onChanged: onChanged,
      value: value,
    ),
    horizontalTitleGap: 5,
    title: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$text ",
          ),
          TextSpan(
            text: hyperLinkText,
            style: robotoStyle(
              decoration: TextDecoration.underline,
              fontSize: 18,
            ),
            recognizer: TapGestureRecognizer()..onTap = hyperLinkOnTap,
          ),
        ],
        style: robotoStyle(
          fontSize: 18,
          color: grey.shade300,
        ),
      ),
    ),
  );
}

Widget sliderContainer({required BuildContext context, required SliderItems e}) {
  return Container(
    height: sizer(context, 0.71),
    padding: paddingH,
    child: Column(
      children: [
        robotoText(
          text: e.title,
          fontSize: 32,
          color: primary,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
        ),
        if (e.desc != null) h(sizer(context, 0.02)),
        if (e.desc != null)
          robotoText(
            text: e.desc ?? "",
            textAlign: TextAlign.center,
            fontSize: 20,
            color: primary,
            fontWeight: FontWeight.w600,
          ),
        if (e.subDesc != null) h(sizer(context, 0.013)),
        if (e.subDesc != null)
          robotoText(
            text: e.subDesc ?? "",
            textAlign: TextAlign.center,
            color: grey.shade300,
            fontSize: 16,
          ),
        h(sizer(context, 0.025)),
        Expanded(
          child: Image.network(e.image, fit: BoxFit.cover),
        ),
      ],
    ),
  );
}
