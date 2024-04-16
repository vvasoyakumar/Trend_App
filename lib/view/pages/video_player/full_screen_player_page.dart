import 'dart:developer';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:trend_radar/view/widgets/appbar.dart';
import 'package:trend_radar/view/widgets/common.dart';
import 'package:video_player/video_player.dart';

import '../../../helper/firebase/firebase_analytics_helper.dart';
import '../../../models/common_models.dart';

class FullScreenVideoPlayerPage extends StatefulWidget {
  static const name = "FullScreenVideoPlayerPage";
  const FullScreenVideoPlayerPage({super.key});

  @override
  State<FullScreenVideoPlayerPage> createState() => _FullScreenVideoPlayerPageState();
}

class _FullScreenVideoPlayerPageState extends State<FullScreenVideoPlayerPage> {
  late FlickManager flickManager;
  late FullScreenVideoArgModel arg;
  @override
  void initState() {
    super.initState();
    // https://api16-normal-c-useast1a.tiktokv.com/aweme/v1/play/?video_id=v12044gd0000ck9h13jc77u0oqq80h2g&line=0&is_play_url=1&source=PackSourceEnum_PUBLISH&file_id=0248debd8ff24f2595faec7e4e00f22d&item_id=7283184299313024299&signv3=dmlkZW9faWQ7ZmlsZV9pZDtpdGVtX2lkLjdiZDE2Yzc4MWI3M2ZlOWE3ZmE0OWNlZmQ0NDhiNDlj
    FirebaseAnalyticsHelper.trackScreen(screenName: "FullScreenVideoPlayerPage");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseAnalyticsHelper.logEventVideoOpen(videoId: arg.videoId);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arg = ModalRoute.of(context)?.settings.arguments as FullScreenVideoArgModel;
    log("FullScreenVideoPlayerPage Arg ===>>> ${arg.url} || ${arg.title}");
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(arg.url),
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: customBackground(
          child: Column(
            children: [
              customAppbar(
                title: arg.title,
                onTapBack: () => Navigator.pop(context),
              ),
              Expanded(
                child: FlickVideoPlayer(
                  flickManager: flickManager,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
