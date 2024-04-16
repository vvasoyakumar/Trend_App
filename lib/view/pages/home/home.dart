import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/helper/firebase/firebase_analytics_helper.dart';
import 'package:trend_radar/utils/text_helper.dart';
import 'package:trend_radar/view/pages/home/widgets.dart';
import 'package:trend_radar/view/widgets/common.dart';
import 'package:trend_radar/viewmodel/plan_vm.dart';

import '../../../constants/constants.dart';
import '../../../models/common_models.dart';
import '../../../utils/size_utils.dart';
import 'notification_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DetailDataModel> youSub = [
    DetailDataModel(
      name: "Personalized for You!",
      image:
          "https://img.freepik.com/free-photo/music-podcast-background-with-headphones-blue-table-flat-lay-top-view-flat-lay-space-text_501050-215.jpg?w=360",
    ),
    DetailDataModel(
      name: "Prediction to Rise: South Africa",
      image:
          "https://images.unsplash.com/photo-1589802829985-817e51171b92?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",
    ),
    DetailDataModel(
        name: "Prediction to Rise: South Africa",
        image:
            "https://images.unsplash.com/photo-1589802829985-817e51171b92?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80"),
    DetailDataModel(
        name: "Prediction to Rise: South Africa",
        image:
            "https://images.unsplash.com/photo-1589802829985-817e51171b92?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80"),
    DetailDataModel(
        name: "Prediction to Rise: South Africa",
        image:
            "https://images.unsplash.com/photo-1589802829985-817e51171b92?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80"),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsHelper.trackScreen(screenName: "Home");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: paddingA,
          child: Row(
            children: [
              robotoText(
                text: getLocalText.appName,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
              const Spacer(),
              blackBackgroundIconButton(
                icon: Icons.notifications_none,
                onTap: () {
                  Navigator.pushNamed(context, NotificationPage.name);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: buildBody(),
        ),
      ],
    );
  }

  Widget buildBody() {
    return ListView(
      children: [
        titleTile(
          context: context,
          title: getLocalText.yourSubscriptions,
          // seeAll: () {},
        ),
        horizontalScrollView(
          list: youSub
              .map(
                (e) => customContainer(
                  context: context,
                  image: e.image,
                  title: e.name,
                  isUnlocked: context.watch<PlanVM>().checkUnlockCategory(title: e.name),
                ),
              )
              .toList(),
        ),
        titleTile(
          context: context,
          title: getLocalText.categories,
          // seeAll: () {
          //   Navigator.pushNamed(context, CategoryViewAllPage.name);
          // },
        ),
        constHeight20(),
        categoryGridView(context: context),
        constHeight20(),
      ],
    );
  }
}
