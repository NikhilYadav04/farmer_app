import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOTPCOntroller extends GetxController {
  //* define controllers
  late TextEditingController OTPController = TextEditingController();

  //*clear controllers
  void clear() {
    OTPController.clear();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class TimerController extends GetxController {
  RxInt remainingTime = 60.obs; // Start with 760 seconds

  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    remainingTime = 60.obs;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    remainingTime.value = 60;
    timer?.cancel();
    startTimer();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
