// import 'package:ai_plant_detecion/controllers/auth/getX_verifyOTP.dart';
// import 'package:ai_plant_detecion/global/colors.dart';
// import 'package:ai_plant_detecion/screens/auth/change_password_mobile.dart';
// import 'package:ai_plant_detecion/screens/forgot_pass/forgot_pass_number_mobile.dart';
// import 'package:ai_plant_detecion/styling/sizeConfig.dart';
// import 'package:ai_plant_detecion/widgets/auth_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class ForgotNumberMobile2 extends StatelessWidget {
//   ForgotNumberMobile2({super.key});

//   final VerifyOTPCOntroller controller = Get.put(VerifyOTPCOntroller());
//   final TimerController timerController = Get.put(TimerController());

//   //* verify otp and navigate
//   void verifyOTP(BuildContext context) {
//     controller.clear(); // clear OTP field via GetX controller
//     Get.off(() => ChangePasswordMobile(), transition: Transition.rightToLeft);
//     timerController.resetTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: screenBackgroundColorIndigo,
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           backgroundColor: screenBackgroundColorIndigo,
//           leading: IconButton(
//             onPressed: () {
//               Get.off(() => ForgotNumberMobile1(),
//                   transition: Transition.leftToRight);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//               size: 3.79 * SizeConfig.heightMultiplier,
//             ),
//           ),
//           automaticallyImplyLeading: false,
//         ),
//         body: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: 3.34 * SizeConfig.widthMultiplier,
//           ),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 4.21 * SizeConfig.heightMultiplier,
//               ),
//               T1(
//                 AppLocalizations.of(context)!.otpVerificationText1,
//                 "assets/icons/otp.png",
//               ),
//               SizedBox(
//                 height: 2.10 * SizeConfig.heightMultiplier,
//               ),
//               T2(
//                 AppLocalizations.of(context)!.otpVerificationText2,
//               ),
//               SizedBox(
//                 height: 3.16 * SizeConfig.heightMultiplier,
//               ),
//               OTPfield(
//                 controller.OTPController, // GetX manages the OTP controller
//               ),
//               SizedBox(
//                 height: 4.21 * SizeConfig.heightMultiplier,
//               ),
//               authButton(
//                 AppLocalizations.of(context)!.verifyText,
//                 () => verifyOTP(context), // Navigation stays outside of GetX
//               ),
//               SizedBox(
//                 height: 3.16 * SizeConfig.heightMultiplier,
//               ),
//               orDivider(),
//               SizedBox(
//                 height: 3.16 * SizeConfig.heightMultiplier,
//               ),
//               Obx(() => T3(AppLocalizations.of(context)!.resendText,
//                   " ${timerController.remainingTime.value} Seconds", () {})),
//               SizedBox(
//                 height: 3.16 * SizeConfig.heightMultiplier,
//               ),
//               Obx(() => timerController.remainingTime.value == 0
//                   ? T4(AppLocalizations.of(context)!.resendText1)
//                   : T4(""))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
