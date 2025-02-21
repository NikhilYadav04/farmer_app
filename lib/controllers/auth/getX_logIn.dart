import 'package:ai_plant_detecion/helper/helper_functions.dart';
import 'package:ai_plant_detecion/screens/auth/login_screen_mobile.dart';
import 'package:ai_plant_detecion/screens/main/appbar_screen_mobile.dart';
import 'package:ai_plant_detecion/styling/toastMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  //*define all the text controllers
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  //* bools
  RxBool isLoading = false.obs;

  //* login
  Future<void> loginAccount(BuildContext context) async {
    try {
      //* credentials validate
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        toastErrorSlide(context, "Empty Details Found!");
        return;
      }

      if (!GetUtils.isEmail(emailController.text.toString())) {
        toastErrorSlide(context, "Invalid Email!");
        return;
      }

      if (!GetUtils.isLengthLessThan(6, passwordController.text.length)) {
        toastErrorSlide(context, "Password must be at least 6 character long");
        return;
      }
      isLoading.value = true;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
      await HelperFunctions.setAuthStatus(true);
      Get.offAll(() => AppbarScreenMobile(),
          transition: Transition.rightToLeft);

      toastSuccessSlide(context, "Verified Successfully!");

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'wrong-password':
            toastErrorSlide(context, 'Incorrect password. Please try again.');
            break;
          case 'user-not-found':
            toastErrorSlide(context,
                'No user found with this email. Please register first.');
            break;
          default:
            toastErrorSlide(context, 'An unknown error occurred: ${e.message}');
        }
        return;
      } else {
        toastErrorSlide(context, e.toString());
        return;
      }
    }
  }

  //* logout
  Future<void> logout() async {
    try {
      await HelperFunctions.setAuthStatus(false);
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreenMobile(), transition: Transition.downToUp);
    } catch (e) {
      print(e.toString());
    }
  }

  RxBool obscureText = false.obs;

  @override
  void onClose() {
    super.onClose();
  }
}
