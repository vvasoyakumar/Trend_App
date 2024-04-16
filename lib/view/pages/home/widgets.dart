import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_radar/viewmodel/plan_vm.dart';

import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/images.dart';
import '../../../models/common_models.dart';
import '../../../utils/size_utils.dart';
import '../../../utils/text_helper.dart';
import '../../widgets/common.dart';
import 'category/category_details_page.dart';

List<DetailDataModel> getCategoryList() {
  return [
    DetailDataModel(
        name: "Dance",
        image:
            "https://media.istockphoto.com/id/1415194216/photo/portrait-of-cheerful-active-little-girls-happy-kids-dancing-isolated-on-orange-background-in.jpg?s=1024x1024&w=is&k=20&c=Xit3NHmdSa7A88o0asOsYSNUxBLcayDpMeegvRfap4I="),
    DetailDataModel(
        name: "Lip-Sync",
        image:
            "https://media.istockphoto.com/id/162048276/photo/super-mom-singing-karaoke-superhero-with-broom-stick.webp?b=1&s=612x612&w=0&k=20&c=m2ir92VySYrWw4jM3RYA9Q6mN3iIsAf0IJUQDMnXhPQ="),
    DetailDataModel(
        name: "Comedy",
        image: "https://cdn.pixabay.com/photo/2014/10/31/17/41/dancing-dave-minion-510835_640.jpg"),
    DetailDataModel(
        name: "Cooking",
        image:
            "https://media.istockphoto.com/id/1394055240/photo/happy-black-female-chef-preparing-food-in-frying-pan-at-restaurant-kitchen.webp?b=1&s=612x612&w=0&k=20&c=orfnpNSuRtQ88QcXjT2_YORJ0DsrLL7uBoE9Pt3njKM="),
    DetailDataModel(
        name: "Fashion",
        image:
            "https://media.istockphoto.com/id/1459178010/photo/fashion-industry-black-woman-and-designer-portrait-of-clothing-tailor-with-business-vision.webp?b=1&s=612x612&w=0&k=20&c=DVNSYLvpozptBo_PVMmBB_nUgJnQSoBNUIT12FjbRdI="),
    DetailDataModel(
        name: "Makeup",
        image:
            "https://st3.depositphotos.com/6903990/12629/i/450/depositphotos_126292436-stock-photo-woman-with-clean-fresh-skin.jpg"),
    DetailDataModel(
        name: "Life Hacks",
        image:
            "https://media.istockphoto.com/id/895791500/photo/life-hacks-text-on-a-display-on-blue-and-pink-bright-background.webp?b=1&s=612x612&w=0&k=20&c=5MFeAWWg0Kfb7aqkB99oUDpvHI8Ocfp0jZJO_lVgS6w="),
    DetailDataModel(
        name: "Pet",
        image: "https://t4.ftcdn.net/jpg/01/99/00/79/360_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg"),
    DetailDataModel(
        name: "Education",
        image:
            "https://media.istockphoto.com/id/1465817305/photo/happy-young-people-jumping-together-at-school.webp?b=1&s=612x612&w=0&k=20&c=ULECIjJfadJh7wMDgkWNYBpdQXNXU-YPUOI0UPcHE6o="),
    DetailDataModel(
        name: "Fitness", image: "https://cdn.pixabay.com/photo/2017/08/07/14/02/man-2604149_640.jpg"),
    DetailDataModel(
        name: "Travel",
        image:
            "https://images.pexels.com/photos/1223649/pexels-photo-1223649.jpeg?cs=srgb&dl=pexels-oliver-sj%C3%B6str%C3%B6m-1223649.jpg&fm=jpg"),
    DetailDataModel(
        name: "DIY", image: "https://cdn.pixabay.com/photo/2018/01/20/08/01/craftsmen-3094035_1280.jpg"),
    DetailDataModel(
        name: "Family",
        image:
            "https://media.istockphoto.com/id/1403196779/photo/a-happy-mixed-race-family-of-three-relaxing-in-the-lounge-and-being-playful-together-loving.webp?b=1&s=612x612&w=0&k=20&c=AxcXFs3INV9dw-e_Ma7ypYBRWyLsQP9NYNt3h4kl4Mc="),
    DetailDataModel(
        name: "Challenges",
        image:
            "https://media.istockphoto.com/id/1499787791/photo/stairs-target-arrow-on-yellow-background.webp?b=1&s=612x612&w=0&k=20&c=VF3ADFQwDSjiesXQSt6xnLylyxIxDvuow0gQttkCRjs="),
    DetailDataModel(
        name: "Gaming",
        image:
            "https://media.istockphoto.com/id/1397730825/photo/girl-playing-a-video-game-console-game-is-football-joystick-in-hands-selective-focus.webp?b=1&s=612x612&w=0&k=20&c=hCdttfFT40RwtZgdMQRmgueZtXi0E2mqH5VPiGvNK7E="),
    DetailDataModel(
        name: "Inspiration",
        image: "https://cdn.pixabay.com/photo/2016/12/01/14/02/light-bulbs-1875384_640.jpg"),
    DetailDataModel(
        name: "Pranks",
        image:
            "https://media.istockphoto.com/id/1444446563/photo/child-mischief-boy-with-a-distracted-face-because-he-drew-the-entire-wall.webp?b=1&s=612x612&w=0&k=20&c=pI-V8kf7TyUlo1P_wUXXQMth5SdFUnZaxXWSfit4oMc="),
    DetailDataModel(
        name: "Home Improvement",
        image:
            "https://media.istockphoto.com/id/1395525239/photo/middle-aged-couple-at-home-planning-living-room-design.webp?b=1&s=612x612&w=0&k=20&c=EQXJd4galGQU_Dt99UIfvog7EwWQjumo6Zc2K_4Qz0Y="),
    DetailDataModel(
        name: "Experiments", image: "https://cdn.pixabay.com/photo/2017/02/19/23/09/success-2081168_640.jpg"),
    DetailDataModel(
        name: "Music promo",
        image:
            "https://media.istockphoto.com/id/1056306726/photo/3d-rendering-of-collection-of-several-pieces-of-vintage-equipment-a-tv-a-radio-set-a.webp?b=1&s=612x612&w=0&k=20&c=AWTpPSHc_-Xr2YvYMe0CYn9zXRLIwrhmZWy_TwjtgDs="),
  ];
}

