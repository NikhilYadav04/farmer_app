import 'package:ai_plant_detecion/styling/toastMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HistoryController extends GetxController {
  //*define controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController editController = TextEditingController();
  GlobalKey<FormState> editKey = GlobalKey<FormState>();

  //* bool
  RxInt expandedIndex = 0.obs;

  //* functions

  //* for implementing expansion tile icon changes
  void changes(int index) {
    if (index + 1 == expandedIndex.value) {
      expandedIndex.value = 0;
    } else {
      expandedIndex.value = index + 1;
    }
  }

  //* edit user title
  Future<void> changeTitle(BuildContext context, String url) async {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('saved_response');
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      List<dynamic> responses = List.from(documentSnapshot["responses"]);

      int index = responses.indexWhere((response) => response["url"] == url);

      if (index == -1) {
        return;
      }
      responses[index]["title"] = editController.text.toString();

      await documentSnapshot.reference.update({"responses": responses});

      toastSuccessSlide(context, "Title updated");
    } catch (e) {
      print(e.toString());
    }
  }

  //* delete saved response
  Future<void> deleteResponse(BuildContext context, String url) async {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("saved_response");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      List<dynamic> responses = List.from(documentSnapshot["responses"]);

      responses.removeWhere((response) => response["url"] == url);

      await documentSnapshot.reference.update({"responses": responses});

      toastSuccessSlide(context, "Deleted Successfully");
      // Get.back();
    } catch (e) {
      print(e.toString());
    }
  }

  //* Fetch Data
  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    final email = FirebaseAuth.instance.currentUser!.email!;
    return FirebaseFirestore.instance
        .collection("saved_response")
        .where('email', isEqualTo: email)
        .snapshots();
  }
}
