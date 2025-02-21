import 'package:ai_plant_detecion/controllers/auth/getX_onBoard.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/screens/auth/signup_screen_mobile.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/onboard_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardScreen1Mobile extends StatelessWidget {
  OnboardScreen1Mobile({super.key});

  //* initialize GetX controllers
  final PageViewController controller = Get.put(PageViewController());
  final DropDownController _dropDownController = Get.put(DropDownController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: screenBackgroundColorGreen,
        body: Stack(
          fit: StackFit.expand,
          children: [
            //* dropdown for selecting language
            Positioned(
              top: 1.58 * SizeConfig.heightMultiplier,
              left: 82.14 * SizeConfig.widthMultiplier,
              child: Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(
                          0.84 * SizeConfig.heightMultiplier),
                      isExpanded: _dropDownController.isExpanded.value,
                      hint: Container(
                        height: 9.42 * SizeConfig.heightMultiplier,
                        width: 15.62 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(
                              0.84 * SizeConfig.heightMultiplier),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/earth.png",
                            height: 3.68 * SizeConfig.heightMultiplier,
                            width: 7.81 * SizeConfig.widthMultiplier,
                          ),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: dropDownItem(
                              "English", "assets/icons/english.png"),
                        ),
                        DropdownMenuItem(
                          value: 'hi',
                          child:
                              dropDownItem("Hindi", "assets/icons/hindi.png"),
                        ),
                        DropdownMenuItem(
                          value: 'mr',
                          child: dropDownItem(
                              "Marathi", "assets/icons/marathi.png"),
                        ),
                      ],
                      onChanged: (value) {
                        _dropDownController.setLanguage(value);
                      },
                    ),
                  )),
            ),

            //* bottom card widget
            FractionallySizedBox(
              alignment: Alignment.bottomLeft,
              heightFactor: 0.52,
              child: Container(
                height: 48.05 * SizeConfig.heightMultiplier,
                width: 100 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                  color: screenBackgroundColorIndigo,
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(6.322 * SizeConfig.heightMultiplier),
                    topRight:
                        Radius.circular(6.322 * SizeConfig.heightMultiplier),
                  ),
                ),
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.indexChange(index);
                  },
                  children: [
                    bottomCard(
                      AppLocalizations.of(context)!.onboardTitle1,
                      AppLocalizations.of(context)!.onboardDesc1,
                    ),
                    bottomCard(
                      AppLocalizations.of(context)!.onboardTitle2,
                      AppLocalizations.of(context)!.onboardDesc2,
                    ),
                  ],
                ),
              ),
            ),

            //* for color indicator of pages
            FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.336,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 41.10 * SizeConfig.widthMultiplier),
                child: SmoothPageIndicator(
                  controller: controller.pageController, // PageController
                  count: 2, // Number of pages
                  effect: ExpandingDotsEffect(
                    dotHeight: 1.95 * SizeConfig.heightMultiplier,
                    dotWidth: 4.10 * SizeConfig.widthMultiplier,
                    dotColor: Colors.grey,
                    activeDotColor: screenBackgroundColorGreen,
                  ),
                ),
              ),
            ),

            //* bottom buttons for pageview
            FractionallySizedBox(
              heightFactor: 0.130,
              alignment: Alignment.bottomCenter,
              child:  bottomButtons(context,() {
                Get.off(() => SignupScreenMobile(),
                    transition: Transition.downToUp);
              }, () {
                controller.currentPage.value == 1
                    ? Get.off(() => SignupScreenMobile(),
                        transition: Transition.downToUp)
                    : controller.nextPage();
              }),
            )
          ],
        ),
      ),
    );
  }
}