Widget categoryGridView({required BuildContext context, int? length}) {
  return Padding(
    padding: paddingH,
    child: DynamicHeightGridView(
      itemCount: length ?? getCategoryList().length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: isPortrait(context) ? 2 : 4,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      builder: (context, index) {
        var e = getCategoryList()[index];
        return customContainer2(
          isUnlocked: index == 0 || context.watch<PlanVM>().checkUnlockCategory(title: e.name),
          context: context,
          title: e.name,
          image: e.image,
          onTap: () {
            if (index == 0 || context.read<PlanVM>().checkUnlockCategory(title: e.name)) {
              DetailDataModel arg = e;
              arg.number = index;
              Navigator.pushNamed(context, CategoryDetailsPage.name, arguments: arg);
            } else {
              context.read<PlanVM>().showPlanSheet(context: context, unlockProductName: e.name);
            }
          },
        );
      },
    ),
  );
}

Widget categoryTitleTile(
    {required BuildContext context, required String image, required String title, required String desc}) {
  return Padding(
    padding: paddingA,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imageContainer(
          image: image,
          width: sizer(context, 0.08),
          height: sizer(context, 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        w(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h(5),
              robotoText(
                text: title,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                maxLines: 1,
              ),
              robotoText(
                text: desc,
                fontSize: 16,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget customContainer2(
    {required BuildContext context,
    required String image,
    required String title,
    VoidCallback? onTap,
    bool? isUnlocked}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            imageContainer(image: image, height: sizer(context, 0.2)),
            if (isUnlocked != true)
              Container(
                padding: const EdgeInsets.all(3.5),
                margin: const EdgeInsets.only(right: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: greyBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.lock_rounded, color: white, size: 20),
              ),
          ],
        ),
        h(5),
        robotoText(
          text: title,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ],
    ),
  );
}

Widget customContainer(
    {required BuildContext context,
    required String image,
    required String title,
    VoidCallback? onTap,
    bool? isUnlocked}) {
  return Container(
    margin: const EdgeInsets.only(right: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            imageContainer(image: image, width: sizer(context, 0.17), height: sizer(context, 0.17)),
            if (isUnlocked != true)
              Container(
                padding: const EdgeInsets.all(3.5),
                margin: const EdgeInsets.only(right: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: greyBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.lock_rounded, color: white, size: 20),
              ),
          ],
        ),
        h(8),
        SizedBox(
          width: sizer(context, 0.17),
          child: robotoText(
            text: title,
            fontWeight: FontWeight.w700,
            fontSize: 15,
            maxLines: 2,
          ),
        ),
      ],
    ),
  );
}

Widget videoInfo({required String value, required String key}) {
  return Column(
    children: [
      robotoText(
        text: value,
        fontWeight: FontWeight.w900,
        fontSize: 20,
      ),
      robotoText(
        text: key,
        fontSize: 14,
      ),
    ],
  );
}

Widget videoDetailTile({
  required String title,
  required String subTitle,
  required String date,
  required String savedNumber,
  VoidCallback? onTapPlay,
  VoidCallback? onTapTikTok,
  VoidCallback? onTapSave,
  bool? isSaved,
}) {
  return Padding(
    padding: paddingA,
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              robotoText(
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                maxLines: 1,
              ),
              robotoText(
                text: subTitle,
                fontSize: 14,
                color: white.withOpacity(0.9),
              ),
              robotoText(
                text: "Date : $date",
                fontSize: 12,
                color: white.withOpacity(0.9),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onTapSave,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(AppImages.label, height: 30, color: isSaved == true ? primary : null),
              robotoText(text: savedNumber, fontSize: 9.5, fontWeight: FontWeight.w900),
            ],
          ),
        ),
        constWidth20(),
        GestureDetector(onTap: onTapTikTok, child: Image.asset(AppImages.tiktok, height: 28, color: primary)),
        constWidth20(),
        GestureDetector(onTap: onTapPlay, child: Image.asset(AppImages.play, height: 28)),
      ],
    ),
  );
}
