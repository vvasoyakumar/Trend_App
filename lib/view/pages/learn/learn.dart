import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/utils/size_utils.dart';
import 'package:trend_radar/utils/text_helper.dart';
import 'package:trend_radar/view/pages/learn/learn_details_page.dart';
import 'package:trend_radar/viewmodel/learn_vm.dart';

import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../helper/firebase/firebase_analytics_helper.dart';
import '../../../viewmodel/plan_vm.dart';
import '../../widgets/appbar.dart';
import '../../widgets/loading_error_widgets.dart';
import 'widgets.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<LearnVM>().guidesData == null) {
        context.read<LearnVM>().getGuides();
      }
    });
    FirebaseAnalyticsHelper.trackScreen(screenName: "Learn");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customAppbar(
          title: getLocalText.learningCenter,
        ),
        Expanded(
          child: buildBody(),
        )
      ],
    );
  }

  Widget buildBody() {
    if (context.watch<LearnVM>().isLoading) {
      return loadingWidget();
    } else if (context.watch<LearnVM>().error != "") {
      return errorWidget(
        error: context.watch<LearnVM>().error,
        onTryAgain: () => context.read<LearnVM>().getGuides(),
      );
    } else if (context.watch<LearnVM>().guidesData != null &&
        (context.watch<LearnVM>().guidesData?.vodtopics ?? []).isEmpty) {
      return noItemsFoundWidget(
        onTryAgain: () {
          context.read<LearnVM>().getGuides();
        },
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await context.read<LearnVM>().getGuides(isRefresh: true);
        },
        child: ListView(
          padding: paddingH,
          children: [
            robotoText(
              text: "Our TikTok Masterclass",
              fontSize: 28,
              color: primary,
              fontWeight: FontWeight.w800,
            ),
            h(5),
            robotoText(
              text: "How To Crack The TikTok Algorithm",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            constHeight10(),
            robotoText(
              text:
                  "Learn how to crack the TikTok algorithm. Boost your content organically, and create consistent viral-worthy content on TikTok.",
              color: grey.shade300,
              fontSize: 16,
            ),
            constHeight20(),
            DynamicHeightGridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isPortrait(context) ? 2 : 3,
              itemCount: (context.watch<LearnVM>().guidesData?.vodtopics ?? []).length,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              builder: (context, index) {
                var e = context.watch<LearnVM>().guidesData?.vodtopics?[index];
                return learnContainer(
                  isUnlocked:
                      index == 0 || context.watch<PlanVM>().checkUnlockCategory(title: e?.title ?? ""),
                  context: context,
                  e: e!,
                  onTap: () {
                    if (index == 0 || context.read<PlanVM>().checkUnlockCategory(title: e.title ?? "")) {
                      Navigator.pushNamed(context, LearnDetailsPage.name, arguments: e);
                    } else {
                      context
                          .read<PlanVM>()
                          .showPlanSheet(context: context, unlockProductName: e.title ?? "");
                    }
                  },
                );
              },
            ),
            constHeight20(),
          ],
        ),
      );
    }
  }
}
