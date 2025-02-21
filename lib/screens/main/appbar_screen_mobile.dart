import 'package:ai_plant_detecion/controllers/main/getX_appBar.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/screens/main/diagnose/diagnose_screen_mobile.dart';
import 'package:ai_plant_detecion/screens/main/history/history_screen_mobile.dart';
import 'package:ai_plant_detecion/widgets/appbar_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarScreenMobile extends StatelessWidget {
  final appBarController controller = Get.put(appBarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: screenBackgroundColorIndigo,
        //* AppBar
        appBar: appBar(() {
          controller.addPhoto();
        }, controller, context),
        body: Obx(() => IndexedStack(
              index: controller.currentPage.value,
              children: [DiagnoseScreenMobile(), HistoryScreenMobile()],
            )),
        //* bottom navigation bar
        bottomNavigationBar: Obx(() => Theme(
              data: ThemeData(
                  splashFactory: NoSplash.splashFactory,
                  bottomAppBarTheme: BottomAppBarTheme(elevation: 0)),
              child:
                  bottomBar(controller.currentPage.value, controller, context),
            )),
      ),
    );
  }
}
