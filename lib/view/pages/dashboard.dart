import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/view/pages/search/search.dart';
import 'package:trend_radar/view/widgets/common.dart';
import 'package:trend_radar/view/widgets/loading_error_widgets.dart';

import '../../viewmodel/dahboard_vm.dart';
import '../../viewmodel/network_check_vm.dart';
import '../../viewmodel/plan_vm.dart';
import '../../viewmodel/saved_vm.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'home/home.dart';
import 'learn/learn.dart';
import 'saved/saved.dart';
import 'settings/settings.dart';

class DashBoard extends StatefulWidget {
  static const name = "DashBoard";
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    // NotificationHelper.initNotification();
    // FcmApi.setFcmToken();
    // RevenueCatsHelper.initPlatformState();
    // initPlatformState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlanVM>().setCurrentPlanListener();
      context.read<NetworkCheckVM>().initNetworkStateAndStartListen();
      context.read<SavedVM>().fetchAllSavedVideos();
    });
  }

  // Future<void> initPlatformState() async {
  //   String appUserID = await Purchases.appUserID;
  //
  //   customPrint("appUserID ====>>> ${appUserID}");
  //   Purchases.addCustomerInfoUpdateListener((customerInfo) async {
  //     appUserID = await Purchases.appUserID;
  //     customPrint("appUserID Update====>>> ${appUserID}");
  //
  //     CustomerInfo customerInfo = await Purchases.getCustomerInfo();
  //     customPrint("customerInfo ====>>> ${customerInfo.toJson()}");
  //     EntitlementInfo? entitlement = customerInfo.entitlements.all[entitlementID];
  //     customPrint("entitlement ====>>> ${entitlement?.toJson()}");
  //     bool entitlementIsActive = entitlement?.isActive ?? false;
  //     customPrint("entitlementIsActive ====>>> ${entitlementIsActive}");
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      // Purchases.getCustomerInfo().then((value) {
      //   customPrint("getCustomerInfo ${value.originalAppUserId}");
      //   customPrint("getCustomerInfo ${value.activeSubscriptions}");
      //   customPrint("getCustomerInfo ${value.entitlements}");
      // });
      // await Purchases.purchaseProduct("trial_two_week_subscription").then((value) {
      //   customPrint("purchaseProduct ${value.toJson()}");
      // });
      // FcmApi.setFcmToken();
      // RevenueCatsHelper.initPlatformState();
      // RevenueCatsHelper.makePerchse();
      //   },
      // ),
      body: customBackground(
        child: Stack(
          children: [
            [
              const Home(),
              const Search(),
              const Learn(),
              const Saved(),
              const Settings(),
            ][context.watch<DashBoardVM>().bottomNavigationIndex],
            if (context.watch<PlanVM>().isLoadingCustomerInfo || context.watch<PlanVM>().isLoadingBuy)
              loadingWidget(isStack: true),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context: context),
    );
  }
}
