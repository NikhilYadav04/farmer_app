import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget bottomCard(String title, String desc) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.only(
            top: 4.74 * SizeConfig.heightMultiplier,
            left: 6.69 * SizeConfig.widthMultiplier,
            right: 6.69 * SizeConfig.widthMultiplier),
        child: FittedBox(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "CoreSansBold",
                fontWeight: FontWeight.bold,
                fontSize: 3.5 * SizeConfig.heightMultiplier),
          ),
        ),
      ),
      SizedBox(
        height: 2.63 * SizeConfig.heightMultiplier,
      ),
      Container(
          padding: EdgeInsets.symmetric(
            horizontal: 4.46 * SizeConfig.widthMultiplier,
          ),
          child: Text(
            overflow: TextOverflow.ellipsis,
            desc,
            maxLines: 5,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "CoreSansLight",
                fontSize: 2.2 * SizeConfig.heightMultiplier),
          )),
    ],
  );
}

Widget bottomButtons(BuildContext context,void Function() but1, void Function() but2) {
  return Container(
    width: 47.25 * SizeConfig.heightMultiplier,
    child: Column(
      children: [
        Divider(
          color: const Color.fromARGB(255, 122, 120, 120),
          height: 10,
        ),
        SizedBox(
          height: 2.63 * SizeConfig.heightMultiplier,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: but1,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 86, 85, 85),
                    borderRadius: BorderRadius.circular(
                        3.16 * SizeConfig.heightMultiplier)),
                height: 6.32 * SizeConfig.heightMultiplier,
                width: 43.64 * SizeConfig.widthMultiplier,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.buttonSkip,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoreSansLight",
                      fontWeight: FontWeight.bold,
                    ).copyWith(fontSize: 2.4 * SizeConfig.heightMultiplier),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: but2,
              child: Container(
                decoration: BoxDecoration(
                    color: screenBackgroundColorGreen,
                    borderRadius: BorderRadius.circular(
                        3.16 * SizeConfig.heightMultiplier)),
                height: 6.32 * SizeConfig.heightMultiplier,
                width: 43.64 * SizeConfig.widthMultiplier,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.buttonContinue,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoreSansLight",
                      fontWeight: FontWeight.bold,
                    ).copyWith(fontSize: 2.4 * SizeConfig.heightMultiplier),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget dropDownItem(String title, String image) {
  return Column(
    children: [
      Row(
        children: [
          Image.asset(
            image,
            height: 3.16 * SizeConfig.heightMultiplier,
            width: 6.69 * SizeConfig.widthMultiplier,
          ),
          SizedBox(
            width: 2.23 * SizeConfig.widthMultiplier,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 2.40 * SizeConfig.heightMultiplier,
                color: Colors.black,
                fontFamily: "CoreSansBold"),
          )
        ],
      ),
      SizedBox(
        height: 0.52 * SizeConfig.heightMultiplier,
      ),
      Divider(
        color: Colors.black,
        height: 5,
      )
    ],
  );
}
