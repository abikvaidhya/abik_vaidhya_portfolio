import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Models/MorphButton.dart';
import 'package:my_porfolio/Models/ProjectModel.dart';
import 'package:my_porfolio/Utils/Constants.dart';

class ProjectsController extends GetxController {
  final firebase = FirebaseFirestore.instance;
  RxBool gettingProjects = false.obs, gettingScreenShots = false.obs;
  RxInt launchedProjectIndex = 0.obs;

  RxList<ProjectModel> projects = <ProjectModel>[].obs,
      launched_projects = <ProjectModel>[].obs; // project list
  RxList<ProjectSSModel> projectScreenShots = <ProjectSSModel>[].obs;

  RxList<MorphButton> projectMorphButtons = <MorphButton>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProjects();
  }

  // getting projects
  Future getProjects() async {
    gettingProjects(true);
    try {
      final snapShot = await firebase.collection(APIEndpoints.projects).get();
      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.projects} collection';
      }

      projects(snapShot.docs.map((e) => ProjectModel.fromSnapshot(e)).toList());
    } catch (e) {
      debugPrint('## ERROR GETTING PROJECTS LIST: $e');
    } finally {
      if (projects.isNotEmpty) {
        launched_projects.value =
            projects.where((e) => e.tags.contains('launched')).toList();
        launched_projects
            .sort((a, b) => b.label.value.compareTo(a.label.value));

        projects.sort((a, b) => a.label.value.compareTo(b.label.value));
        // getProjectScreenShots(id: launched_projects.first.id.value);
        getProjectScreenShots(id: projects.first.id.value);
      }
      gettingProjects(false);
    }
  }

  // getting projects
  Future getProjectScreenShots({required String id}) async {
    gettingScreenShots(true);
    try {
      final snapShot = await firebase
          .collection(APIEndpoints.projects)
          .doc(id)
          .collection('ss')
          .get();

      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.projects} screenshots collection';
      }

      projectScreenShots(
          snapShot.docs.map((e) => ProjectSSModel.fromSnapshot(e)).toList());
    } catch (e) {
      debugPrint('## ERROR GETTING PROJECT SCREENSHOTS LIST: $e');
      projectScreenShots.clear();
    } finally {
      // debugPrint(
      //     '## PROJECT SCREENSHOTS Link: ${projectScreenShots.first.link}');

      gettingScreenShots(false);
    }
  }

  // setButtons() {
  //   projectMorphButtons.clear();
  //   projects.forEach((e) {
  //     projectMorphButtons.add(
  //       MorphButton(
  //           isClicked: false.obs,
  //           showDetails: false.obs,
  //           isFocused: false.obs,
  //           image: e.image,
  //           image_hovered: e.image,
  //           pad: 50.0.obs,
  //           scale: 0.0.obs,
  //           link: e.link.value),
  //     );
  //   });
  // }
}
