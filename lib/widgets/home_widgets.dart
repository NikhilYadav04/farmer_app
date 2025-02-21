import 'dart:io';

import 'package:ai_plant_detecion/controllers/main/getX_Diagnose.dart';
import 'package:ai_plant_detecion/controllers/main/getX_history.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/screens/main/history/history_detail_screen_mobile.dart';
import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/history_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_url_gen/transformation/delivery/delivery.dart';
import 'package:cloudinary_url_gen/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget historyList(HistoryController historyController, List<dynamic> list,
    int index, String url, String title, String name,BuildContext context) {
  return GestureDetector(
    onTap: () {
      Get.to(
          () => HistoryDetailScreenMobile(
                historyController: historyController,
                list: list,
                index: index,status: "saved",
              ),
          transition: Transition.rightToLeft);
    },
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 3.34 * SizeConfig.widthMultiplier,
          vertical: 1.05 * SizeConfig.heightMultiplier),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(1.05 * SizeConfig.heightMultiplier),
                  child: url == ""
                      ? Image.asset("assets/icons/earth.png")
                      : CachedNetworkImage(imageUrl: url))),
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 2.23 * SizeConfig.widthMultiplier),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " ${title}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 3.01 * SizeConfig.heightMultiplier,
                              fontFamily: "CoreSansBold"),
                        ),
                         InkWell(
                            onTap: () {
                              editDialog(historyController, () {
                                //historyController.deleteResponse(context, "dummy");
                                historyController.changeTitle(
                                    context, list[index]["url"]);
                              });
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 2.94944 * SizeConfig.heightMultiplier,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 5.02 * SizeConfig.heightMultiplier,
                    ),
                      Text(
                          " ${name} ",
                          style: TextStyle(
                              color: screenBackgroundColorGreen,
                              fontSize: 3 * SizeConfig.heightMultiplier,
                              fontFamily: "CoreSansBold"),
                        ),
                  ],
                ),
              ))
        ],
      ),
    ),
  );
}

Widget diseaseTextWidget(BuildContext context, String plant_name) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${AppLocalizations.of(context)!.plantText}",
            style: TextStyle(fontSize: 4 * SizeConfig.heightMultiplier)
                .copyWith(color: Colors.white, fontFamily: "CoreSansBold"),
          ),
          SizedBox(
            width: 2.232 * SizeConfig.widthMultiplier,
          ),
          Text(
            ":",
            style: TextStyle(fontSize: 4 * SizeConfig.heightMultiplier)
                .copyWith(color: Colors.white, fontFamily: "CoreSansBold"),
          ),
          SizedBox(
            width: 3.34821 * SizeConfig.widthMultiplier,
          ),
          Text(
            plant_name,
            style: TextStyle(fontSize: 4 * SizeConfig.heightMultiplier)
                .copyWith(
                    color: screenBackgroundColorGreen,
                    fontFamily: "CoreSansBold"),
          ),
        ],
      ),
    ],
  );
}

Widget remediesTextWIdget(BuildContext context, String text) {
  return Row(
    children: [
      Icon(
        Icons.medical_services,
        color: Colors.white,
        size: 3.37 * SizeConfig.heightMultiplier,
      ),
      SizedBox(
        width: 2.67 * SizeConfig.widthMultiplier,
      ),
      Padding(
        padding: EdgeInsets.only(top: 0.52 * SizeConfig.heightMultiplier),
        child: Text(
          text,
          style: TextStyle(
              color: screenBackgroundColorGreen,
              fontFamily: "CoreSansMed",
              fontSize: 3 * SizeConfig.heightMultiplier),
        ),
      )
    ],
  );
}

Widget checkWidget(BuildContext context, DiagnoseController controller) {
  return Container(
    height: 26.33 * SizeConfig.heightMultiplier,
    decoration: BoxDecoration(
        color: fieldColor,
        borderRadius:
            BorderRadius.circular(1.05 * SizeConfig.heightMultiplier)),
    child: Row(
      children: [
        Flexible(flex: 1, child: Image.asset("assets/plants/plant.png")),
        Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.63 * SizeConfig.heightMultiplier,
                ),
                Text(
                  AppLocalizations.of(context)!.checkText,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoreSansBold",
                      fontSize: 3.05 * SizeConfig.heightMultiplier),
                ),
                SizedBox(
                  height: 1.4 * SizeConfig.heightMultiplier,
                ),
                Text(
                  maxLines: 3,
                  AppLocalizations.of(context)!.checkText1,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoreSansLight",
                      fontSize: 1.89 * SizeConfig.heightMultiplier),
                ),
                SizedBox(
                  height: 2.2 * SizeConfig.heightMultiplier,
                ),
                button(
                    controller.change,
                    AppLocalizations.of(context)!.bottomBarDiagnose,
                    5.26 * SizeConfig.heightMultiplier)
              ],
            )),
      ],
    ),
  );
}

Widget getResponseWidget(BuildContext context, DiagnoseController controller,
    File? _imagefile, void Function() onTap1, void Function() onTap2) {
  return Column(
    children: [
      Flexible(
          flex: 3,
          child: _imagefile == null
              ? noImageWidget()
              : ClipRRect(
                  borderRadius:
                      BorderRadius.circular(0.52 * SizeConfig.heightMultiplier),
                  child: Image.file(_imagefile),
                )),
      Flexible(
          flex: 1,
          child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(0.52 * SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.6 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      button(onTap1, AppLocalizations.of(context)!.uploadText,
                          5.5 * SizeConfig.heightMultiplier),
                      button(onTap2, AppLocalizations.of(context)!.submitText,
                          5.5 * SizeConfig.heightMultiplier)
                    ],
                  )
                ],
              )))
    ],
  );
}

Widget button(void Function() onTap, String text, double height) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: 35.71 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
          color: screenBackgroundColorGreen,
          borderRadius:
              BorderRadius.circular(2.5 * SizeConfig.heightMultiplier)),
      child: Center(
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "CoreSansMed",
                fontSize: 2.4 * SizeConfig.heightMultiplier)),
      ),
    ),
  );
}

Widget noImageWidget() {
  return Padding(
    padding: EdgeInsets.only(top: 2),
    child: Container(
      height: 31.6012 * SizeConfig.heightMultiplier,
      width: 80.35714 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
          color: AppTheme.screenBackgroundColorIndigo,
          borderRadius:
              BorderRadius.circular(1.053 * SizeConfig.heightMultiplier),
          boxShadow: [
            BoxShadow(
                color: AppTheme.screenBackgroundColorGreen,
                blurRadius: 5,
                spreadRadius: 2)
          ],
          border: Border.all(color: AppTheme.screenBackgroundColorGreen)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/plants/upload.png",
            height: 8.42699 * SizeConfig.heightMultiplier,
            width: 20.0892 * SizeConfig.widthMultiplier,
          ),
          SizedBox(
            height: 2.2 * SizeConfig.heightMultiplier,
          ),
          Center(
            child: Text(
              "Upload image Of Plant",
              style: TextStyle(
                  fontFamily: "CoreSansMed",
                  color: AppTheme.screenBackgroundColorGreen,
                  fontSize: 3 * SizeConfig.heightMultiplier),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget displayImage(String image) {
  return CldImageWidget(
    publicId: image.split("/")[7].split(".")[0],
    transformation: Transformation()
      ..delivery(Delivery.format(Format.auto))
      ..delivery(Delivery.quality(Quality.auto()))
      ..resize(Resize.auto()),
    height: 31.6012 * SizeConfig.heightMultiplier,
    width: 80.35714 * SizeConfig.widthMultiplier,
  );
}
