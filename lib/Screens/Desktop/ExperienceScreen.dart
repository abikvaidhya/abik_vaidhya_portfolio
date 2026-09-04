import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/CodingController.dart';
import '../../Controllers/MainController.dart';
import '../../Utils/AppThemeData.dart';
import '../../Utils/Constants.dart';
import '../../Utils/FunctionUtils.dart';
import '../../Utils/UiUtils.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({key, required this.isDesktop});

  final bool isDesktop;

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  MainController mainController = Get.find<MainController>();
  CodingController codingController = Get.find<CodingController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Widgets.customShadowBox(
                Text(
                  'experiences',
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
                  padding: const EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height*0.6,
                  width: MediaQuery.of(context).size.width*0.5,
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
                  child: Obx(
                    () => PageView.builder(
                      controller: mainController.experienceController,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: codingController.experiences.length,
                      itemBuilder:
                          (BuildContext context, int experiencesIndex) {
                        return
                          Column(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // experience title
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    codingController
                                        .experiences[experiencesIndex]
                                        .title
                                        .value,
                                    textAlign: TextAlign.end,
                                    style: AppThemeData
                                        .appThemeData.textTheme.displayMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: mainController.isDark.value
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                ],
                              ),

                              // experience date
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    codingController
                                            .experiences[experiencesIndex]
                                            .name
                                            .value +
                                        ' (' +
                                        codingController
                                            .experiences[experiencesIndex]
                                            .startDate
                                            .toDate()
                                            .year
                                            .toString() +
                                        ' to ' +
                                        codingController
                                            .experiences[experiencesIndex]
                                            .endDate
                                            .toDate()
                                            .year
                                            .toString() +
                                        ')',
                                    style: AppThemeData
                                        .appThemeData.textTheme.bodySmall!
                                        .copyWith(
                                            color: mainController.isDark.value
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                ],
                              ),
                              Column(
                                spacing: 10,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          codingController
                                              .experiences[experiencesIndex]
                                              .description
                                              .value,
                                          textAlign: TextAlign.end,
                                          maxLines: 8,
                                          style: AppThemeData.appThemeData
                                              .textTheme.bodySmall!
                                              .copyWith(
                                                  color: mainController
                                                          .isDark.value
                                                      ? Colors.white
                                                      : Colors.black),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: codingController
                                    .experiences[experiencesIndex]
                                    .responsibilities
                                    .length,
                                itemBuilder: (BuildContext context,
                                    int responsibilitiesIndex) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      '- ' +
                                          codingController
                                                  .experiences[experiencesIndex]
                                                  .responsibilities[
                                              responsibilitiesIndex],
                                      maxLines: 2,
                                      textAlign: TextAlign.end,
                                      style: AppThemeData
                                          .appThemeData.textTheme.bodyMedium!
                                          .copyWith(
                                              color:
                                                  mainController.isDark.value
                                                      ? Colors.white
                                                      : Colors.black),
                                      softWrap: true,
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 10,
                                  );
                                },
                              ),
                            ],
                          );

                      },
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.6,
                  width: 400,
                  margin: EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.all(22.0),
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
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: AnimatedContainer(
                            duration: Duration(
                                milliseconds: Constants.animationDuration),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: codingController.experiences.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Functions.navigate(index + 1,
                                        mainController.experienceController);
                                    codingController.experienceIndex(index);
                                  },
                                  child:
                                      Obx(
                                        () => Row(
                                          children: [
                                            Icon(
                                              (index ==
                                                      (codingController
                                                          .experienceIndex
                                                          .value))
                                                  ? Icons.radio_button_checked
                                                  : Icons.radio_button_off,
                                              color:
                                                  mainController.isDark.value
                                                      ? Colors.white
                                                      : Colors.black,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              codingController
                                                  .experiences[index]
                                                  .name
                                                  .value,
                                              style: AppThemeData.appThemeData
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                fontWeight: index ==
                                                        (codingController
                                                            .experienceIndex
                                                            .value)
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: mainController
                                                        .isDark.value
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                ;
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      VerticalDivider(
                                        indent: 5,
                                        endIndent: 5,
                                        color: mainController.isDark.value
                                            ? Colors.white54
                                            : Colors.black54,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
