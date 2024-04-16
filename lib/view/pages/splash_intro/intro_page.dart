import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/utils/text_helper.dart';

import '../../../constants/colors.dart';
import '../../../helper/firebase/firebase_analytics_helper.dart';
import '../../../utils/size_utils.dart';
import '../../../viewmodel/intro_splash_vm.dart';
import '../../widgets/common.dart';
import 'widgets.dart';

class IntroScreen extends StatefulWidget {
  static const name = "IntroScreen";

  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showApprovalDialog(context: context);
    });
    FirebaseAnalyticsHelper.trackScreen(screenName: "IntroScreen");
  }

  @override
  Widget build(BuildContext context) {
    List<SliderItems> sliderItems = [
      SliderItems(
        title: "Growth your audience and tell your brand's story",
        image:
            "https://images.pexels.com/photos/1762578/pexels-photo-1762578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      ),
      SliderItems(
        title: "Build an engaged Instagram following",
        image:
            "https://images.pexels.com/photos/1762578/pexels-photo-1762578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        subDesc:
            "Auto-publish posts to your Instagram Business profile, or set reminders to finish the Post in the Instagram app.",
      ),
      SliderItems(
        title: "Advanced features to grow your brand",
        image:
            "https://images.pexels.com/photos/1762578/pexels-photo-1762578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        subDesc:
            "When your brand is ready for the next level, subscribe to a paid plan at buffer.com to unlock advanced features like Instagram Stories scheduling and team collaboration",
      ),
    ];
    return Scaffold(
      body: customBackground(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: context.read<IntroVM>().onTapSkip,
                    child: robotoText(
                      text: getLocalText.skip,
                      fontSize: 18,
                      color: primary,
                    ),
                  ),
                  w(16),
                ],
              ),
              h(sizer(context, 0.010)),
              CarouselSlider(
                carouselController: carouselController,
                items: sliderItems.map((e) {
                  return sliderContainer(context: context, e: e);
                }).toList(),
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeFactor: 0.3,
                  height: sizer(context, 0.71),
                  onPageChanged: (index, reason) {
                    context.read<IntroVM>().setIntroSliderIndex(index);
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...sliderItems.map(
                    (e) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        height: sizer(context, 0.012),
                        width: sizer(context, 0.013),
                        decoration: BoxDecoration(
                          color: sliderItems.indexOf(e) == context.watch<IntroVM>().introSliderIndex
                              ? primary
                              : grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  )
                ],
              ),
              const Spacer(),
              customButton(
                name: context.watch<IntroVM>().introSliderIndex == 2
                    ? getLocalText.letsGo
                    : getLocalText.nextTip,
                onTap: context.read<IntroVM>().onTapNext(carouselController: carouselController),
                width: sizer(context, 0.26),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderItems {
  String title;
  String image;
  String? desc;
  String? subDesc;

  SliderItems({
    required this.title,
    required this.image,
    this.desc,
    this.subDesc,
  });
}
