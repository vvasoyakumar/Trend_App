import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:trend_radar/utils/shared_pref_helper.dart';
import 'package:trend_radar/utils/snack_bar.dart';

import '../constants/colors.dart';
import '../constants/revenuecat_const.dart';
import '../utils/custom_print.dart';
import '../utils/size_utils.dart';
import '../utils/text_helper.dart';

class PlanVM extends ChangeNotifier {
  bool isLoadingCustomerInfo = false;
  String unlockedProduct = "";
  // String identifier = "";
  CustomerInfo? customerInfo;

  // bool get isActive => getIsActive();

  // getIsActive() {
  //   if ((customerInfo?.activeSubscriptions ?? []).isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }

  bool checkUnlockCategory({required String title}) {
    // customPrint("title = == > $title unlockedProduct ${unlockedProduct}");
    // customPrint("customerInfo ${customerInfo?.activeSubscriptions}");
    // customPrint("identifier ${identifier}");
    if ((customerInfo?.activeSubscriptions ?? []).isNotEmpty) {
      String? currentSub = customerInfo?.activeSubscriptions[0];
      if (currentSub == premiumAllAccessMonthly || currentSub == premiumAllAccessYearly) {
        return true;
      } else {
        if (currentSub == customProductMonthlyAccess || currentSub == customProductYearlyAccess) {
          if (unlockedProduct == title) {
            return true;
          }
        }
      }
    }

    // if (customerInfo?.entitlements.all[identifier]?.isActive == true) {
    //   String? currentSub = customerInfo?.entitlements.all[identifier]?.identifier;
    //   if (currentSub == premiumAllAccessMonthly || currentSub == premiumAllAccessYearly) {
    //     return true;
    //   } else {
    //     if (currentSub == customProductMonthlyAccess || currentSub == customProductYearlyAccess) {
    //       if (unlockedProduct == title) {
    //         return true;
    //       }
    //     }
    //   }
    // }

    return false;
  }

  setLoadingCustomerInfo(bool value) {
    isLoadingCustomerInfo = value;
    notifyListeners();
  }

  setUnlockedProduct(String value) {
    unlockedProduct = value;
    notifyListeners();
  }

  // setIdentifier(String value) {
  //   identifier = value;
  //   notifyListeners();
  // }

  Future<void> setCurrentPlanListener() async {
    try {
      setUnlockedProduct(await SharedPrefHelper.getString(key: SharedPrefHelper.unlockedProduct) ?? "");
      // setIdentifier(await SharedPrefHelper.getString(key: SharedPrefHelper.identifier) ?? "");
      setLoadingCustomerInfo(true);
      customerInfo = await Purchases.getCustomerInfo();
      setLoadingCustomerInfo(false);
      customPrint("getCustomerInfo ==>>> ${customerInfo?.toJson()}");
      setUnlockedProduct(await SharedPrefHelper.getString(key: SharedPrefHelper.unlockedProduct) ?? "");
      // setIdentifier(await SharedPrefHelper.getString(key: SharedPrefHelper.identifier) ?? "");

      Purchases.addCustomerInfoUpdateListener((cInFo) async {
        customPrint("addCustomerInfoUpdateListener ==>>> ${cInFo.toJson()}");
        customerInfo = cInFo;
      });
    } catch (e) {
      setLoadingCustomerInfo(false);
    }
  }

  bool isLoadingBuy = false;
  setLoadingBuy(bool value) {
    isLoadingBuy = value;
    notifyListeners();
  }

  showPlanSheet({required BuildContext context, required String unlockProductName}) async {
    try {
      setLoadingBuy(true);

      await Purchases.getCustomerInfo().then((info) {
        customPrint("info.activeSubscriptions  ${info.activeSubscriptions}");
        showToast(msg: "planKeyList ==>> ${planKeyList}");
        Purchases.getProducts(planKeyList).then(
          (value) {
            customPrint(" getProducts ==<<>>> ${value.map((e) => e.toJson())}");

            if (info.activeSubscriptions.isNotEmpty) {
              int index = value.indexWhere((element) => element.identifier == info.activeSubscriptions[0]);

              setLoadingBuy(false);

              if (index >= 0) {
                customPrint("value[index].title  ${value[index].title}");
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(child: robotoText(text: "Subscription")),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          robotoText(
                              text:
                                  "You Already have active subscription ${value[index].title}. You can buy new subscription after ${info.entitlements.active[info.activeSubscriptions[0]]?.expirationDate ?? ""}"),
                          h(10),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Close"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                showToast(msg: "Your active Subscription is Removed From Revenue cat");
              }
              return;
            }

            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      h(16),
                      robotoText(
                        text: "✨ Upgrade Your Plan",
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                      h(16),
                      ...value.map((e) {
                        return GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            setLoadingBuy(true);
                            await Purchases.purchaseStoreProduct(e).then((value) {
                              customPrint("purchaseProduct ${value.toJson()}");
                              customPrint(
                                  "purchaseProduct ${value.entitlements.all[e.identifier]?.identifier}");
                              // if (value.entitlements.all[e.identifier]?.isActive == true) {
                              //   customerInfo = value;
                              //   // Unlock that great "pro" content
                              //   if (value.entitlements.all[e.identifier]?.identifier ==
                              //           customProductMonthlyAccess ||
                              //       value.entitlements.all[e.identifier]?.identifier ==
                              //           customProductYearlyAccess) {
                              //     SharedPrefHelper.saveString(
                              //         key: SharedPrefHelper.unlockedProduct, value: unlockProductName);
                              //     SharedPrefHelper.saveString(
                              //         key: SharedPrefHelper.identifier,
                              //         value: value.entitlements.all[e.identifier]?.identifier ?? "");
                              //     setUnlockedProduct(unlockProductName);
                              //     // setIdentifier(value.entitlements.all[e.identifier]?.identifier ?? "");
                              //   } else {
                              //     SharedPrefHelper.saveString(key: SharedPrefHelper.unlockedProduct, value: "");
                              //     setUnlockedProduct("");
                              //   }
                              // }
                              if ((value.activeSubscriptions ?? []).isNotEmpty) {
                                if (value.activeSubscriptions[0] == customProductMonthlyAccess ||
                                    value.activeSubscriptions[0] == customProductYearlyAccess) {
                                  SharedPrefHelper.saveString(
                                      key: SharedPrefHelper.unlockedProduct, value: unlockProductName);
                                  setUnlockedProduct(unlockProductName);
                                } else {
                                  SharedPrefHelper.saveString(
                                      key: SharedPrefHelper.unlockedProduct, value: "");
                                  setUnlockedProduct("");
                                }
                              }
                              setLoadingBuy(false);
                              notifyListeners();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      robotoText(
                                        text: e.title,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        maxLines: 2,
                                      ),
                                      robotoText(
                                        text: e.description,
                                        fontSize: 12,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: robotoText(
                                      text: e.priceString,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      h(16),
                    ],
                  ),
                );
              },
            ).then((value) {
              setLoadingBuy(false);
            });
          },
        ).onError((error, stackTrace) {
          showToast(msg: error.toString());
          setLoadingBuy(false);
        });
      });
    } catch (e) {
      setLoadingBuy(false);
    }
  }
}
