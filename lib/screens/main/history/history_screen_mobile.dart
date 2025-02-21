import 'dart:math';

import 'package:ai_plant_detecion/controllers/main/getX_history.dart';
import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/history_widgets.dart';
import 'package:ai_plant_detecion/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';

class HistoryScreenMobile extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());
  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 0.52 * SizeConfig.heightMultiplier,
        ),

        //*search field
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 2.67 * SizeConfig.widthMultiplier),
          child: Column(
            children: [
              searchFieldText(AppLocalizations.of(context)!.searchPlantText,
                  controller, Icons.search_rounded, TextInputType.text),
              SizedBox(
                height: 1.47 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),

        //* for showing history list of plants
        StreamBuilder(
          stream: controller.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitFadingCube(
                  color: AppTheme.screenBackgroundColorGreen,
                  size: 50,
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              //List<dynamic> list = controller.getList(snapshot);
              final doc = snapshot.data!.docs.first;
              controller.list.value = doc["responses"];
              controller.filtered_list.value = controller.list;
              List<dynamic> list = controller.filtered_list;

              if (list.isNotEmpty) {
                logger.d("Full list");
                return Obx(
                  () => Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return historyList(
                          controller,
                          list,
                          index,
                          list[index]["url"],
                          list[index]["title"],
                          list[index]["plant_name"],
                          context,
                        );
                      },
                    ),
                  ),
                );
              } else {
                logger.d("EMpty list");
                return Expanded(
                  child: Center(
                    child: Text(
                      "No Data Available",
                      style: TextStyle(
                        fontFamily: "CoreSansBold",
                        fontSize: 24,
                        color: AppTheme.screenBackgroundColorGreen,
                      ),
                    ),
                  ),
                );
              }
            } else {
              logger.d("EMpty list");
              return Expanded(
                child: Center(
                  child: Text(
                    "No Data Available",
                    style: TextStyle(
                      fontFamily: "CoreSansBold",
                      fontSize: 24,
                      color: AppTheme.screenBackgroundColorGreen,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
