import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/constants/constants.dart';
import 'package:trend_radar/models/category_details_model.dart';
import 'package:trend_radar/models/common_models.dart';
import 'package:trend_radar/view/pages/home/widgets.dart';
import 'package:trend_radar/view/widgets/common.dart';
import 'package:trend_radar/viewmodel/saved_vm.dart';

import '../../../../helper/firebase/firebase_analytics_helper.dart';
import '../../../../helper/video_api.dart';
import '../../../../utils/text_helper.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/loading_error_widgets.dart';
import '../../video_player/full_screen_player_page.dart';
import '../video_details_page.dart';

class CategoryDetailsPage extends StatefulWidget {
  static const name = "CategoryDetailsPage";
  const CategoryDetailsPage({super.key});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  late DetailDataModel arg;
  final PagingController<int, CategoryDetailsModel> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    FirebaseAnalyticsHelper.trackScreen(screenName: "CategoryDetailsPage");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseAnalyticsHelper.logEventCategoryOpen(categoryName: arg.name);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arg = ModalRoute.of(context)?.settings.arguments as DetailDataModel;
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customBackground(
        child: Column(
          children: [
            customAppbar(
              title: getLocalText.category,
              onTapBack: () => Navigator.pop(context),
              // onTapFavourite: () {},
            ),
            categoryTitleTile(
              context: context,
              image: arg.image,
              title: arg.name,
              desc: "Top Trend in ${arg.name}",
            ),
            Expanded(
              child: PagedListView<int, CategoryDetailsModel>(
                pagingController: _pagingController,
                padding: padding,
                builderDelegate: PagedChildBuilderDelegate<CategoryDetailsModel>(
                  firstPageProgressIndicatorBuilder: (context) => loadingWidget(),
                  newPageProgressIndicatorBuilder: (context) => loadingWidget(),
                  itemBuilder: (context, item, index) {
                    var e = item;
                    return customVideoTile(
                      // isUp: true,
                      // isCircle: true,
                      // isDown: true,
                      context: context,
                      image: e.avatarImage ?? "",
                      title: e.description ?? "",
                      number: "${index + 1}",
                      hotness: e.hotness ?? 0,
                      savedNumber: formatNumber(e.favorites ?? 0),
                      onTap: () {
                        Navigator.pushNamed(context, VideoDetailsPage.name,
                            arguments: VideoDetailsPageArgModel(videoId: e.videoId ?? ""));
                      },
                      isSaved: context.watch<SavedVM>().checkVideIsSaved(videoId: e.videoId ?? ""),
                      onTapSave: () {
                        context.read<SavedVM>().saveVideo(videoId: e.videoId ?? "");
                      },
                      onTapPlay: () {
                        Navigator.pushNamed(
                          context,
                          FullScreenVideoPlayerPage.name,
                          arguments: FullScreenVideoArgModel(
                            url: e.sourceVideoUrl ?? "",
                            title: e.songTitle ?? "",
                            videoId: e.videoId ?? "",
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<CategoryDetailsModel> newItems = await VideoApi.getCategoryDetailsVideos(
        pageNumber: pageKey,
        categories: arg.number ?? 0,
      ).then((value) {
        return value ?? [];
      });

      if (newItems.length < 10) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
