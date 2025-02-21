import 'dart:io';

import 'package:ai_plant_detecion/controllers/main/getX_Diagnose.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DiagnoseScreenMobile extends StatefulWidget {
  @override
  State<DiagnoseScreenMobile> createState() => _DiagnoseScreenMobileState();
}

class _DiagnoseScreenMobileState extends State<DiagnoseScreenMobile> {
  final initialize controller = Get.put(initialize());

  File? _imagefile;

  void _addImage() async {
    final XFile? _pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (_pickedFile != null) {
        _imagefile = File(_pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 1.58 * SizeConfig.heightMultiplier,
            horizontal: 3.34 * SizeConfig.widthMultiplier),
        child: Column(
          children: [
            //*intro widget
            checkWidget(context, controller),
            SizedBox(
              height: 2.63 * SizeConfig.heightMultiplier,
            ),

            //*widget for uploading crop and get response
            Obx(() {
              return TweenAnimationBuilder(
                tween: Tween<Offset>(
                  begin: controller.diagnoseShow.value
                      ? Offset(0, 1)
                      : Offset(0,
                          0), //* Start from the bottom if true, else start from current position
                  end: controller.diagnoseShow.value
                      ? Offset(0, 0)
                      : Offset(0,
                          1), //* End at current position if true, else end at the bottom
                ),
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                builder: (context, Offset offset, child) {
                  return Transform.translate(
                    offset: offset * SizeConfig.height,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1 * SizeConfig.heightMultiplier,
                            horizontal: 2.5 * SizeConfig.widthMultiplier),
                        height: 44 * SizeConfig.heightMultiplier,
                        width: 93.75 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.circular(
                              1.05 * SizeConfig.heightMultiplier),
                        ),
                        child: GestureDetector(
                            child: getResponseWidget(
                                context, controller, _imagefile, () {
                          _addImage();
                        }, () {
                           //controller.uploadImage(_imagefile, context);
                          //controller.getConservationStatus(context);
                          controller.saveResponse(context, "SPinach", "Carrot", [
                            {
                                 "title":"Stomach pain",
                                 "content":"Giloy can be used to treat fever and cough"
                            },
                            {
                                 "title":"Intestine pain",
                                 "content":"Giloy can be used to treat digestion issue"
                            }
                          ], ["Status","I am used to digest"], "");
                        }))),
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}

TextStyle style =
    TextStyle(color: screenBackgroundColorGreen, fontFamily: "CoreSansMed");
