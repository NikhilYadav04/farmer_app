import 'package:ai_plant_detecion/controllers/main/getX_appBar.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar appBar(
    void Function() onTap, appBarController controller, BuildContext context) {
  return AppBar(
    toolbarHeight: 9.48 * SizeConfig.heightMultiplier,
    backgroundColor: screenBackgroundColorIndigo,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => InkWell(
              onTap: onTap,
              child: controller.profile_url.value == ""
                  ? Image.asset(
                      "assets/icons/account.png",
                      height: 4.1 * SizeConfig.heightMultiplier,
                      width: 9.82 * SizeConfig.widthMultiplier,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: controller.profile_url.value,
                          height: 6.1 * SizeConfig.heightMultiplier,
                          width: 13.82 * SizeConfig.widthMultiplier,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
        ),
        Obx(
          () => Text(
            controller.appBarText(context),
            style: TextStyle(
                color: Colors.white,
                fontFamily: "CoreSansMed",
                fontSize: 3.6 * SizeConfig.heightMultiplier),
          ),
        ),
        Image.asset(
          "assets/icons/plant.png",
          height: 4.1 * SizeConfig.heightMultiplier,
          width: 9.82 * SizeConfig.widthMultiplier,
        ),
      ],
    ),
  );
}

BottomNavigationBar bottomBar(
    int currentPage, appBarController controller, BuildContext context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppTheme.screenBackgroundColorIndigo,
    selectedIconTheme: icontheme().copyWith(color: screenBackgroundColorGreen),
    unselectedIconTheme: icontheme().copyWith(color: Colors.white),
    selectedItemColor: screenBackgroundColorGreen,
    unselectedItemColor: Colors.white,
    unselectedLabelStyle: labelStyle(),
    selectedLabelStyle: labelStyle(),
    currentIndex: currentPage,
    onTap: (value) {
      controller.changeIndex(value);
    },
    items: [
      BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.bottomBarDiagnose,
          icon: Icon(
            Icons.image_search_sharp,
          ),
          backgroundColor: screenBackgroundColorIndigo),
      BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.bottomBarHistory,
          icon: Icon(
            Icons.history,
          ),
          backgroundColor: screenBackgroundColorIndigo),
    ],
  );
}

TextStyle labelStyle() {
  return TextStyle(
    fontFamily: "CoreSansBold",
    fontSize: 1.89 * SizeConfig.heightMultiplier,
  );
}

IconThemeData icontheme() {
  return IconThemeData(
    size: 3.8 * SizeConfig.heightMultiplier,
  );
}
