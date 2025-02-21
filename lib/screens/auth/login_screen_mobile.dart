import 'package:ai_plant_detecion/styling/images.dart';
import 'package:ai_plant_detecion/controllers/auth/getX_logIn.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/screens/auth/signup_screen_mobile.dart';
import 'package:ai_plant_detecion/screens/forgot_pass/forgot_pass_email_mobile.dart';
import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreenMobile extends StatelessWidget {
  final LogInController controller = Get.put(LogInController());

  //* nav to forgot page
  void forgotNav(BuildContext context) {
    Get.to(() => ForgotNumberEmailMobile(), transition: Transition.rightToLeft);
  }

  //* function for navigate to signup page
  void signNav(BuildContext context) {
    Get.to(() => SignupScreenMobile(), transition: Transition.rightToLeft);
  }

  //* function for login
  void logInSubmit(BuildContext context) async {
    await controller.loginAccount(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: screenBackgroundColorIndigo,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: screenBackgroundColorIndigo,
          leading: IconButton(
            onPressed: () => Get.off(() => SignupScreenMobile(),
                transition: Transition.leftToRight),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 3.79 * SizeConfig.heightMultiplier,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 3.348 * SizeConfig.widthMultiplier,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),
                T1(
                  AppLocalizations.of(context)!.loginTitle,
                  Images.welcomeIcon,
                ),
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),
                T2(
                  AppLocalizations.of(context)!.loginDesc,
                ),
                SizedBox(
                  height: 4.21 * SizeConfig.heightMultiplier,
                ),
                Authtext(
                  AppLocalizations.of(context)!.emailText,
                ),
                SizedBox(
                  height: 1.05 * SizeConfig.heightMultiplier,
                ),
                fieldText(
                  AppLocalizations.of(context)!.enterEmailText,
                  controller.emailController,
                  Icons.email_outlined,
                  TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 3.16 * SizeConfig.heightMultiplier,
                ),
                Authtext(
                  AppLocalizations.of(context)!.passwordText,
                ),
                SizedBox(
                  height: 1.05 * SizeConfig.heightMultiplier,
                ),
                Obx(
                  () => TextField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoreSansLight",
                      fontSize: 2.31 * SizeConfig.heightMultiplier,
                    ),
                    obscureText: controller.obscureText.value,
                    controller: controller.passwordController,
                    decoration: fieldPasswordDecoration(
                      AppLocalizations.of(context)!.enterPasswordText,
                      Icons.lock_open,
                    ).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color.fromARGB(255, 219, 215, 215),
                          size: 2.63 * SizeConfig.heightMultiplier,
                        ),
                        onPressed: () {
                          controller.obscureText.value =
                              !controller.obscureText.value;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.21 * SizeConfig.heightMultiplier,
                ),
                controller.isLoading.value
                    ? Center(
                        child: SpinKitFadingCircle(
                        color: AppTheme.screenBackgroundColorGreen,
                        size: 30,
                      ))
                    : authButton(
                        AppLocalizations.of(context)!.loginText,
                        () {
                          logInSubmit(context);
                        },
                      ),
                SizedBox(
                  height: 3.6 * SizeConfig.heightMultiplier,
                ),
                T3(
                  AppLocalizations.of(context)!.forgotPass1,
                  AppLocalizations.of(context)!.forgotPass2,
                  () => forgotNav(context),
                ),
                SizedBox(
                  height: 2.63 * SizeConfig.heightMultiplier,
                ),
                orDivider(),
                SizedBox(
                  height: 3.16 * SizeConfig.heightMultiplier,
                ),
                T3(
                  AppLocalizations.of(context)!.alreadyLogin1,
                  AppLocalizations.of(context)!.alreadyLogin2,
                  () => signNav(context),
                ),
                SizedBox(
                  height: 3.5 * SizeConfig.heightMultiplier,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
