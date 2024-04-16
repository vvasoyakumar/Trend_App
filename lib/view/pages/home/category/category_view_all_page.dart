import 'package:flutter/material.dart';
import 'package:trend_radar/utils/size_utils.dart';
import 'package:trend_radar/view/pages/home/widgets.dart';

import '../../../../utils/text_helper.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/common.dart';

class CategoryViewAllPage extends StatefulWidget {
  static const name = "CategoryViewAllPage";
  const CategoryViewAllPage({super.key});

  @override
  State<CategoryViewAllPage> createState() => _CategoryViewAllPageState();
}

class _CategoryViewAllPageState extends State<CategoryViewAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customBackground(
        child: Column(
          children: [
            customAppbar(
              title: getLocalText.categories,
              onTapBack: () => Navigator.pop(context),
              // onTapFavourite: () {},
            ),
            Expanded(
              child: ListView(
                children: [
                  categoryGridView(context: context),
                  constHeight20(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
