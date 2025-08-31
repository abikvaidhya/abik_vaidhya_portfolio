import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Models/InfoModel.dart';
import 'package:my_porfolio/Models/StatusModel.dart';
import 'package:my_porfolio/Utils/Constants.dart';
import 'package:my_porfolio/Utils/StorageHelper.dart';

class MainController extends GetxController {
  final firebase = FirebaseFirestore.instance;

  // page controller
  final RxInt codingIndex = 0.obs, gamingIndex = 0.obs;

  final PageController pageController = PageController(
        initialPage: 0,
      ),
      codingController = PageController(
        initialPage: 0,
      ),
      // projectController = PageController(
      //   initialPage: 0,
      // ),
      experienceController = PageController(
        initialPage: 0,
      ),
      streamController = PageController(
        initialPage: 0,
      ),
      gamingController = PageController(
        initialPage: 0,
      ),
      musicController = PageController(
        initialPage: 0,
      ),
      socialsController = PageController(
        initialPage: 0,
      );

  RxBool isDark = true.obs,
      gettingStatus = true.obs,
      gettingInfo = false.obs,
      isCodeScrollDown = true.obs,
      isGameScrollDown = true.obs,
      projectDetails = false.obs;

  RxDouble showScrollBtn = 0.3.obs,
      scrollIndex = 0.0.obs,
      cursorX = 0.0.obs,
      cursorY = 0.0.obs;

  // late ProjectModel selectedProject;

  RxList<InfoModel> infos = <InfoModel>[].obs;

  // navigation bar
  final RxInt hoverID = 0.obs, navIndex = 0.obs, navIconID = (-1).obs;
  final RxDouble navHovered = 0.0.obs,
      scrollBtn = 0.0.obs,
      bgTop = 0.0.obs,
      headerTop = 0.0.obs,
      pad = 50.0.obs,
      scale = 0.0.obs;
  final RxBool showScrollDownBtn = false.obs;

// home screen
  final RxBool subtitle_1 = false.obs,
      subtitle_2 = false.obs,
      subtitle_3 = false.obs;

  // gradient colors list
  final morphButtonGradients = <List<Color>>[
    // flutter
    [
      Color(0xff2947EC),
      Color.fromRGBO(93, 147, 247, 1),
    ],
    // asp.net & react native
    [
      Color(0xff056FA0),
      Color(0xff0CB5F8),
    ],
    // vue.js
    [
      Color.fromRGBO(14, 180, 116, 1),
      Color(0xff7CEE8F),
    ],

    // github
    [
      Color.fromRGBO(197, 197, 197, 1),
      Color.fromRGBO(180, 180, 180, 1),
    ],
    // gitlab
    [
      Color.fromRGBO(235, 94, 29, 1),
      Color.fromRGBO(224, 118, 85, 1),
    ],
    // upwork
    [
      Color.fromRGBO(109, 235, 84, 1),
      Color.fromRGBO(58, 204, 14, 1),
    ],
    // linkedin
    [
      Color.fromRGBO(73, 141, 243, 1),
      Color.fromRGBO(6, 118, 247, 1),
    ],
    // [
    //   Color.fromRGBO(58, 204, 14, 1),
    //   Color.fromRGBO(12, 181, 248, 1),
    // ],

    // band labs
    [
      Color.fromRGBO(238, 65, 21, 1),
      Color.fromRGBO(241, 115, 77, 1),
    ],
    // sound cloud
    [
      Color.fromRGBO(238, 46, 46, 1),
      Color.fromRGBO(247, 83, 83, 1),
    ],

    // youtube
    [
      Color.fromRGBO(212, 30, 30, 1),
      Color.fromRGBO(247, 83, 83, 1),
    ],
    // twitch
    [
      Color.fromRGBO(176, 3, 245, 1),
      Color.fromRGBO(224, 82, 243, 1),
    ],
    // discord
    [
      Color.fromRGBO(6, 118, 247, 1),
      Color.fromRGBO(73, 141, 243, 1),
    ],

    // instagram
    [
      Color.fromRGBO(238, 155, 61, 1),
      Color.fromRGBO(202, 15, 93, 1),
    ],
    // facebook
    // [
    //   Color.fromRGBO(101, 160, 236, 1),
    //   Color.fromRGBO(38, 156, 235, 1),
    // ],
    // twitter
    [
      Color.fromRGBO(6, 118, 247, 1),
      Color.fromRGBO(73, 141, 243, 1),
    ],
  ];

  Statusmodel statusmodel = Statusmodel(live: false);

  @override
  onInit() {
    super.onInit();
    getStatus();
  }

  getStatus() async {
    gettingStatus(true);
    try {
      final snapShot = await firebase.collection(APIEndpoints.status).get();

      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.status} collection';
      }

      statusmodel = Statusmodel.fromSnapshot(snapShot.docs.last);
      if (statusmodel.live) {
        getInfo();
        saveDarkModeState();
      }
    } catch (e) {
      debugPrint('## ERROR GETTING SITE STATUS: $e');
    } finally {
      gettingStatus(false);
    }
  }

  saveDarkModeState({bool? state}) async {
    StorageHelper storageHelper = StorageHelper();

    if (state == null) {
      bool saved = await storageHelper.read(key: Constants.darkMode) == 'true';
      isDark(saved);
    } else {
      isDark(state);
    }
  }

  getInfo() async {
    gettingInfo(true);
    try {
      infos.clear();

      final snapShot = await firebase.collection(APIEndpoints.info).get();
      if (snapShot.docs.isEmpty) {
        throw 'Empty data in ${APIEndpoints.info} collection';
      }

      infos(snapShot.docs
          .map((e) => InfoModel.fromSnapshot(e))
          .toList()
          .where((info) => info.show)
          .toList());
    } catch (e) {
      debugPrint('## ERROR GETTING INFO LIST: $e');
    } finally {
      if (infos.isNotEmpty) {
        infos.sort((a, b) => a.id.value.compareTo(b.id.value));
        infos.removeWhere((e) => !e.show);
      }

      gettingInfo(false);
    }
  }
}
