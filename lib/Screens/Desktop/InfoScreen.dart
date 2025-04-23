import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/CodingController.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import 'package:my_porfolio/Controllers/SocialsController.dart';
import 'package:my_porfolio/Models/MorphButton.dart';
import 'package:my_porfolio/Utils/AppThemeData.dart';
import 'package:my_porfolio/Utils/UiUtils.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  MainController mainController = Get.find<MainController>();
  SocialsController socialsController = Get.find<SocialsController>();
  CodingController codingController = Get.find<CodingController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Center(
        child: Obx(
          () => mainController.gettingInfo.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: mainController.isDark.value
                        ? Colors.white
                        : Colors.black,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 40,
                  children: [
                    Widgets.customShadowBox(
                      Column(
                        spacing: 20,
                        children: [
                          Text(
                            mainController.infos[0].description.value,
                            style: AppThemeData
                                .appThemeData.textTheme.headlineSmall!
                                .copyWith(
                                    color: mainController.isDark.value
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          Text(
                            mainController.infos[0].label.value,
                            style: AppThemeData
                                .appThemeData.textTheme.headlineLarge!
                                .copyWith(
                                    color: mainController.isDark.value
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Widgets.subtitleTexts(
                                label: mainController.infos[0].subTitle1.value,
                                id: 0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      spacing: 20,
                      children: [
                        SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: codingController
                                    .jobSocialsMorphButtons.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Widgets.morphButton(context,
                                      buttonModel: codingController
                                          .jobSocialsMorphButtons[index],
                                      isCircle: false,
                                      height: 70,
                                      width: 70);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 40,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 70,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       ListView.separated(
                        //         shrinkWrap: true,
                        //         scrollDirection: Axis.horizontal,
                        //         itemCount:
                        //             socialsController.socialMorphButtons.length,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           return Widgets.morphButton(context,
                        //               buttonModel: socialsController
                        //                   .socialMorphButtons[index],
                        //               isCircle: true,
                        //               height: 70,
                        //               width: 70);
                        //         },
                        //         separatorBuilder:
                        //             (BuildContext context, int index) {
                        //           return SizedBox(
                        //             width: 40,
                        //           );
                        //         },
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
