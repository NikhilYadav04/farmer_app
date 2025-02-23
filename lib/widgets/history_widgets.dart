import 'package:ai_plant_detecion/controllers/main/getX_history.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/home_widgets.dart';
import 'package:ai_plant_detecion/widgets/home_widgets_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Widget medicineList(HistoryController controller, List<dynamic> list) {
  return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: 1.79073 * SizeConfig.heightMultiplier),
          child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(0.5266 * SizeConfig.heightMultiplier),
                color: AppTheme.containerColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 3,
                    color: AppTheme.screenBackgroundColorGreen,
                  )
                ],
              ),
              child: ExpansionTile(
                //* function for changing arrow icon
                onExpansionChanged: (expanded) {
                  if (expanded) {
                    controller.expandedIndex.value = index + 1;
                  } else {
                    controller.expandedIndex.value = -1;
                  }
                },
                iconColor: null,
                trailing: SizedBox.shrink(),
                title: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text(
                          "${list[index]["title"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "CoreSansLight",
                              fontWeight: FontWeight.w500,
                              fontSize: 2.95 * SizeConfig.heightMultiplier),
                        ),
                      ),
                      index + 1 == controller.expandedIndex.value
                          ? Icon(
                              Icons.arrow_drop_up_sharp,
                              color: Colors.white,
                              size: 3.7921 * SizeConfig.heightMultiplier,
                            )
                          : Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.white,
                              size: 3.7921 * SizeConfig.heightMultiplier,
                            )
                    ],
                  ),
                ),
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.053 * SizeConfig.heightMultiplier,
                          horizontal: 3 * SizeConfig.widthMultiplier,
                        ),
                        child: Text(
                          maxLines: 12,
                          overflow: TextOverflow.ellipsis,
                          "⦁ ${list[index]["content"]}.",
                          style: TextStyle(
                              fontFamily: "CoreSansLight",
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 1.8 * SizeConfig.heightMultiplier),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        );
      });
}

Widget medicineDescription(List<dynamic> list) {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 1.053 * SizeConfig.heightMultiplier,
            horizontal: 1.11 * SizeConfig.widthMultiplier,
          ),
          child: Text(
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            "⦁ ${list[index]}",
            style: TextStyle(
                fontFamily: "CoreSansLight",
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 1.89607 * SizeConfig.heightMultiplier),
          ),
        );
      });
}

Widget titleText(HistoryController controller, String title) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${title}",
          style: TextStyle(
              color: screenBackgroundColorGreen,
              fontFamily: "CoreSansBold",
              fontSize: 4.2 * SizeConfig.heightMultiplier),
        ),
        SizedBox(
          width: 2.2321 * SizeConfig.widthMultiplier,
        ),
      ],
    ),
  );
}

void editDialog(HistoryController controller, void Function() onTap) {
  Get.bottomSheet(Container(
      height: 31.60123 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.633436 * SizeConfig.heightMultiplier),
              topRight:
                  Radius.circular(2.633436 * SizeConfig.heightMultiplier))),
      child: Column(
        children: [
          SizedBox(
            height: 1.053 * SizeConfig.heightMultiplier,
          ),
          Divider(
            height: 1.053 * SizeConfig.heightMultiplier,
            color: Colors.white,
            indent: 35.7142 * SizeConfig.widthMultiplier,
            endIndent: 35.7142 * SizeConfig.widthMultiplier,
            thickness: 5,
          ),
          SizedBox(
            height: 2.2 * SizeConfig.heightMultiplier,
          ),
          chooseWidget(Icons.edit, "Edit Plant Title Name"),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 3.34821 * SizeConfig.widthMultiplier),
            child: SizedBox(
              height: 7.8 * SizeConfig.heightMultiplier,
              child: Form(
                  key: controller.editKey,
                  child: TextFormField(
                    validator: (value) {
                      if (GetUtils.isLengthLessOrEqual(value, 5)) {
                        return "Name length must be more than 5 length.";
                      }
                      return null;
                    },
                    style: style.copyWith(
                        fontSize: 2.3174 * SizeConfig.heightMultiplier),
                    controller: controller.editController,
                    decoration: InputDecoration(
                        label: Text(
                          "Tomato",
                          style: style.copyWith(
                              fontSize: 2.3174 * SizeConfig.heightMultiplier),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.all(
                            2.3174 * SizeConfig.heightMultiplier),
                        fillColor: AppTheme.screenBackgroundColorIndigo,
                        filled: true,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                1.053 * SizeConfig.heightMultiplier),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                1.053 * SizeConfig.heightMultiplier),
                            borderSide: BorderSide(
                                color: AppTheme.screenBackgroundColorGreen)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                1.053 * SizeConfig.heightMultiplier),
                            borderSide:
                                BorderSide(color: AppTheme.containerColor))),
                  )),
            ),
          ),
          SizedBox(
            height: 3.16012 * SizeConfig.heightMultiplier,
          ),
          button(onTap, "Edit", 5.2668 * SizeConfig.heightMultiplier),
        ],
      )));
}

Widget searchFieldText(String text, HistoryController controller, IconData icon,
    TextInputType type) {
  return TextField(
    keyboardType: type,
    style: TextStyle(
        color: Colors.white,
        fontFamily: "CoreSansLight",
        fontSize: 2.31 * SizeConfig.heightMultiplier),
    controller: controller.searchController,
    onChanged: (value) {
      controller.filterItem(value);
    },
    decoration: InputDecoration(
        filled: true,
        fillColor: fieldColor,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
                BorderRadius.circular(0.80 * SizeConfig.heightMultiplier)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            EdgeInsets.symmetric(vertical: 2.10 * SizeConfig.heightMultiplier),
        label: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 157, 154, 154),
                  fontFamily: "CoreSansLight",
                  fontSize: 2.31 * SizeConfig.heightMultiplier),
            ),
          ],
        ),
        prefixIcon: Icon(
          icon,
          size: 2.52 * SizeConfig.heightMultiplier,
          color: const Color.fromARGB(255, 157, 154, 154),
        )),
  );
}

TextStyle style = TextStyle(
    color: Colors.white,
    fontFamily: "CoreSansLight",
    fontWeight: FontWeight.w800,
    fontSize: 2.5280 * SizeConfig.heightMultiplier);
