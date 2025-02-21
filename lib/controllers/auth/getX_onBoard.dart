import 'package:ai_plant_detecion/global/locale_var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewController extends GetxController {
  //* define the pagecontroller
  PageController pageController = PageController();

  //* define the page index
  RxInt currentPage = 0.obs;

  //* Navigate to the next page
  void nextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
  }

  //* increment or decrement the index of pagecontroller
  void indexChange(index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class DropDownController extends GetxController {
  //* for selecteing dropItem
  RxString? selectedValue;
  //* for collapse/open of dropDown
  RxBool isExpanded = false.obs;

  //* for selecting languae
  void setLanguage(lang) {
    locale_app = Locale(lang);
    print(locale_app);
    Get.updateLocale(locale_app);
    isExpanded = false.obs;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
