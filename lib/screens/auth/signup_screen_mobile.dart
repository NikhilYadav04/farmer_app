import 'package:ai_plant_detecion/styling/images.dart';
import 'package:ai_plant_detecion/controllers/auth/getX_signUp.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/screens/auth/login_screen_mobile.dart';
import 'package:ai_plant_detecion/screens/onboard/onboard_screen_1_mobile.dart';
import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreenMobile extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  //* function for navigation to login page
  void logNav(BuildContext context) {
    Get.to(() => LoginScreenMobile(), transition: Transition.rightToLeft);
  }

  //* function for signup
  void signUpSubmit(BuildContext context) async {
    await controller.createAccount(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: screenBackgroundColorIndigo,
        leading: IconButton(
            onPressed: () {
              Get.off(() => OnboardScreen1Mobile(),
                  transition: Transition.upToDown);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 3.79 * SizeConfig.heightMultiplier,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: screenBackgroundColorIndigo,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 3.34 * SizeConfig.widthMultiplier,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 1.58 * SizeConfig.heightMultiplier,
              ),
              T1(AppLocalizations.of(context)!.signUpTitle, Images.accountIcon),
              SizedBox(
                height: 1.58 * SizeConfig.heightMultiplier,
              ),
              T2(AppLocalizations.of(context)!.signUpDesc),
              SizedBox(
                height: 5.26 * SizeConfig.heightMultiplier,
              ),
              Authtext(AppLocalizations.of(context)!.phoneText),
              SizedBox(
                height: 1.05 * SizeConfig.heightMultiplier,
              ),
              fieldText(
                  AppLocalizations.of(context)!.enterPhoneText,
                  controller.phoneController,
                  Icons.phone_android,
                  TextInputType.number),
              SizedBox(
                height: 3.16 * SizeConfig.heightMultiplier,
              ),
              Authtext(AppLocalizations.of(context)!.emailText),
              SizedBox(
                height: 1.05 * SizeConfig.heightMultiplier,
              ),
              fieldText(
                  AppLocalizations.of(context)!.enterEmailText,
                  controller.emailController,
                  Icons.email_outlined,
                  TextInputType.emailAddress),
              SizedBox(
                height: 3.16 * SizeConfig.heightMultiplier,
              ),
              Authtext(AppLocalizations.of(context)!.passwordText),
              SizedBox(
                height: 1.05 * SizeConfig.heightMultiplier,
              ),
              //* password textfield with GetX reactive state
              Obx(() => TextField(
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "CoreSansLight",
                        fontSize: 2.317 * SizeConfig.heightMultiplier),
                    obscureText: controller.obscureText.value,
                    controller: controller.passwordController,
                    decoration: fieldPasswordDecoration(
                            AppLocalizations.of(context)!.enterPasswordText,
                            Icons.lock_open)
                        .copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color.fromARGB(255, 219, 215, 215),
                          size: 2.63 * SizeConfig.heightMultiplier,
                        ),
                        onPressed: () {
                          controller.obscureText.value = !controller
                              .obscureText.value; // Toggle obscureText value
                        },
                      ),
                    ),
                  )),
              SizedBox(
                height: 4.21 * SizeConfig.heightMultiplier,
              ),
              controller.isLoading.value
                  ? Center(
                      child: SpinKitFadingCircle(
                      color: AppTheme.screenBackgroundColorGreen,
                      size: 3.1601*SizeConfig.heightMultiplier,
                    ))
                  : authButton(AppLocalizations.of(context)!.signUp, () {
                      signUpSubmit(context);
                    }),
              SizedBox(
                height: 4.21 * SizeConfig.heightMultiplier,
              ),
              Divider(
                color: const Color.fromARGB(255, 185, 181, 181),
                height: 5,
              ),
              SizedBox(
                height: 3.16 * SizeConfig.heightMultiplier,
              ),
              T3(
                  AppLocalizations.of(context)!.alreadySignUp1,
                  AppLocalizations.of(context)!.alreadySignUp2,
                  () => logNav(context)),
              SizedBox(
                height: 3.5 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
