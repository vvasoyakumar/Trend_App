import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/constants/colors.dart';
import 'package:trend_radar/constants/images.dart';
import 'package:trend_radar/viewmodel/dahboard_vm.dart';

import '../../models/common_models.dart';
import '../../utils/size_utils.dart';
import '../../utils/text_helper.dart';

List<BottomNavigationBarItemModel> bottomItems({required BuildContext context}) {
  return [
    BottomNavigationBarItemModel(
      image: AppImages.home,
      name: getLocalText.home,
      icon: Icons.home,
    ),
    BottomNavigationBarItemModel(
      image: AppImages.home,
      name: getLocalText.search,
      icon: Icons.search,
    ),
    BottomNavigationBarItemModel(
      image: AppImages.home,
      name: getLocalText.learn,
      icon: Icons.school,
    ),
    BottomNavigationBarItemModel(
      image: AppImages.home,
      name: getLocalText.saved,
      icon: Icons.bookmark,
    ),
    BottomNavigationBarItemModel(
      image: AppImages.home,
      name: getLocalText.settings,
      icon: Icons.settings,
    ),
  ];
}

bottomNavigationBar({required BuildContext context}) {
  return BottomNavigationBar(
    backgroundColor: bottomBackground,
    currentIndex: context.watch<DashBoardVM>().bottomNavigationIndex,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: white,
    selectedItemColor: primary,
    unselectedFontSize: 15,
    selectedFontSize: 15,
    selectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w600),
    unselectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w600),
    onTap: (value) {
      context.read<DashBoardVM>().setBottomNavigationIndex(value);
    },
    items: bottomItems(context: context).map((e) {
      bool isSelected =
          bottomItems(context: context).indexOf(e) == context.watch<DashBoardVM>().bottomNavigationIndex;
      return BottomNavigationBarItem(
        label: e.name,
        tooltip: e.name,
        icon: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 3),
          child: Icon(
            e.icon,
            size: sizer(context, 0.029),
          ),
          // Image.asset(
          //   e.image!,
          //   height: sizer(context, 0.027),
          //   color: isSelected ? primary : white,
          // ),
        ),
      );
    }).toList(),
  );
}
