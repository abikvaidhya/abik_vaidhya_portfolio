import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Utils/Constants.dart';

class ProjectModel extends GetxController {
  RxBool showDetails = false.obs;
  Image image;
  RxString id = ''.obs,
      link = ''.obs,
      ios_link = ''.obs,
      site = ''.obs,
      label = ''.obs,
      description = ''.obs,
      detail = ''.obs,
      devLang = ''.obs;
  RxList tags = [].obs, platform = [].obs;
  // RxList<ProjectSSModel> screenShots = <ProjectSSModel>[].obs;

  ProjectModel({
    required this.id,
    required this.showDetails,
    required this.image,
    required this.label,
    required this.link,
    required this.ios_link,
    required this.site,
    required this.devLang,
    required this.description,
    required this.detail,
    required this.platform,
    required this.tags,
    // required this.screenShots,
  });

  factory ProjectModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;
    return ProjectModel(
      id: (documentSnapshot.id).obs,
      showDetails: false.obs,
      image: Image.asset(ImageConstants.projectsPath + docData['icon']),
      label: docData['label'].toString().obs,
      link: ((docData['link'] ?? '').toString()).obs,
      ios_link: ((docData['ios_link'] ?? '').toString()).obs,
      site: ((docData['site'] ?? '').toString()).obs,
      devLang: docData['dev'].toString().obs,
      description: docData['description'].toString().obs,
      detail: (docData['app_detail'] ?? '').toString().obs,
      platform: [docData['platform'].toString()].obs,
      tags: [docData['status'].toString()].obs,
      // screenShots: [docData['status']].obs,
    );
  }
}

class ProjectSSModel {
  RxString link = ''.obs;

  ProjectSSModel({
    required this.link,
  });

  factory ProjectSSModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;
    return ProjectSSModel(
      link: ((docData['link'] ?? '').toString()).obs,
    );
  }
}
