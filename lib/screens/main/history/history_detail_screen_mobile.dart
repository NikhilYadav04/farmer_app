// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:ai_plant_detecion/controllers/main/getX_history.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/history_widgets.dart';
import 'package:ai_plant_detecion/widgets/home_widgets.dart';

// ignore: must_be_immutable
class HistoryDetailScreenMobile extends StatelessWidget {
  final HistoryController historyController;
  List<dynamic> list;
  int index;
  HistoryDetailScreenMobile({
    Key? key,
    required this.historyController,
    required this.list,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: screenBackgroundColorIndigo,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 1.26 * SizeConfig.heightMultiplier,
                horizontal: 2.67 * SizeConfig.widthMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 4.21 * SizeConfig.heightMultiplier,
                        ),
                      ),
                      Icon(
                        Icons.bookmark_add_outlined,
                        color: Colors.white,
                        size: 4.5 * SizeConfig.heightMultiplier,
                      ),
                    ]),

                //* title text
                titleText(historyController, () {
                  //historyController.deleteResponse(context, "dummy");
                  historyController.changeTitle(context, "dummy");
                }, list[index]["title"]),
                SizedBox(
                  height: 2.10674 * SizeConfig.heightMultiplier,
                ),

                //*plant image
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(1.05 * SizeConfig.heightMultiplier),
                  child: list[index]["url"] == ""
                      ? Image.asset("assets/icons/earth.png",
                          scale: 0.21067 * SizeConfig.heightMultiplier)
                      : CachedNetworkImage(
                          imageUrl: list[index]["url"],
                          scale: 0.21067 * SizeConfig.heightMultiplier,
                        ),
                ),
                SizedBox(
                  height: 3.16022332244812 * SizeConfig.heightMultiplier,
                ),

                //*plant and disease text
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.11 * SizeConfig.widthMultiplier),
                  child: diseaseTextWidget(context, list[index]["plant_name"]),
                ),
                SizedBox(
                  height: 2.63 * SizeConfig.heightMultiplier,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.11 * SizeConfig.widthMultiplier),
                    child: Divider(
                      color: Colors.white,
                      height: 5,
                    )),
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),

                //*medicinal uses
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.11 * SizeConfig.widthMultiplier),
                    child: remediesTextWIdget(
                        context, AppLocalizations.of(context)!.remedyText)),
                SizedBox(
                  height: 1.5 * SizeConfig.heightMultiplier,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2 * SizeConfig.widthMultiplier,
                    ),
                    child: medicineList(
                        historyController, list[index]["med_uses"])),

                //* conservation status
                SizedBox(
                  height: 2.5 * SizeConfig.heightMultiplier,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.11 * SizeConfig.widthMultiplier),
                    child: Divider(
                      color: Colors.white,
                      height: 5,
                    )),
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.11 * SizeConfig.widthMultiplier),
                    child: remediesTextWIdget(context,
                        AppLocalizations.of(context)!.conservationText)),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier,
                ),
                medicineDescription(list[index]["cons_status"]),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.11 * SizeConfig.widthMultiplier),
                    child: Divider(
                      color: Colors.white,
                      height: 5,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
