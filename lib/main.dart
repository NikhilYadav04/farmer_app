import 'package:ai_plant_detecion/firebase_options.dart';
import 'package:ai_plant_detecion/global/locale_var.dart';
import 'package:ai_plant_detecion/helper/helper_functions.dart';
import 'package:ai_plant_detecion/l10n/l10n.dart';
import 'package:ai_plant_detecion/screens/auth/login_screen_mobile.dart';
import 'package:ai_plant_detecion/screens/main/appbar_screen_mobile.dart';
import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/responseiveLayout.dart';
import 'package:ai_plant_detecion/screens/onboard/onboard_screen_1_mobile.dart';
import 'package:ai_plant_detecion/screens/onboard/onboard_screen_1_tablet.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';

import 'styling/toastMessage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));

  //* Initialize dotenv
  await dotenv.load();

  // ignore: deprecated_member_use
  CloudinaryContext.cloudinary =
      await Cloudinary.fromCloudName(cloudName: dotenv.get('cloudinary_name'));

  //* Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return GetMaterialApp(
            supportedLocales: L10n.all,
            locale: Get.deviceLocale,
            fallbackLocale: locale_app,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: "AI Plant detecion",
            theme: ThemeData(
                fontFamily: "CoreSansMed",
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory),
            home: FutureBuilder(
                future: HelperFunctions.getAuthStatus(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: AppTheme.containerColor,
                      child: Image.asset(
                        "assets/icons/plant.png",
                        scale: 1.1,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    final status = snapshot.data!;
                    var logger = Logger();
                    logger.d("Status : ${status}");
                    if (status) {
                      return Responseivelayout(
                          mobileBody: AppbarScreenMobile(),
                          tabletBody: AppbarScreenMobile());
                    } else {
                      return Responseivelayout(
                          mobileBody: LoginScreenMobile(),
                          tabletBody: LoginScreenMobile());
                    }
                  } else {
                    toastErrorSlide(context,
                        "Error launching the app , Please try again!!");
                    return Container(
                      color: AppTheme.containerColor,
                      child: Image.asset(
                        "assets/icons/plant.png",
                        scale: 1.1,
                      ),
                    );
                  }
                }));
      },
    );
  }
}
