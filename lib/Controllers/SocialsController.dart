import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Models/MorphButton.dart';
import 'package:my_porfolio/Models/SocialsModel.dart';
import 'package:my_porfolio/Utils/Constants.dart';

class SocialsController extends GetxController {
  final firebase = FirebaseFirestore.instance;
  RxBool gettingSocials = false.obs;
  RxList<MorphButton> socialMorphButtons =
      <MorphButton>[].obs; // social buttons
  RxList<SocialsModel> socials = <SocialsModel>[].obs; // music socials

  @override
  onInit() {
    super.onInit();
    getSocials();
  }

  getSocials() async {
    gettingSocials(true);
    try {
      final snapShot = await firebase.collection(APIEndpoints.socials).get();
      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.socials} collection';
      }

      socials(snapShot.docs.map((e) => SocialsModel.fromSnapshot(e)).toList());
    } catch (e) {
      debugPrint('## ERROR GETTING SOCIALS: $e');
    } finally {
      if (socials.isNotEmpty) setGamingSocialButtons();
      gettingSocials(false);
    }
  }

  setGamingSocialButtons() {
    socialMorphButtons.clear();
    socials.forEach((e) {
      socialMorphButtons.add(
        MorphButton(
            label: (e.label).obs,
            isClicked: false.obs,
            showDetails: false.obs,
            isFocused: false.obs,
            image: e.image,
            image_hovered: e.imageReversed,
            pad: 50.0.obs,
            scale: 0.0.obs,
            link: e.link),
      );
    });
  }
}
