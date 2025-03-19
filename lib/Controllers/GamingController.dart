import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Models/MorphButton.dart';
import 'package:my_porfolio/Models/SocialsModel.dart';
import 'package:my_porfolio/Utils/Constants.dart';

class GamingController extends GetxController {
  final firebase = FirebaseFirestore.instance;
  final RxBool ytHover = false.obs,
      twitchHover = false.obs,
      discordHover = false.obs,
      gettingGamingSocials = false.obs;

  RxList<MorphButton> gamingSocialsMorphButtons =
      <MorphButton>[].obs; // gaming social buttons
  RxList<SocialsModel> gamingSocials = <SocialsModel>[].obs; // music socials

  @override
  onInit() {
    super.onInit();
    getGamingSocials();
  }

  getGamingSocials() async {
    gettingGamingSocials(true);
    try {
      final snapShot =
          await firebase.collection(APIEndpoints.game_socials).get();
      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.game_socials} collection';
      }

      gamingSocials(
          snapShot.docs.map((e) => SocialsModel.fromSnapshot(e)).toList());
    } catch (e) {
      debugPrint('## ERROR GETTING GAME SOCIALS: $e');
    } finally {
      if (gamingSocials.isNotEmpty) setGamingSocialButtons();
      gettingGamingSocials(false);
    }
  }

  setGamingSocialButtons() {
    gamingSocialsMorphButtons.clear();
    gamingSocials.forEach((e) {
      gamingSocialsMorphButtons.add(
        MorphButton(
          label: (e.label).obs,
            isClicked: false.obs,
            showDetails: false.obs,
            isFocused: false.obs,
            image: e.image,
            image_hovered: e.imageReversed,
            pad: 50.0.obs,
            scale: 0.0.obs,
            link: e.link,gradientId: e.gradientId.obs),
      );
    });
  }
}
