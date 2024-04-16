import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/viewmodel/learn_vm.dart';

import '../../../constants/constants.dart';
import '../../../helper/firebase/firebase_analytics_helper.dart';
import '../../../models/guides_model.dart';
import '../../../utils/size_utils.dart';
import '../../../utils/text_helper.dart';
import '../../widgets/appbar.dart';
import '../../widgets/common.dart';
import '../../widgets/loading_error_widgets.dart';
import 'widgets.dart';

class LearnDetailsPage extends StatefulWidget {
  static const name = "LearnDetailsPage";
  const LearnDetailsPage({super.key});

  @override
  State<LearnDetailsPage> createState() => _LearnDetailsPageState();
}

class _LearnDetailsPageState extends State<LearnDetailsPage> {
  late Vodtopic arg;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LearnVM>().setSelectedButton("Selection");
      context.read<LearnVM>().setSelectedSelectionIndex(0);
      context.read<LearnVM>().getGuidesDetails(title: arg.topic ?? "");
    });
    FirebaseAnalyticsHelper.trackScreen(screenName: "LearnDetailsPage");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arg = ModalRoute.of(context)?.settings.arguments as Vodtopic;
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<LearnVM>().disposeFlickerManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customBackground(
        child: Column(
          children: [
            customAppbar(
              title: getLocalText.learningCenter,
              onTapBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    if (context.watch<LearnVM>().isLoadingDetails) {
      return loadingWidget();
    } else if (context.watch<LearnVM>().errorDetails != "") {
      return errorWidget(
        error: context.watch<LearnVM>().errorDetails,
        onTryAgain: () => context.read<LearnVM>().getGuidesDetails(title: arg.topic ?? ""),
      );
    } else {
      return ListView(
        children: [
          // imageContainer(
          //   image: "https://cdn.pixabay.com/photo/2018/09/04/10/27/never-stop-learning-3653430_640.jpg",
          //   height: sizer(context, 0.3),
          //   borderRadius: BorderRadius.zero,
          // ),
          SizedBox(
            height: sizer(context, 0.3),
            child: buildVideoView(),
          ),
          h(16),
          Padding(
            padding: paddingH,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                robotoText(
                  text: arg.title ?? "",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                h(16),
                horizontalScrollView(
                  removePadding: true,
                  list: ["Selection", "Materials"].map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: selectedButton(
                          text: e,
                          selected: context.watch<LearnVM>().selectedButton == e,
                          onTap: () {
                            context.read<LearnVM>().setSelectedButton(e);
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
                h(16),
                if (context.watch<LearnVM>().selectedButton == "Selection") selectionListView(),
                if (context.watch<LearnVM>().selectedButton == "Materials") materialsListView(),
                constHeight20(),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget buildVideoView() {
    if (context.watch<LearnVM>().flickManager != null) {
      return FlickVideoPlayer(flickManager: context.watch<LearnVM>().flickManager!);
    } else {
      return errorWidget(
        error: "Video Player is Not Ready",
      );
    }
  }

  selectionListView() {
    if ((context.watch<LearnVM>().guideDetailsModel?.vod ?? []).isEmpty) {
      return noItemsFoundWidget(text: "Selections Not Found");
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (context.watch<LearnVM>().guideDetailsModel?.vod ?? []).length,
        itemBuilder: (context, index) {
          var e = context.watch<LearnVM>().guideDetailsModel?.vod?[index];
          return selectionContainer(
            title: e?.titel ?? "",
            desc: e?.beschreibung ?? "",
            selected: context.watch<LearnVM>().selectedSelectionIndex == index,
            onTap: () {
              context.read<LearnVM>().setSelectedSelectionIndex(index);
              context.read<LearnVM>().setFlickerManager(url: e?.url ?? "");
            },
          );
        },
      );
    }
  }

  materialsListView() {
    return noItemsFoundWidget(text: "Material Not Found");
    // return ListView.builder(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: 5,
    //   itemBuilder: (context, index) {
    //     return selectionContainer(
    //       title: "Selection ${index + 1}",
    //       desc: "How To Customize A Personal TrendTok Album",
    //       selected: index == 0,
    //     );
    //   },
    // );
  }
}
