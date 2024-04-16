import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/constants/colors.dart';
import 'package:trend_radar/constants/images.dart';
import 'package:trend_radar/view/widgets/appbar.dart';
import 'package:trend_radar/viewmodel/settings_vm.dart';

import '../../../constants/constants.dart';
import '../../../helper/firebase/firebase_analytics_helper.dart';
import '../../../utils/size_utils.dart';
import '../../../utils/text_helper.dart';
import '../../../utils/url_launcher.dart';
import '../webview/webview_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsHelper.trackScreen(screenName: "Settings");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customAppbar(title: getLocalText.settings),
        Expanded(
          child: ListView(
            padding: padding,
            children: [
              // settingTile(title: getLocalText.customizeForYouAlgorithm, onTapArrow: () {}),
              settingTile(
                title: getLocalText.contactUs,
                onTapArrow: () async {
                  await urlLauncher(url: "mailto:trendtok@gmaigmaill.com");
                },
              ),
              settingTile(
                  title: getLocalText.requestACategory,
                  onTapArrow: () async {
                    await urlLauncher(url: "mailto:trendtok@gmaigmaill.com");
                  }),
              settingTile(title: getLocalText.updateToProAccount, onTapArrow: () {}),
              settingTile(
                title: getLocalText.allowPushNotification,
                switchVal: context.watch<SettingsVM>().allowPushNotification,
                onChange: (val) => context.read<SettingsVM>().setAllowPushNotification(val),
              ),
              settingTile(
                title: getLocalText.data_privacy,
                onTapArrow: () {
                  Navigator.of(context).pushNamed(
                    WebViewPage.name,
                    arguments: {"title": getLocalText.data_privacy, "link": "https://example.com"},
                  );
                },
              ),
              settingTile(
                title: getLocalText.terms_and_conditions,
                onTapArrow: () {
                  Navigator.of(context).pushNamed(
                    WebViewPage.name,
                    arguments: {"title": getLocalText.terms_and_conditions, "link": "https://example.com"},
                  );
                },
              ),
              settingTile(
                title: getLocalText.privacy_policy_options,
                onTapArrow: () {
                  Navigator.of(context).pushNamed(
                    WebViewPage.name,
                    arguments: {"title": getLocalText.privacy_policy_options, "link": "https://example.com"},
                  );
                },
              ),
              // settingTile(
              //   title: getLocalText.businessMode,
              //   switchVal: context.watch<SettingsVM>().businessMode,
              //   onChange: (val) => context.read<SettingsVM>().setBusinessMode(val),
              // ),
              // settingTile(title: getLocalText.getMoreContentIdeas, onTapArrow: () {}),
              h(sizer(context, 0.12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logoButton(
                    image: AppImages.tiktok,
                    onTap: () async {
                      await urlLauncher(url: "https://www.tiktok.com/");
                    },
                  ),
                  logoButton(
                    image: AppImages.instagram,
                    onTap: () async {
                      await urlLauncher(url: "https://www.instagram.com/");
                    },
                  ),
                  logoButton(
                    image: AppImages.twitter,
                    onTap: () async {
                      await urlLauncher(url: "https://twitter.com/");
                    },
                  ),
                ],
              ),
              h(16),
              robotoText(
                text: getLocalText.settingDesc1,
                fontSize: 16,
                textAlign: TextAlign.center,
              ),
              robotoText(
                text: getLocalText.settingDesc2,
                fontSize: 16,
                textAlign: TextAlign.center,
              ),
              constHeight20(),
            ],
          ),
        ),
      ],
    );
  }

  logoButton({required String image, VoidCallback? onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: Image.asset(image, color: primary, height: 25),
    );
  }

  settingTile(
      {required String title,
      VoidCallback? onTap,
      VoidCallback? onTapArrow,
      Function(bool val)? onChange,
      bool? switchVal}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTapArrow ?? onTap,
          child: Row(
            children: [
              Expanded(
                child: robotoText(text: title, fontSize: 18),
              ),
              IconButton(
                onPressed: onTapArrow,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: onTapArrow == null ? Colors.transparent : primary,
                ),
              ),
              if (switchVal != null)
                CupertinoSwitch(
                  value: switchVal,
                  onChanged: onChange,
                  trackColor: unSelectedColor,
                ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
