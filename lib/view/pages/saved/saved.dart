import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/constants/constants.dart';
import 'package:trend_radar/utils/size_utils.dart';
import 'package:trend_radar/viewmodel/saved_vm.dart';

import '../../../constants/colors.dart';
import '../../../helper/firebase/firebase_analytics_helper.dart';
import '../../../models/common_models.dart';
import '../../../utils/text_helper.dart';
import '../../widgets/appbar.dart';
import '../../widgets/common.dart';
import '../../widgets/loading_error_widgets.dart';
import '../home/video_details_page.dart';
import '../video_player/full_screen_player_page.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<SavedVM>().savedVideosDetails.isEmpty) {
        context.read<SavedVM>().getSavedVideoDetails();
      } else {
        context.read<SavedVM>().getSavedVideoDetails(isRefresh: true);
      }
    });
    FirebaseAnalyticsHelper.trackScreen(screenName: "Saved");
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        customAppbar(
          title: getLocalText.savedVideos,
          subTitle: getLocalText.savedVideosAppBarDesc,
        ),
        Expanded(
          child: buildBody(),
        ),
        // Expanded(
        //   child: ListView.builder(
        //     padding: const EdgeInsets.symmetric(horizontal: 23),
        //     physics: physics,
        //     itemCount: 10,
        //     itemBuilder: (context, index) {
        //       return customVideoTile(
        //         // isUp: true,
        //         // isCircle: true,
        //         // isDown: true,
        //         context: context,
        //         image:
        //             "https://img.freepik.com/free-photo/music-podcast-background-with-headphones-blue-table-flat-lay-top-view-flat-lay-space-text_501050-215.jpg?w=360",
        //         title: "video title",
        //         number: "${index + 1}",
        //         savedNumber: "12K",
        //         onTap: () {
        //           Navigator.pushNamed(context, VideoDetailsPage.name);
        //         },
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget buildBody() {
    if (context.watch<SavedVM>().isLoading) {
      return loadingWidget();
    } else if (context.watch<SavedVM>().error != "") {
      return errorWidget(error: context.watch<SavedVM>().error);
    }
    if (context.watch<SavedVM>().isLoadingVideoDetails) {
      return loadingWidget();
    } else if (context.watch<SavedVM>().errorVideoDetails != "") {
      return errorWidget(error: context.watch<SavedVM>().errorVideoDetails);
    } else if (context.watch<SavedVM>().savedVideosDetails.isEmpty) {
      return noDataUI();
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await context.read<SavedVM>().fetchAllSavedVideos(isRefresh: true);
        },
        child: ListView.builder(
          padding: padding,
          itemCount: context.watch<SavedVM>().savedVideosDetails.length,
          itemBuilder: (context, index) {
            var e = context.watch<SavedVM>().savedVideosDetails[index].video;
            return customVideoTile(
              // isUp: true,
              // isCircle: true,
              // isDown: true,
              context: context,
              image: e?.avatarImage ?? "",
              title: e?.description ?? "",
              number: "${index + 1}",
              hotness: e?.hotness ?? 0,
              savedNumber: formatNumber(e?.favorites ?? 0),
              onTap: () {
                Navigator.pushNamed(context, VideoDetailsPage.name,
                    arguments: VideoDetailsPageArgModel(videoId: e?.videoId ?? ""));
              },
              isSaved: context.watch<SavedVM>().checkVideIsSaved(videoId: e?.videoId ?? ""),
              onTapSave: () {
                context.read<SavedVM>().saveVideo(videoId: e?.videoId ?? "", isFromSavePage: true);
              },
              onTapPlay: () {
                Navigator.pushNamed(
                  context,
                  FullScreenVideoPlayerPage.name,
                  arguments: FullScreenVideoArgModel(
                    url: e?.sourceVideoUrl ?? "",
                    title: e?.songTitle ?? "",
                    videoId: e?.videoId ?? "",
                  ),
                );
              },
            );
          },
        ),
      );
    }
  }

  noDataUI() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              robotoText(
                text: getLocalText.savedVideosMessage1,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              w(3),
              const Icon(Icons.bookmark, size: 30, color: primary),
            ],
          ),
          robotoText(
            text: getLocalText.savedVideosMessage2,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
