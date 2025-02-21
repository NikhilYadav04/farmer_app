// import 'package:ai_plant_detecion/controllers/auth/getX_forgotPassword.dart';
// import 'package:ai_plant_detecion/global/colors.dart';
// import 'package:ai_plant_detecion/screens/auth/login_screen_mobile.dart';
// import 'package:ai_plant_detecion/screens/forgot_pass/forgot_pass_email_mobile.dart';
// import 'package:ai_plant_detecion/screens/forgot_pass/otp_verify_mobile.dart';
// import 'package:ai_plant_detecion/styling/sizeConfig.dart';
// import 'package:ai_plant_detecion/widgets/auth_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:get/get.dart';

// class ForgotNumberMobile1 extends StatelessWidget {
//   ForgotNumberMobile1({super.key});

//   // Initialize GetX Controller
//   final forgotPhoneController controller = Get.put(forgotPhoneController());

//   //* navigate to email otp page
//   void emailNav(BuildContext context) {
//     controller.clear();
//     Get.off(() => ForgotNumberEmailMobile(),
//         transition: Transition.rightToLeft);
//   }

//   //* send otp function
//   void sendOTP(BuildContext context) {
//     controller.clear();
//     Get.off(() => ForgotNumberMobile2(), transition: Transition.rightToLeft);
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
//               Get.off(() => LoginScreenMobile(),
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
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: 3.34 * SizeConfig.widthMultiplier,
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 4.21 * SizeConfig.heightMultiplier,
//                 ),
//                 T1(
//                   AppLocalizations.of(context)!.phoneNumberText,
//                   "assets/icons/phone.png",
//                 ),
//                 SizedBox(
//                   height: 1.58 * SizeConfig.heightMultiplier,
//                 ),
//                 T2(
//                   AppLocalizations.of(context)!.phoneNumberTextDesc,
//                 ),
//                 SizedBox(
//                   height: 3.16 * SizeConfig.heightMultiplier,
//                 ),
//                 fieldText(
//                   AppLocalizations.of(context)!.enterPhoneText,
//                   controller.phoneController,
//                   Icons.phone_android_rounded,
//                   TextInputType.phone,
//                 ),
//                 SizedBox(
//                   height: 3.16 * SizeConfig.heightMultiplier,
//                 ),
//                 authButton(
//                   AppLocalizations.of(context)!.receiveOtpText,
//                   () => sendOTP(context),
//                 ),
//                 SizedBox(
//                   height: 3.16 * SizeConfig.heightMultiplier,
//                 ),
//                 orDivider(),
//                 SizedBox(
//                   height: 3.16 * SizeConfig.heightMultiplier,
//                 ),
//                 T3(
//                   AppLocalizations.of(context)!.cannotOtpText1,
//                   AppLocalizations.of(context)!.cannotOtpText2,
//                   () => emailNav(context),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
