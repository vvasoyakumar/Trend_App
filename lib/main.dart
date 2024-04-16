import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/helper/revenuecats/revenuecats_helper.dart';
import 'package:trend_radar/utils/shared_pref_helper.dart';
import 'package:trend_radar/view/pages/dashboard.dart';
import 'package:trend_radar/view/pages/home/category/category_view_all_page.dart';
import 'package:trend_radar/view/pages/splash_intro/intro_page.dart';
import 'package:trend_radar/view/pages/video_player/full_screen_player_page.dart';
import 'package:trend_radar/viewmodel/home_vm.dart';
import 'package:trend_radar/viewmodel/intro_splash_vm.dart';
import 'package:trend_radar/viewmodel/learn_vm.dart';
import 'package:trend_radar/viewmodel/plan_vm.dart';
import 'package:trend_radar/viewmodel/saved_vm.dart';

import 'constants/constants.dart';
import 'utils/theme.dart';
import 'view/pages/home/category/category_details_page.dart';
import 'view/pages/home/notification_page.dart';
import 'view/pages/home/video_details_page.dart';
import 'view/pages/learn/learn_details_page.dart';
import 'view/pages/webview/webview_page.dart';
import 'viewmodel/dahboard_vm.dart';
import 'viewmodel/network_check_vm.dart';
import 'viewmodel/search_vm.dart';
import 'viewmodel/settings_vm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RevenueCartHelper.initConfig();
  await SharedPrefHelper.setInstance();
  await Firebase.initializeApp();
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  bool? isVisitedIntro = await SharedPrefHelper.getBool(key: SharedPrefHelper.isVisitedIntro);
  runApp(MyApp(isVisitedIntro: isVisitedIntro));
}

class MyApp extends StatefulWidget {
  bool? isVisitedIntro;
  MyApp({super.key, required this.isVisitedIntro});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SharedPrefHelper.setInstance();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IntroVM>(create: (context) => IntroVM()),
        ChangeNotifierProvider<DashBoardVM>(create: (context) => DashBoardVM()),
        ChangeNotifierProvider<NetworkCheckVM>(create: (context) => NetworkCheckVM()),
        ChangeNotifierProvider<HomeVM>(create: (context) => HomeVM()),
        ChangeNotifierProvider<SearchVM>(create: (context) => SearchVM()),
        ChangeNotifierProvider<LearnVM>(create: (context) => LearnVM()),
        ChangeNotifierProvider<SavedVM>(create: (context) => SavedVM()),
        ChangeNotifierProvider<SettingsVM>(create: (context) => SettingsVM()),
        ChangeNotifierProvider<PlanVM>(create: (context) => PlanVM()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        initialRoute: widget.isVisitedIntro == true ? DashBoard.name : IntroScreen.name,
        // initialRoute: IntroScreen.name,
        // locale: const Locale('de'),
        locale: const Locale('en'),
        navigatorKey: navigatorKey,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.dark,
        routes: {
          IntroScreen.name: (context) => const IntroScreen(),
          DashBoard.name: (context) => const DashBoard(),
          VideoDetailsPage.name: (context) => const VideoDetailsPage(),
          CategoryViewAllPage.name: (context) => const CategoryViewAllPage(),
          CategoryDetailsPage.name: (context) => const CategoryDetailsPage(),
          FullScreenVideoPlayerPage.name: (context) => const FullScreenVideoPlayerPage(),
          WebViewPage.name: (context) => const WebViewPage(),
          LearnDetailsPage.name: (context) => const LearnDetailsPage(),
          NotificationPage.name: (context) => const NotificationPage(),
        },
      ),
    );
  }
}
