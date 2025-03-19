import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Models/MorphButton.dart';
import 'package:my_porfolio/Models/SocialsModel.dart';
import 'package:my_porfolio/Utils/Constants.dart';

class MusicController extends GetxController {
  final firebase = FirebaseFirestore.instance;
  RxBool gettingMusicSocials = false.obs;
  RxList<MorphButton> musicMorphButtons =
      <MorphButton>[].obs; // music socials button
  RxList<SocialsModel> musicSocials = <SocialsModel>[].obs; // music socials

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMusicSocials();
  }

  Future getMusicSocials() async {
    gettingMusicSocials(true);
    try {
      final snapShot =
          await firebase.collection(APIEndpoints.music_socials).get();
      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.music_socials} collection';
      }

      musicSocials(
          snapShot.docs.map((e) => SocialsModel.fromSnapshot(e)).toList());
    } catch (e) {
      debugPrint('## ERROR GETTING MUSIC SOCIALS: $e');
    } finally {
      if (musicSocials.isNotEmpty) setMusicSocialButtons();
      gettingMusicSocials(false);
    }
  }

  setMusicSocialButtons() {
    musicMorphButtons.clear();
    musicSocials.forEach((e) {
      musicMorphButtons.add(
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
