import 'dart:io';

import 'package:ai_plant_detecion/controllers/main/getX_appBar.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/screens/main/diagnose/diagnose_screen_mobile.dart';
import 'package:ai_plant_detecion/screens/main/history/history_screen_mobile.dart';
import 'package:ai_plant_detecion/widgets/appbar_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AppbarScreenMobile extends StatefulWidget {
  @override
  State<AppbarScreenMobile> createState() => _AppbarScreenMobileState();
}

class _AppbarScreenMobileState extends State<AppbarScreenMobile> {
  final appBarController controller = Get.put(appBarController());

  File? _image1;

  File? _image2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: screenBackgroundColorIndigo,
        //* AppBar
        appBar: appBar(() {
          controller.addPhoto(_image1, _image2, context);
        }, controller, context),
        body: Obx(() => IndexedStack(
              index: controller.currentPage.value,
              children: [DiagnoseScreenMobile(AppBarController: controller,), HistoryScreenMobile()],
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
