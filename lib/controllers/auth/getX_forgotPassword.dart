import 'package:ai_plant_detecion/styling/toastMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class forgotEmailController extends GetxController {
  //* define controllers
  TextEditingController emailController = TextEditingController();

  //* bool
  RxBool isLoading = false.obs;

  //* functions

  void clear() {
    emailController.clear();
  }

  //* reset pin
  Future<void> resetPassword(BuildContext context) async {
    try {
      isLoading.value = true;

      //* credentials validate
      if (emailController.text.isEmpty) {
        toastErrorSlide(context, "Empty Details Found!");
        return;
      }

      if (!GetUtils.isEmail(emailController.text.toString())) {
        toastErrorSlide(context, "Invalid Email!");
        return;
      }

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.toString());
      clear();

      isLoading.value = false;
      toastSuccessSlideLong(context,
          "A password reset link has been sent to your email. Check it");
      Get.back();
    } catch (e) {
      isLoading.value = false;
      toastErrorSlide(context, "Error : ${e.toString()}");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
