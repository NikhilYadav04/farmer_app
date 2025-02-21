import 'package:ai_plant_detecion/controllers/auth/getX_forgotPassword.dart';
import 'package:ai_plant_detecion/global/colors.dart';
import 'package:ai_plant_detecion/screens/auth/login_screen_mobile.dart';
import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotNumberEmailMobile extends StatelessWidget {
  ForgotNumberEmailMobile({super.key});

  final forgotEmailController controller = Get.put(forgotEmailController());

  //* send OTP function
  void sendOTP(BuildContext context) async {
    controller.clear();
    await controller.resetPassword(context);
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
            horizontal: 3.34 * SizeConfig.widthMultiplier,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 4.21 * SizeConfig.heightMultiplier,
              ),
              T1(
                AppLocalizations.of(context)!.emailText,
                "assets/icons/email.png",
              ),
              SizedBox(
                height: 1.57 * SizeConfig.heightMultiplier,
              ),
              T2(
                AppLocalizations.of(context)!.emailTextDesc,
              ),
              SizedBox(
                height: 3.16 * SizeConfig.heightMultiplier,
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
              controller.isLoading.value
                  ? Center(
                      child: SpinKitFadingCircle(
                      color: AppTheme.screenBackgroundColorGreen,
                      size: 30,
                    ))
                  : authButton(
                      AppLocalizations.of(context)!.receiveOtpText,
                      () => sendOTP(context),
                    ),
              SizedBox(
                height: 3.16 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
