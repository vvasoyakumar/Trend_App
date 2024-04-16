import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trend_radar/constants/constants.dart';
import 'package:trend_radar/utils/date_format.dart';
import 'package:trend_radar/view/pages/home/widgets.dart';
import 'package:trend_radar/viewmodel/home_vm.dart';

import '../../../constants/colors.dart';
import '../../../helper/firebase/firebase_analytics_helper.dart';
import '../../../models/common_models.dart';
import '../../../utils/size_utils.dart';
import '../../../utils/text_helper.dart';
import '../../../utils/url_launcher.dart';
import '../../../viewmodel/saved_vm.dart';
import '../../widgets/appbar.dart';
import '../../widgets/common.dart';
import '../../widgets/loading_error_widgets.dart';
import '../video_player/full_screen_player_page.dart';

class VideoDetailsPage extends StatefulWidget {
  static const name = "VideoDetailsPage";
  const VideoDetailsPage({super.key});

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  late VideoDetailsPageArgModel arg;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeVM>().getVideoDetails(id: arg.videoId ?? "");
      // context.read<HomeVM>().getVideoDetails(id: "1234567890");
      FirebaseAnalyticsHelper.logEventVideoDetails(videoId: arg.videoId);
    });
    FirebaseAnalyticsHelper.trackScreen(screenName: "VideoDetailsPage");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arg = ModalRoute.of(context)?.settings.arguments as VideoDetailsPageArgModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customBackground(
        child: Column(
          children: [
            customAppbar(
              title: getLocalText.videoDetails,
              onTapBack: () => Navigator.pop(context),
            ),
            Expanded(child: buildBody()),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    if (context.watch<HomeVM>().isLoadingVideoDetails) {
      return loadingWidget();
    } else if (context.watch<HomeVM>().errorVideoDetails != "") {
      return errorWidget(
        error: context.watch<HomeVM>().errorVideoDetails,
        onTryAgain: () => context.read<HomeVM>().getVideoDetails(id: arg.videoId ?? ""),
      );
    } else {
      var video = context.watch<HomeVM>().videoDetails?.video;
      var stats = context.watch<HomeVM>().videoDetails?.stats ?? [];

      final List<ChartData> chartData = <ChartData>[
        // ChartData("Aug 17", 5.2),
        // ChartData("Sep 3", 7.5),
        // ChartData("Sep 10", 9.5),
        // ChartData("Sep 17", 10),
        // ChartData("Sep 24", 15.8),
        // ChartData("Oct 1", 4.9),
      ];

      for (var e in stats) {
        if (e.timestamp != null && e.viewCount != null) {
          chartData.add(ChartData(
            getDateFormatMMMd(date: e.timestamp),
            e.viewCount!.toDouble(),
          ));
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          videoDetailTile(
            title: video?.songTitle ?? "",
            subTitle: video?.description ?? "",
            date: getDateFormat(date: video?.datePosted),
            savedNumber: formatNumber(video?.favorites ?? 0),
            onTapPlay: () {
              Navigator.pushNamed(
                context,
                FullScreenVideoPlayerPage.name,
                arguments: FullScreenVideoArgModel(
                  url: video?.sourceVideoUrl ?? "",
                  title: video?.songTitle ?? "",
                  videoId: video?.videoId ?? "",
                ),
              );
            },
            isSaved: context.watch<SavedVM>().checkVideIsSaved(videoId: video?.videoId ?? ""),
            onTapSave: () {
              context.read<SavedVM>().saveVideo(videoId: video?.videoId ?? "");
            },
            onTapTikTok: () {
              urlLauncher(url: video?.publicVideoUrl);
            },
          ),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
              // labelFormat: '{value} M',
              axisLine: const AxisLine(width: 0),
            ),
            series: <ChartSeries>[
              SplineAreaSeries<ChartData, dynamic>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: primary.withOpacity(0.5),
              ),
            ],
          ),
          constHeight10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              videoInfo(value: formatNumber(video?.views ?? 0), key: getLocalText.plays),
              videoInfo(value: formatNumber(video?.likes ?? 0), key: getLocalText.likes),
              videoInfo(value: formatNumber(video?.views ?? 0), key: getLocalText.views),
              // videoInfo(value: "-", key: getLocalText.shares),
              videoInfo(value: formatNumber(video?.follower ?? 0), key: getLocalText.follower),
              // videoInfo(value: "-", key: getLocalText.comments),
            ],
          ),
          constHeight20(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     videoInfo(value: "-", key: getLocalText.trendTokSaves),
          //     videoInfo(value: "-", key: getLocalText.engagementRate),
          //   ],
          // ),
          Padding(
            padding: paddingH,
            child: Wrap(
              spacing: 3,
              runSpacing: 5,
              children: [
                ...(video?.hashtags ?? []).map(
                  (e) => Container(
                    decoration: BoxDecoration(
                      color: black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: robotoText(text: "# $e"),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
