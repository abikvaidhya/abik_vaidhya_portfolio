import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/CodingController.dart';
import '../../Controllers/MainController.dart';
import '../../Utils/AppThemeData.dart';
import '../../Utils/UiUtils.dart';

class CodingScreen extends StatefulWidget {
  CodingScreen({key, required this.isDesktop});

  final bool isDesktop;

  @override
  State<CodingScreen> createState() => _CodingScreenState();
}

class _CodingScreenState extends State<CodingScreen> {
  MainController mainController = Get.find<MainController>();
  CodingController codingController = Get.find<CodingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.all(Radius.circular(20)),
      //   color: (mainController.isDark.value)
      //       ? Colors.grey.shade900
      //       : Colors.grey.shade100,
      // ),
      // margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(20.0),
      child: Column(
        spacing: 20,
        children: [
          // title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // title
              Widgets.customShadowBox(
                Text(
                  mainController.infos[1].label.value,
                  style: AppThemeData.appThemeData.textTheme.headlineMedium!
                      .copyWith(
                          color: mainController.isDark.value
                              ? Colors.white
                              : Colors.black),
                ),
              ),
            ],
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: (mainController.isDark.value)
                        ? Colors.grey.shade900
                        : Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[500]!,
                          offset: (mainController.isDark.value)
                              ? Offset(2, 2)
                              : Offset(4, 4),
                          blurRadius: mainController.isDark.value ? 5 : 15,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Colors.white.withAlpha(50),
                          offset: (mainController.isDark.value)
                              ? Offset(-2, -2)
                              : Offset(-4, -4),
                          blurRadius: mainController.isDark.value ? 5 : 15,
                          spreadRadius: 1)
                    ],
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Text(
                        mainController.infos[1].description.value,
                        softWrap: true,
                        style: AppThemeData.appThemeData.textTheme.bodyLarge!
                            .copyWith(
                                color: mainController.isDark.value
                                    ? Colors.white
                                    : Colors.black),
                      ),

                      // download CV
                      SizedBox(
                        height: 60,
                        child: Widgets.morphButton(context,
                            buttonModel: mainController.downloadButton,
                            onlyText: true,
                            width: 300),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: (mainController.isDark.value)
                        ? Colors.grey.shade900
                        : Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[500]!,
                          offset: (mainController.isDark.value)
                              ? Offset(2, 2)
                              : Offset(4, 4),
                          blurRadius: mainController.isDark.value ? 5 : 15,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Colors.white.withAlpha(50),
                          offset: (mainController.isDark.value)
                              ? Offset(-2, -2)
                              : Offset(-4, -4),
                          blurRadius: mainController.isDark.value ? 5 : 15,
                          spreadRadius: 1)
                    ],
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // description 1
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              mainController.infos[1].subTitle1.value,
                              softWrap: true,
                              style: AppThemeData
                                  .appThemeData.textTheme.bodySmall!
                                  .copyWith(
                                      color: mainController.isDark.value
                                          ? Colors.white
                                          : Colors.black),
                            ),
                          ),
                        ],
                      ),

                      // description 2
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              mainController.infos[1].subTitle2.value,
                              softWrap: true,
                              style: AppThemeData
                                  .appThemeData.textTheme.bodySmall!
                                  .copyWith(
                                      color: mainController.isDark.value
                                          ? Colors.white
                                          : Colors.black),
                            ),
                            // ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
