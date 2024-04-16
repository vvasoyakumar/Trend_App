import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:trend_radar/constants/revenuecat_const.dart';

class RevenueCartHelper {
  static Future initConfig() async {
    if (Platform.isIOS) {
      final config0 = PurchasesConfiguration(appleApiKey);
      await Purchases.configure(config0);
    } else if (Platform.isAndroid) {
      final config = PurchasesConfiguration(googleApiKey);
      await Purchases.configure(config);
    }
  }
}

// // import 'dart:io';
// //
// // import 'package:flutter/services.dart';
// // import 'package:purchases_flutter/purchases_flutter.dart';
// // import 'package:trend_radar/constants/revenuecat_const.dart';
// // import 'package:trend_radar/utils/custom_print.dart';
// //
// // class RevenueCatsHelper {
// //   static Future<void> initPlatformState() async {
// //     await Purchases.setLogLevel(LogLevel.debug);
// //
// //     PurchasesConfiguration? configuration;
// //     if (Platform.isAndroid) {
// //       // configuration = PurchasesConfiguration(<revenuecat_project_google_api_key>);
// //       // if (buildingForAmazon) {
// //       //   // use your preferred way to determine if this build is for Amazon store
// //       //   // checkout our MagicWeather sample for a suggestion
// //       //   configuration = AmazonConfiguration(<revenuecat_project_amazon_api_key>);
// //       // }
// //     } else if (Platform.isIOS) {
// //       configuration = PurchasesConfiguration(appleApiKey);
// //     }
// //     if (configuration != null) {
// //       await Purchases.configure(configuration);
// //     }
// //   }
// //
// //   static makePerchse() async {
// //     try {
// //       CustomerInfo customerInfo = await Purchases.purchasePackage(const Package(entitlementsIs,
// //           PackageType.monthly, StoreProduct(entitlementsIs, "", "", 100, "100", "+91"), entitlementsIs));
// //       var isPro = customerInfo.entitlements.all[entitlementsIs]?.isActive;
// //       // if (isPro) {
// //       //   // Unlock that great "pro" content
// //       // }
// //     } on PlatformException catch (e) {
// //       // var errorCode = PurchasesErrorHelper.getErrorCode(e);
// //       // if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
// //       //   customPrint("errrr ${e} ");
// //       // }
// //
// //       customPrint("Error ==>>> ${e.message}");
// //       customPrint("Error ==>>> ${e.code}");
// //       customPrint("Error ==>>> ${e.details}");
// //       customPrint("Error ==>>> ${e.stacktrace}");
// //     }
// //   }
// // }
//
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:trend_radar/helper/revenuecats/store_config.dart';
//
// Future<void> configureSDK() async {
//   // Enable debug logs before calling `configure`.
//   await Purchases.setLogLevel(LogLevel.debug);
//
//   /*
//     - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids
//
//     - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
//     */
//   PurchasesConfiguration configuration;
//   if (StoreConfig.isForAmazonAppstore()) {
//     configuration = AmazonConfiguration(StoreConfig.instance.apiKey)
//       ..appUserID = null
//       ..observerMode = false;
//   } else {
//     configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
//       ..appUserID = null
//       ..observerMode = false;
//   }
//   await Purchases.configure(configuration);
// }
