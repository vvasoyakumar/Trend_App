import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/constants/colors.dart';
import 'package:trend_radar/utils/size_utils.dart';
import 'package:trend_radar/utils/text_helper.dart';
import 'package:trend_radar/view/widgets/common.dart';

import '../../../constants/constants.dart';
import '../../../helper/firebase/firebase_analytics_helper.dart';
import '../../../helper/video_api.dart';
import '../../../models/category_details_model.dart';
import '../../../models/common_models.dart';
import '../../../viewmodel/saved_vm.dart';
import '../../../viewmodel/search_vm.dart';
import '../../widgets/appbar.dart';
import '../../widgets/loading_error_widgets.dart';
import '../home/video_details_page.dart';
import '../video_player/full_screen_player_page.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final PagingController<int, CategoryDetailsModel> _pagingController = PagingController(firstPageKey: 1);
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.text = context.read<SearchVM>().searchText;
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    FirebaseAnalyticsHelper.trackScreen(screenName: "Search");
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customAppbar(
          title: getLocalText.searchVideos,
          subTitle: getLocalText.searchVideosAppBarDesc,
        ),
        Padding(
          padding: paddingH,
          child: searchTextFiled(
            controller: searchController,
            context: context,
            onChange: (val) {
              context.read<SearchVM>().changeSearchText(val);
              _pagingController.refresh();
            },
          ),
        ),
        constHeight10(),
        // ElevatedButton(
        //     onPressed: () async {
        //       var r = await ApiHelper.videoApi.videosGet(categories: [], pageSize: 10, pageNumber: 1);
        //       print(r.body);
        //     },
        if (context.watch<SearchVM>().searchText == "")
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search, size: 180, color: textFiledText),
                  Padding(
                    padding: paddingH,
                    child: robotoText(
                      text: getLocalText.searchVideosMessage,
                      fontSize: 16,
                      color: textFiledText,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (context.watch<SearchVM>().searchText != "")
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
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<CategoryDetailsModel> newItems = await VideoApi.getCategoryDetailsVideos(
        pageNumber: pageKey,
        search: context.read<SearchVM>().searchText,
        categories: 0,
      ).then((value) {
        return value ?? [];
      });
      if (newItems.isNotEmpty) {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      } else {
        throw "Items Not Found";
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
