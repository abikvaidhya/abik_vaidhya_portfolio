import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Models/ExperienceModel.dart';
import 'package:my_porfolio/Models/FrameworksModel.dart';
import 'package:my_porfolio/Models/MorphButton.dart';
import 'package:my_porfolio/Models/SocialsModel.dart';
import 'package:my_porfolio/Utils/Constants.dart';

class CodingController extends GetxController {
  final firebase = FirebaseFirestore.instance;

  final RxBool flutter = false.obs,
      react = false.obs,
      vue = false.obs,
      gettingFrameworks = false.obs,
      gettingWorkSocials = false.obs,
      gettingExperiences = false.obs;

  RxInt frameworkIndex = (0).obs, // selected framework id
      experienceIndex = (0).obs; // current experience id

  Rx<MorphButton> projectButton = MorphButton(
              label: 'projects'.obs,
              isClicked: false.obs,
              showDetails: false.obs,
              isFocused: false.obs,
              image: Image.asset(ImageConstants.projects),
              image_hovered: Image.asset(ImageConstants.projects_hovered),
              pad: 50.0.obs,
              scale: 0.0.obs,
              link: 'projects')
          .obs,
      experienceButton = MorphButton(
              label: 'experiences'.obs,
              isClicked: false.obs,
              showDetails: false.obs,
              isFocused: false.obs,
              image: Image.asset(ImageConstants.experience),
              image_hovered: Image.asset(ImageConstants.experience_hovered),
              pad: 50.0.obs,
              scale: 0.0.obs,
              link: 'experiences')
          .obs;

  RxList<FrameworksModel> frameworks = <FrameworksModel>[].obs; // frameworks

  RxList<FrameworkProjectsModel> frameworkProjects =
      <FrameworkProjectsModel>[].obs; // framework projects

  RxList<ExperienceModel> experiences = <ExperienceModel>[].obs; // experiences

  RxList<MorphButton> jobSocialsMorphButtons =
      <MorphButton>[].obs; // job socials buttons

  RxList<SocialsModel> jobSocials = <SocialsModel>[].obs; // job socials

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFrameworks();
    getExperiences();
    getJobSocials();
  }

  // getting frameworks
  Future getFrameworks() async {
    gettingFrameworks(true);
    try {
      frameworks.clear();

      final snapShot = await firebase.collection(APIEndpoints.frameworks).get();
      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.frameworks} collection';
      }

      frameworks(
          snapShot.docs.map((e) => FrameworksModel.fromSnapshot(e)).toList());
    } catch (e) {
      debugPrint('## ERROR GETTING FRAMEWORKS LIST: $e');
    } finally {
      if (frameworks.isNotEmpty)
        frameworks.sort((a, b) => b.value.compareTo(a.value));

      gettingFrameworks(false);
    }
  }

  // getting framework wise projects
  Future getFrameworkWiseProjects({required String frameworkId}) async {
    // gettingFrameworks(true);
    try {
      frameworkProjects.clear();

      final snapShot = await firebase
          .collection(APIEndpoints.frameworks)
          .doc(frameworkId)
          .collection('projects')
          .get();

      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.frameworks} collection';
      }

      frameworkProjects(snapShot.docs
          .map((e) => FrameworkProjectsModel.fromSnapshot(e))
          .toList());
    } catch (e) {
      debugPrint('## ERROR GETTING FRAMEWORK PROJECT LIST: $e');
    } finally {
      // gettingFrameworks(false);
    }
  }

  // getting experiences
  Future getExperiences() async {
    gettingExperiences(true);
    try {
      experiences.clear();

      final snapShot =
          await firebase.collection(APIEndpoints.experiences).get();
      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.experiences} collection';
      }

      experiences(
          snapShot.docs.map((e) => ExperienceModel.fromSnapshot(e)).toList());
    } catch (e) {
      debugPrint('## ERROR GETTING EXPERIENCES LIST: $e');
    } finally {
      if (experiences.isNotEmpty) {
        experiences.sort((a, b) => b.startDate.compareTo(a.startDate));
        experienceIndex(0);
      }
      gettingExperiences(false);
    }
  }

  // getting work socials
  Future getJobSocials() async {
    gettingWorkSocials(true);
    try {
      final snapShot =
          await firebase.collection(APIEndpoints.work_socials).get();
      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.work_socials} collection';
      }

      jobSocials(
          snapShot.docs.map((e) => SocialsModel.fromSnapshot(e)).toList());
    } catch (e) {
      debugPrint('## ERROR GETTING WORK SOCIALS: $e');
    } finally {
      if (jobSocials.isNotEmpty) setButtons();
      gettingWorkSocials(false);
    }
  }

  setButtons() {
    jobSocialsMorphButtons.clear();
    jobSocials.forEach((e) {
      jobSocialsMorphButtons.add(
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

  // cacheImages(BuildContext context, {required Image image}) {
  //   precacheImage(image.image, context);
  // }
}
