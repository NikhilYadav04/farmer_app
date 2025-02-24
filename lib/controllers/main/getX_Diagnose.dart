// ignore_for_file: constant_pattern_never_matches_value_type

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_plant_detecion/controllers/main/getX_history.dart';
import 'package:ai_plant_detecion/screens/main/history/history_detail_screen_mobile.dart';
import 'package:ai_plant_detecion/styling/strings.dart';
import 'package:ai_plant_detecion/styling/toastMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';

class DiagnoseController extends GetxController {
  RxString profile_url = "".obs;

  //* variable to open diagnose box
  RxBool diagnoseShow = false.obs;

  RxBool isExpanded = false.obs;
  RxBool isLoadingResponse = false.obs;

  //* to change state of bool
  void change() {
    diagnoseShow.value = !diagnoseShow.value;
    isExpanded = false.obs;
  }

  var logger = Logger();

  //* functions
  //* main function to get response for model
  Future<void> getResponse(BuildContext context, File? image,
      HistoryController historyController) async {
    try {
      List<dynamic> medicinal_uses = [];
      List<dynamic> conservation_status = [];
      final dio_url = "https://plant-detection-server.onrender.com/predict";

      isLoadingResponse.value = true;

      //* api call to get plant name
      if (image == null) {
        isLoadingResponse.value = false;
        toastErrorSlide(context, "Invalid image file");
        return;
      }

      dio.Dio dioInstance = dio.Dio();

      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(
          image.path,
          filename: "image.jpg",
          contentType:
              dio.DioMediaType("image", "jpeg"), // Ensure correct content type
        ),
      });

      dio.Response response = await dioInstance.post(
        dio_url,
        data: formData,
        options: dio.Options(
          sendTimeout: Duration(seconds: 8),
          receiveTimeout: Duration(seconds: 70),
        ),
      );

      final String plant = response.data["plant_name"];

      logger.d("Plant name ${plant}");

      //* get medicinal and conservation status
      conservation_status = await getConservationStatus(context, plant);
      medicinal_uses = await getMedicineUses(context, plant);

      if (medicinal_uses.isEmpty || conservation_status.isEmpty) {
        isLoadingResponse.value = false;
        return;
      }

      //* save the image to cloudinary
      String url = await uploadImage(image, context);

      if (url == "Error") {
        isLoadingResponse.value = false;
        return;
      }

      final List<dynamic> responseList = [
        {
          "title": plant,
          "plant_name": plant,
          "med_uses": medicinal_uses,
          "cons_status": conservation_status,
          "url": url
        }
      ];

      isLoadingResponse.value = false;

      //* navigate to show response
      Get.to(
          () => HistoryDetailScreenMobile(
              historyController: historyController,
              list: responseList,
              index: 0,
              status: "response"),
          transition: Transition.upToDown);
    } catch (e) {
      isLoadingResponse.value = false;
      logger.d(e.toString());
      toastErrorSlide(context, "Error getting response");
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
          print("Image Uploaded");
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

  //* save response to database
  Future<String> saveResponse(
      BuildContext context,
      String title,
      String plantName,
      List<dynamic> med_uses,
      List<dynamic> cons_status,
      String url) async {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('saved_response');
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        await collectionReference.add({
          "email": email,
          "responses": [
            {
              "title": title,
              "url": url,
              "plant_name": plantName,
              "med_uses": med_uses,
              "cons_status": cons_status,
              "status": true
            }
          ]
        });
      } else {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        DocumentReference documentReference = documentSnapshot.reference;

        await documentReference.update({
          "responses": FieldValue.arrayUnion([
            {
              "title": title,
              "url": url,
              "plant_name": plantName,
              "med_uses": med_uses,
              "cons_status": cons_status,
              "status": true
            }
          ])
        });
      }

      toastSuccessSlide(context, "Response Added Successfully");
      return "Success";
    } catch (e) {
      toastErrorSlide(context, "Error saving response");
      return "Error";
    }
  }

  //* get responses from model

  Future<List<dynamic>> getMedicineUses(
      BuildContext context, String plant) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-2.0-flash-exp',
        apiKey: dotenv.get('GEMINI_API'),
        generationConfig: GenerationConfig(
          temperature: 1,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 8192,
          responseMimeType: 'text/plain',
        ),
      );
      final chat = model.startChat(history: []);

      final message = Strings.promptMedicine(plant);
      final content = Content.text(message);
      var logger = Logger();

      final response = await chat.sendMessage(content);

      logger.d(response.text.toString());

      String cleanedResponse =
          response.text!.replaceAll(RegExp(r'```json|```'), '').trim();

      List<dynamic> decoded = jsonDecode(cleanedResponse);
      logger.d(decoded);

      return decoded;
    } catch (e) {
      logger.d(e.toString());
      toastErrorSlide(context, "Error : ${e.toString()}");
      return [];
    }
  }

  Future<List<dynamic>> getConservationStatus(
      BuildContext context, String plant) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-2.0-flash-exp',
        apiKey: dotenv.get('GEMINI_API'),
        generationConfig: GenerationConfig(
          temperature: 1,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 8192,
          responseMimeType: 'text/plain',
        ),
      );
      final chat = model.startChat(history: []);

      final message = Strings.promptStatus(plant);
      final content = Content.text(message);
      var logger = Logger();

      final response = await chat.sendMessage(content);
      logger.d(response.text);

      String cleanedResponse =
          response.text!.replaceAll(RegExp(r'```json|```'), '').trim();

      List<dynamic> decoded = jsonDecode(cleanedResponse);
      logger.d(decoded);

      return decoded;
    } catch (e) {
      toastErrorSlide(context, "Error : ${e.toString()}");
      return [];
    }
  }
}
