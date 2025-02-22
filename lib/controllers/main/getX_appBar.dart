import 'dart:io';
import 'dart:typed_data';

import 'package:ai_plant_detecion/helper/helper_functions.dart';
import 'package:ai_plant_detecion/screens/auth/login_screen_mobile.dart';
import 'package:ai_plant_detecion/styling/appTheme.dart';
import 'package:ai_plant_detecion/styling/sizeConfig.dart';
import 'package:ai_plant_detecion/styling/toastMessage.dart';
import 'package:ai_plant_detecion/widgets/home_widgets_2.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image/image.dart' as img;
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class appBarController extends GetxController {
  RxString profile_url = "".obs;

  //* profile photo add
  void addPhoto(File? _image1, File? _image2, BuildContext context) {
    Get.bottomSheet(Container(
      height: 35.5 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
          color: AppTheme.containerColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.6334 * SizeConfig.heightMultiplier),
              topRight: Radius.circular(2.6334 * SizeConfig.heightMultiplier))),
      child: Column(
        children: [
          SizedBox(
            height: 1.0533 * SizeConfig.heightMultiplier,
          ),
          Divider(
            height: 1.0533 * SizeConfig.heightMultiplier,
            color: Colors.white,
            indent: 35.7142 * SizeConfig.widthMultiplier,
            endIndent: 35.7142 * SizeConfig.widthMultiplier,
            thickness: 5,
          ),
          SizedBox(
            height: 2.1067 * SizeConfig.heightMultiplier,
          ),
          profile_url.value == ""
              ? Image.asset(
                  "assets/icons/account.png",
                  height: 8.42699 * SizeConfig.heightMultiplier,
                  width: 17.8571 * SizeConfig.widthMultiplier,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: CachedNetworkImage(
                    imageUrl: profile_url.value,
                    height: 9.42699 * SizeConfig.heightMultiplier,
                    width: 19.8571 * SizeConfig.widthMultiplier,
                  ),
                ),
          SizedBox(
            height: 1.7 * SizeConfig.heightMultiplier,
          ),
          SizedBox(
              height: 4.740185 * SizeConfig.heightMultiplier,
              child: GestureDetector(
                  onTap: () => _addImage(_image1, ImageSource.camera, context),
                  child: chooseWidget(Icons.camera_alt, "Choose from camera"))),
           SizedBox(
            height: 1.7 * SizeConfig.heightMultiplier,
          ),
          SizedBox(
              height: 4.740185 * SizeConfig.heightMultiplier,
              child: GestureDetector(
                  onTap: () => _addImage(_image2, ImageSource.gallery, context),
                  child: chooseWidget(Icons.photo, "Choose from gallery"))),
           SizedBox(
            height: 1.7 * SizeConfig.heightMultiplier,
          ),
          SizedBox(
              height: 4.740185 * SizeConfig.heightMultiplier,
              child: GestureDetector(
                  onTap: () => logout(),
                  child: chooseWidget(Icons.logout, "Logout"))),
          SizedBox(
            height: 0.2 * SizeConfig.heightMultiplier,
          )
        ],
      ),
    ));
  }

  //* get profile photo
  Future<void> getProfilePhoto() async {
    super.onInit();
    final email = FirebaseAuth.instance.currentUser!.email;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('profile_photo');
    QuerySnapshot querySnapshot =
        await collectionReference.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      final docs = querySnapshot.docs.first;
      profile_url.value = docs["url"];
      var logger = Logger();
      logger.d("Profiel url is ${profile_url}");
    }
  }

  //* take image from source and add to gallery
  Future<void> _addImage(
      File? _imagefile, ImageSource source, BuildContext context) async {
    try {
      final XFile? _pickedFile = await ImagePicker().pickImage(source: source);

      if (_pickedFile != null) {
        _imagefile = File(_pickedFile.path);
      } else {
        return;
      }

      await uploadImageAPI(_imagefile, context);
      toastSuccessSlide(context, "Profile Picture Updated");
    } catch (e) {
      toastErrorSlide(context, "Error uploading profile image");
    } finally {}
  }

  //* upload profile image to database
  Future<void> uploadImageAPI(File? image, BuildContext context) async {
    try {
      String profile_url = await uploadImage(image, context);
      final email = FirebaseAuth.instance.currentUser!.email;

      if (profile_url == "Error") {
        toastErrorSlide(context, "Cannot Upload Profile Photo");
        return;
      }

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('profile_photo');
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.update({"url": profile_url});
      } else {
        await collectionReference.add({"email": email, "url": profile_url});
      }

      return;
    } catch (e) {
      toastErrorSlide(context, "Cannot Upload Profile Photo");
      return;
    }
  }

  //* upload image to cloudinary
  Future<String> uploadImage(File? image, BuildContext context) async {
    if (image == null) {
      toastErrorSlide(context, "Invalid image path");
      return 'Error';
    }

    final cloudName = dotenv.get('cloudinary_name');
    final String cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/$cloudName/upload';

    try {
      final compressedImageBytes = await compressAndResizeImage(image);
      if (compressedImageBytes == null) {
        toastErrorSlide(context, "Image compression failed");
        return 'Error';
      }

      dio.Dio dioInstance = dio.Dio();

      dio.FormData formData = dio.FormData.fromMap({
        'upload_preset': 'e_items',
        'file': dio.MultipartFile.fromBytes(compressedImageBytes,
            filename: "compressed.jpg"),
      });

      dio.Response response = await dioInstance.post(
        cloudinaryUrl,
        data: formData,
        options: dio.Options(
          sendTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final jsonMap = response.data;

        if (jsonMap['url'] != null) {
          toastSuccessSlide(context, "Image Uploaded");
          return jsonMap['url'];
        }

        return 'Success';
      } else {
        toastErrorSlide(context, "Image Uploading Error");
        return "Error";
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        toastErrorSlide(context, "Connection timed out!");
      } else {
        toastErrorSlide(context, e.toString());
        return 'Error';
      }

      return 'Error';
    }
  }

  //* compress image and resize to square
  Future<Uint8List?> compressAndResizeImage(File image) async {
    try {
      final inputBytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(inputBytes);
      if (decodedImage == null) {
        print("Failed to decode the image.");
        return null;
      }

      final cropSize = decodedImage.width < decodedImage.height
          ? decodedImage.width
          : decodedImage.height;

      final xOffset = (decodedImage.width - cropSize) ~/ 2;
      final yOffset = (decodedImage.height - cropSize) ~/ 2;

      final croppedImage = img.copyCrop(
        decodedImage,
        x: xOffset,
        y: yOffset,
        height: cropSize,
        width: cropSize,
      );

      final resizedImage = img.copyResize(
        croppedImage,
        width: 500,
        height: 500,
      );

      final resizedBytes =
          Uint8List.fromList(img.encodeJpg(resizedImage, quality: 70));

      final compressedImage = await FlutterImageCompress.compressWithList(
        resizedBytes,
        minWidth: 500,
        minHeight: 500,
        quality: 60,
      );

      if (compressedImage.isEmpty) {
        print("Compression resulted in an empty list.");
        return null;
      }

      print("Compression successful. Size: ${compressedImage.length}");
      return Uint8List.fromList(compressedImage);
    } catch (e) {
      print("Compression error: ${e.toString()}");
      return null;
    }
  }

  //*index for appbar icons
  RxInt currentPage = 0.obs;

  //*for changing index between pages
  void changeIndex(index) {
    currentPage.value = index;
    print(currentPage);
  }

  //*appBar text acc to currentPage
  String appBarText(BuildContext context) {
    return currentPage == 0
        ? AppLocalizations.of(context)!.bottomBarDiagnose
        : AppLocalizations.of(context)!.bottomBarHistory;
  }

  //* logout
  Future<void> logout() async {
    try {
      await HelperFunctions.setAuthStatus(false);
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreenMobile(), transition: Transition.downToUp);
      profile_url.value = "";
    } catch (e) {
      print(e.toString());
    }
  }

  void onClose() {
    super.onClose();
  }
}
