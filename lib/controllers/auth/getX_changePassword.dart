import 'package:ai_plant_detecion/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class changePasswordController extends GetxController {
  //* define controllers
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController passwordController1 = TextEditingController();

  //*clear controllers
  void clear() {
    passwordController.clear();
    passwordController1.clear();
  }

  RxBool obscureText1 = false.obs;
  RxBool obscureText2 = false.obs;

  //*check both passwords same or not
  void check() {
    if (passwordController.text.toString() ==
        passwordController1.text.toString()) {
      clear();
    } else {
      Get.snackbar(
        'Enter Again!', // Title
        "Passwords do not match , Enter Again", // Message
        snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
        backgroundColor: screenBackgroundColorGreen, // Background color
        colorText: Colors.white, // Text color
        duration: Duration(seconds: 3), // Duration to show Snackbar
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
