import 'package:ai_plant_detecion/controllers/auth/getX_changePassword.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/screens/auth/login_screen_mobile.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

//*9.4933 vertical
//*4.48 horizontal

class ChangePasswordMobile extends StatelessWidget {
  ChangePasswordMobile({super.key});

  final changePasswordController controller =
      Get.put(changePasswordController());

  //* change password
  void changePassword() {
    controller.check();
    Get.off(() => LoginScreenMobile(), transition: Transition.rightToLeft);
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
            onPressed: () {
              Get.off(() => LoginScreenMobile(),
                  transition: Transition.leftToRight);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 3.79 * SizeConfig.heightMultiplier,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 1.58 * SizeConfig.heightMultiplier),
          child: Column(
            children: [
              SizedBox(
                height: 4.21 * SizeConfig.heightMultiplier,
              ),
              T1(
                AppLocalizations.of(context)!.changePassText,
                "assets/icons/password.png",
              ),
              SizedBox(
                height: 3.61 * SizeConfig.heightMultiplier,
              ),
              Authtext(
                AppLocalizations.of(context)!.newPassText,
              ),
              SizedBox(
                height: 2.10 * SizeConfig.heightMultiplier,
              ),
              //* password textfield
              Obx(() => TextField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoreSansLight",
                      fontSize: 2.31 * SizeConfig.heightMultiplier,
                    ),
                    obscureText: controller.obscureText1.value,
                    controller: controller.passwordController,
                    decoration: fieldPasswordDecoration(
                      AppLocalizations.of(context)!.enterPasswordText,
                      Icons.lock_open,
                    ).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureText1.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color.fromARGB(255, 219, 215, 215),
                          size: 2.63 * SizeConfig.heightMultiplier,
                        ),
                        onPressed: () {
                          controller.obscureText1
                              .toggle(); // Toggle obscureText value
                        },
                      ),
                    ),
                  )),
              SizedBox(
                height: 3.16 * SizeConfig.heightMultiplier,
              ),
              Authtext(
                AppLocalizations.of(context)!.rePassText,
              ),
              SizedBox(
                height: 2.106 * SizeConfig.heightMultiplier,
              ),
              //* confirm password textfield
              Obx(() => TextField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoreSansLight",
                      fontSize: 2.13 * SizeConfig.heightMultiplier,
                    ),
                    obscureText: controller.obscureText2.value,
                    controller: controller.passwordController1,
                    decoration: fieldPasswordDecoration(
                      AppLocalizations.of(context)!.rePassText1,
                      Icons.lock_open,
                    ).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureText2.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color.fromARGB(255, 219, 215, 215),
                          size: 2.63 * SizeConfig.heightMultiplier,
                        ),
                        onPressed: () {
                          controller.obscureText2
                              .toggle(); // Toggle obscureText value
                        },
                      ),
                    ),
                  )),
              SizedBox(
                height: 4.21 * SizeConfig.heightMultiplier,
              ),
              authButton(
                AppLocalizations.of(context)!.changePassText,
                changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
