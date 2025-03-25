import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/CodingController.dart';
import 'package:my_porfolio/Controllers/GamingController.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import 'package:my_porfolio/Controllers/MusicController.dart';
import 'package:my_porfolio/Controllers/ProjectsController.dart';
import 'package:my_porfolio/Controllers/SocialsController.dart';
import 'package:my_porfolio/Screens/Home.dart';
import 'package:my_porfolio/Utils/AppThemeData.dart';

import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(MainController()); // main controller
  Get.lazyPut(() => CodingController(), fenix: true); // coding controller
  Get.lazyPut(() => ProjectsController(), fenix: true); // projects controller
  Get.lazyPut(() => GamingController(), fenix: true); // gaming controller
  Get.lazyPut(() => MusicController(), fenix: true); // music controller
  Get.lazyPut(() => SocialsController(), fenix: true); // socials controller

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppThemeData.appThemeData,
    home: HomeContainer(),
  ));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(milliseconds: 111))
      .whenComplete(() => FlutterNativeSplash.remove());
}
