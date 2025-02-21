import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/home_widgets_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class appBarController extends GetxController {

  //* profile photo add
  void addPhoto(){
    Get.bottomSheet(
      Container(
        height: 29.5*SizeConfig.heightMultiplier,
        decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(2.6334*SizeConfig.heightMultiplier),topRight: Radius.circular(2.6334*SizeConfig.heightMultiplier))
        ),
        child: Column(
          children: [
            SizedBox(height: 1.0533*SizeConfig.heightMultiplier,),
            Divider(height: 1.0533*SizeConfig.heightMultiplier,color: Colors.white,indent: 35.7142*SizeConfig.widthMultiplier,endIndent: 35.7142*SizeConfig.widthMultiplier,thickness: 5,),
            SizedBox(height: 2.1067*SizeConfig.heightMultiplier,),
            Image.asset("assets/icons/account.png",height: 8.42699*SizeConfig.heightMultiplier,width: 17.8571*SizeConfig.widthMultiplier,),
            SizedBox(height: 1.7*SizeConfig.heightMultiplier,),
            SizedBox(
              height: 4.740185*SizeConfig.heightMultiplier,
              child: chooseWidget(Icons.camera_alt, "Choose from camera")),
             SizedBox(height: 1.58006*SizeConfig.heightMultiplier,),
            SizedBox(
              height: 4.740185*SizeConfig.heightMultiplier,
              child: chooseWidget(Icons.photo, "Choose from gallery")),
            SizedBox(height: 0.2*SizeConfig.heightMultiplier,)
          ],
        ),
      )
    );
  }

  //*index for appbar icons
  RxInt currentPage = 0.obs;

  //*for changing index between pages
  void changeIndex(index) {
    currentPage.value = index;
    print(currentPage);
  }

  //*appBar text acc to currentPage
  String appBarText(BuildContext context) {
    return currentPage == 0
        ? AppLocalizations.of(context)!.bottomBarDiagnose
        : AppLocalizations.of(context)!.bottomBarHistory;
  }

  void onClose() {
    super.onClose();
  }
}
