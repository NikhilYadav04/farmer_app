import 'package:ai_plant_detecion/helper/helper_functions.dart';
import 'package:ai_plant_detecion/screens/auth/login_screen_mobile.dart';
import 'package:ai_plant_detecion/styling/toastMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  //*define all the text controllers
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();

  //*clear controllers
  // void clear() {
  //   emailController.clear();
  //   passwordController.clear();
  //   phoneController.clear();
  // }

  RxBool obscureText = false.obs;
  RxBool isLoading = false.obs;

  //* functions
  Future<void> createAccount(BuildContext context) async {
    try {
      //* credentials validate
      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          phoneController.text.isEmpty) {
        toastErrorSlide(context, "Empty Details Found!");
        return;
      }

      if (!GetUtils.isEmail(emailController.text.toString())) {
        toastErrorSlide(context, "Invalid Email!");
        return;
      }

      if (!GetUtils.isLengthLessThan(6, passwordController.text.length)) {
        print("pass word ${passwordController.text.length}");
        toastErrorSlide(context, "Password must be at least 6 character long");
        return;
      }

      if (!GetUtils.isLengthLessThan(10, phoneController.text.length)) {
        toastErrorSlide(
            context, "Phone Number must be at least 10 digits long");
        return;
      }
      isLoading.value = true;

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
      final userID = FirebaseAuth.instance.currentUser!.uid;
      await HelperFunctions.setPhoneNumber(
          phoneController.text.toString(), userID);

      toastSuccessSlide(context, "Account Created Successfully");
      await Get.to(() => LoginScreenMobile(),
          transition: Transition.rightToLeft);
      Future.delayed(Duration(milliseconds: 500));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            toastErrorSlide(context, "Email is already registered.");
            break;
          case 'weak-password':
            toastErrorSlide(context, "Email is already registered.");
            break;
          default:
            toastErrorSlide(context, e.message ?? "An error occurred.");
        }
        return;
      } else {
        toastErrorSlide(context, e.toString());

        return;
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
