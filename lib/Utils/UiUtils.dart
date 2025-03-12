import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/CodingController.dart';
import 'package:my_porfolio/Controllers/GamingController.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import 'package:my_porfolio/Controllers/MusicController.dart';
import 'package:my_porfolio/Controllers/ProjectsController.dart';
import 'package:my_porfolio/Controllers/SocialsController.dart';
import 'package:my_porfolio/Models/MorphButton.dart';
import 'package:my_porfolio/Models/ProjectModel.dart';
import 'package:my_porfolio/Utils/AppThemeData.dart';
import 'package:my_porfolio/Utils/Constants.dart';
import 'package:my_porfolio/Utils/FunctionUtils.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Widgets {
  Future showToast(String msg,
      {bool isShort = false, bool isDark = false}) async {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: isShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: isShort ? 1 : 2,
      backgroundColor: isDark ? Colors.white : Colors.black,
      textColor: isDark ? Colors.black : Colors.white,
    );
  }

  static Future defaultDialog(String label) {
    return Get.defaultDialog(
      title: '$label',
      middleText: "i worked on $label",
      barrierDismissible: true,
      radius: 30,
      content: Text('hello world'),
      backgroundColor: Colors.grey.shade700.withOpacity(0.6),
      titleStyle: TextStyle(color: Colors.white),
      middleTextStyle: TextStyle(color: Colors.white),
    );
  }

  static Widget scrollButton() {
    MainController mainController = Get.find<MainController>();
    return Obx(
      () => AnimatedOpacity(
        opacity: mainController.scrollBtn.value,
        duration: Duration(milliseconds: 200),
        child: IconButton(
            onPressed: () {
              mainController.navHovered.value = 0.0;
              Functions.navigate(0, mainController.pageController);
            },
            icon: Icon(
              Icons.arrow_drop_up_rounded,
              color: mainController.isDark.value ? Colors.white : Colors.black,
            )),
      ),
    );
  }

  static Widget bulletineIcon(bool hasColor,
      {double? iconSize, Color iconColor = Colors.white}) {
    return Icon(
      Icons.circle,
      size: iconSize,
      color: (hasColor) ? iconColor : AppThemeData.appThemeData.primaryColor,
    );
  }

  static FlashyTabBarItem flashyTabBarItem(String label, IconData iconData) {
    return FlashyTabBarItem(
      icon: Icon(iconData),
      title: Text('${label}'),
    );
  }

  static MouseRegion desktopScrollButton(
      PageController pageController, RxBool scrollDown) {
    MainController mainController = Get.find<MainController>();
    return MouseRegion(
      onEnter: (e) {
        mainController.showScrollBtn.value = 1.0;
      },
      onExit: (e) {
        mainController.showScrollBtn.value =
            (mainController.isDark.value) ? 0.6 : 0.3;
      },
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: mainController.showScrollBtn.value,
        child: IconButton(
            onPressed: () {
              if (scrollDown.value)
                pageController.nextPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn);
              else
                pageController.animateTo(pageController.initialPage.toDouble(),
                    duration: Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn);
            },
            icon: Icon((scrollDown.value)
                ? Icons.keyboard_arrow_down_rounded
                : Icons.keyboard_arrow_up_rounded)),
      ),
    );
  }

  static Container projectCard(ProjectModel project, Color iconColor) {
    MainController mainController = Get.find<MainController>();
    return Container(
      margin: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          mainController.projectDetails.value =
              !mainController.projectDetails.value;
          mainController.selectedProject = project;
        },
        child: Card(
          color: mainController.isDark.value
              ? Colors.white30
              : Colors.grey.shade200,
          elevation: 5,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: Image(
                    // height: 100,
                    width: 100,
                    image: project.image.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      '${project.label}',
                      style: AppThemeData.appThemeData.textTheme.bodySmall!
                          .copyWith(
                              height: 1,
                              color: mainController.isDark.value
                                  ? Colors.white
                                  : Colors.black),
                      textAlign: TextAlign.start,
                      softWrap: true,
                    )),
                    // bulletineIcon(true, iconColor: iconColor)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget subtitleTexts({required int id, required String label}) {
    MainController mainController = Get.find<MainController>();

    return MouseRegion(
      onEnter: (v) {
        switch (id) {
          case 0:
            mainController.subtitle_1.value = true;
            break;
          case 3:
            mainController.subtitle_2.value = true;
            break;
        }
      },
      onExit: (v) {
        switch (id) {
          case 0:
            mainController.subtitle_1.value = false;
            break;
          case 3:
            mainController.subtitle_2.value = false;
            break;
        }
      },
      child: Center(
        child: Obx(
          () => AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 111),
            style: !((id == 0)
                    ? mainController.subtitle_1.value
                    : mainController.subtitle_2.value)
                ? AppThemeData.appThemeData.textTheme.displaySmall!.copyWith(
                    color: mainController.isDark.value
                        ? Colors.white
                        : Colors.black)
                : AppThemeData.appThemeData.textTheme.titleSmall!.copyWith(
                    color: mainController.isDark.value
                        ? Colors.white
                        : Colors.black),
            child: GestureDetector(
              onTap: () {
                Functions.navigate(id + 2, mainController.pageController);
              },
              child: Text(
                '${label}',
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget customShadowBox(Widget child,
      {double opacity = 0.6, double sigma = 4}) {
    MainController mainController = Get.find<MainController>();
    return Obx(
      () => SimpleShadow(
        opacity: opacity,
        offset:
            mainController.isDark.value ? Offset(4.0, 3.0) : Offset(8.0, 6.0),
        sigma: sigma,
        child: child,
        color: mainController.isDark.value ? Colors.grey : Colors.black,
      ),
    );
  }

// coding
  static Widget CodingIntroDetails(
      {required BuildContext context, required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    CodingController codingController = Get.find<CodingController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (isDesktop) ? 44.0 : 20.0),
      child: (mainController.infos.isEmpty)
          ? SizedBox.shrink()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Widgets.customShadowBox(
                          Text(
                            mainController.infos[1].label.value,
                            style: AppThemeData
                                .appThemeData.textTheme.headlineMedium!
                                .copyWith(
                                    color: mainController.isDark.value
                                        ? Colors.white
                                        : Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Widgets.customShadowBox(
                            Text(
                              mainController.infos[1].description.value,
                              softWrap: true,
                              style: AppThemeData
                                  .appThemeData.textTheme.bodyMedium!
                                  .copyWith(
                                      color: mainController.isDark.value
                                          ? Colors.white
                                          : Colors.black),
                              maxLines: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Widgets.customShadowBox(
                            Text(
                              mainController.infos[1].subTitle1.value,
                              softWrap: true,
                              style: AppThemeData
                                  .appThemeData.textTheme.bodyMedium!
                                  .copyWith(
                                      color: mainController.isDark.value
                                          ? Colors.white
                                          : Colors.black),
                              maxLines: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Widgets.customShadowBox(
                            Text(
                              mainController.infos[1].subTitle2.value,
                              softWrap: true,
                              style: AppThemeData
                                  .appThemeData.textTheme.bodyMedium!
                                  .copyWith(
                                      color: mainController.isDark.value
                                          ? Colors.white
                                          : Colors.black),
                              maxLines: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isDesktop)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                    child: Row(
                      spacing: 40,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Widgets.pieChart(context,
                            isDesktop: isDesktop, label: 'frameworks'),
                        Widgets.workSocialsMorphButtons(context,
                            isDesktop: isDesktop),
                        Obx(
                          () => morphButton(context, callBack: () {
                            Functions.navigate(
                                4, mainController.codingController);
                          }, buttonModel: codingController.projectButton.value),
                        ),
                        Obx(
                          () => morphButton(context, callBack: () {
                            Functions.navigate(
                                3, mainController.codingController);
                          },
                              buttonModel:
                                  codingController.experienceButton.value),
                        ),
                      ],
                    ),
                  ),
                // ElevatedButton(
                //     onPressed: () {
                //       Functions.navigate(3, mainController.codingController);
                //     },
                //     child: Text('Experiences'))
              ],
            ),
    );
  }

  static Widget FrameworksDetails({required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    CodingController codingController = Get.find<CodingController>();

    return (codingController.frameworks.isNotEmpty &&
            codingController.frameworkIndex.value > -1)
        ? Padding(
            padding: const EdgeInsets.all(44.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Widgets.customShadowBox(
                      Text(
                        codingController
                            .frameworks[codingController.frameworkIndex.value]
                            .label,
                        style: AppThemeData
                            .appThemeData.textTheme.headlineMedium!
                            .copyWith(
                                color: mainController.isDark.value
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Widgets.customShadowBox(
                          Text(
                            codingController
                                .frameworks[
                                    codingController.frameworkIndex.value]
                                .description,
                            maxLines: 8,
                            style: AppThemeData
                                .appThemeData.textTheme.bodyMedium!
                                .copyWith(
                                    color: mainController.isDark.value
                                        ? Colors.white
                                        : Colors.black),
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: codingController.frameworkProjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Widgets.customShadowBox(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                codingController.frameworkProjects[index].label,
                                style: AppThemeData
                                    .appThemeData.textTheme.bodyMedium!
                                    .copyWith(
                                        color: mainController.isDark.value
                                            ? Colors.white
                                            : Colors.black),
                                softWrap: true,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              if (codingController
                                  .frameworkProjects[index].link.isNotEmpty)
                                GestureDetector(
                                    onTap: () {
                                      Functions.openLink(codingController
                                          .frameworkProjects[index].link);
                                    },
                                    child: Icon(Icons.link,
                                        color: mainController.isDark.value
                                            ? Colors.white
                                            : Colors.black))
                            ],
                          ),
                          Text(
                            codingController
                                .frameworkProjects[index].description,
                            maxLines: 2,
                            style: AppThemeData
                                .appThemeData.textTheme.bodySmall!
                                .copyWith(
                                    color: mainController.isDark.value
                                        ? Colors.white
                                        : Colors.black),
                            softWrap: true,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  static Widget ExperienceDetails({required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    CodingController codingController = Get.find<CodingController>();

    return (codingController.experiences.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.all(44.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.customShadowBox(
                        Text(
                          'experiences',
                          style: AppThemeData
                              .appThemeData.textTheme.headlineLarge!
                              .copyWith(
                                  color: mainController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => PageView.builder(
                            controller: mainController.experienceController,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: codingController.experiences.length,
                            itemBuilder:
                                (BuildContext context, int experiencesIndex) {
                              return Widgets.customShadowBox(
                                 Column(
                                  spacing: 20,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                          Text(
                                            codingController
                                                .experiences[experiencesIndex]
                                                .name
                                                .value,
                                            style: AppThemeData.appThemeData
                                                .textTheme.headlineLarge!
                                                .copyWith(
                                                    color: mainController
                                                            .isDark.value
                                                        ? Colors.white
                                                        : Colors.black),
                                          ),

                                      ],
                                    ),
                                    Row(
                                      children: [
                                          Text(
                                            codingController
                                                    .experiences[experiencesIndex]
                                                    .title
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
                                            style: AppThemeData.appThemeData
                                                .textTheme.displayMedium!
                                                .copyWith(
                                                    color: mainController
                                                            .isDark.value
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
                                              child:
                                                Text(
                                                  codingController
                                                      .experiences[
                                                          experiencesIndex]
                                                      .description
                                                      .value,
                                                  maxLines: 8,
                                                  style: AppThemeData.appThemeData
                                                      .textTheme.bodyMedium!
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
                                          child:
                                            Text(
                                              '- ' +
                                                  codingController
                                                          .experiences[
                                                              experiencesIndex]
                                                          .responsibilities[
                                                      responsibilitiesIndex],
                                              maxLines: 2,
                                              style: AppThemeData.appThemeData
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                      color: mainController
                                                              .isDark.value
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
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 300,
                        child: Center(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 111),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: codingController.experiences.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Functions.navigate(index + 1,
                                          mainController.experienceController);
                                      codingController.experienceIndex(index);
                                    },
                                    child: Obx(
                                      () => Text(
                                          codingController
                                              .experiences[index].name.value,
                                          style: AppThemeData.appThemeData
                                              .textTheme.bodyMedium!
                                              .copyWith(
                                            fontSize: (index ==
                                                    (codingController
                                                        .experienceIndex.value))
                                                ? 20
                                                : 16,
                                            color: mainController.isDark.value
                                                ? Colors.white
                                                : Colors.black,
                                            decoration: (index ==
                                                    (codingController
                                                        .experienceIndex.value))
                                                ? TextDecoration.underline
                                                : TextDecoration.none,
                                          )),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 20,
                                  child: Center(
                                      child: VerticalDivider(
                                    color: mainController.isDark.value
                                        ? Colors.white54
                                        : Colors.black54,
                                  )),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : SizedBox.shrink();
  }

  static Widget projectDetails({required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    ProjectsController projectsController = Get.find<ProjectsController>();

    return Padding(
      padding: EdgeInsets.all((isDesktop) ? 44.0 : 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Widgets.customShadowBox(
                Text(
                  'projects',
                  style: AppThemeData.appThemeData.textTheme.headlineMedium!
                      .copyWith(
                          color: mainController.isDark.value
                              ? Colors.white
                              : Colors.black),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: (mainController.projectDetails.value)
                        ? projectDetailSection(isDesktop)
                        : GridView(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: (isDesktop) ? 8 : 2),
                            children: [
                              for (ProjectModel project
                                  in projectsController.projects)
                                Widgets.projectCard(
                                    project,
                                    project.devLang.value == 'vue'
                                        ? Colors.green
                                        : project.devLang.value == 'react'
                                            ? Color.fromARGB(255, 3, 117, 248)
                                            : Color.fromARGB(255, 9, 74, 187))
                            ],
                          ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  static Padding projectDetailSection(bool isDesktop) {
    MainController mainController = Get.find<MainController>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: customShadowBox(
        Obx(
          () => Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 20,
                children: [
                  GestureDetector(
                      onTap: () {
                        mainController.projectDetails.value =
                            !mainController.projectDetails.value;
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: mainController.isDark.value
                            ? Colors.white
                            : Colors.black,
                      )),
                  Text(
                    mainController.selectedProject.label.value,
                    style: AppThemeData.appThemeData.textTheme.displayLarge!
                        .copyWith(
                      color: mainController.isDark.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      mainController.selectedProject.description.value,
                      softWrap: true,
                      style: AppThemeData.appThemeData.textTheme.bodyMedium!
                          .copyWith(
                        color: mainController.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                      maxLines: 8,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'developed using:',
                      style: AppThemeData.appThemeData.textTheme.bodyMedium!
                          .copyWith(
                        color: mainController.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (isDesktop) ? 3 : 1,
                    child: Text(
                      mainController.selectedProject.devLang.value,
                      style: AppThemeData.appThemeData.textTheme.bodyMedium!
                          .copyWith(
                        color: mainController.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'platforms:',
                      style: AppThemeData.appThemeData.textTheme.bodyMedium!
                          .copyWith(
                        color: mainController.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: (isDesktop) ? 3 : 1,
                      child: Text(
                        mainController.selectedProject.platform
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', ''),
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: mainController.isDark.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// gaming
  static Widget YoutubeDetails(
      {required BuildContext context, required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    return Padding(
      padding: const EdgeInsets.all(44.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Widgets.streamLinkButtons(
                0,
                'youtube',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Widgets.customShadowBox(
                    Text(
                      'i upload clips from my gameplays and live streams to my youtube channel. drop by and show some love if you can. thanks!',
                      style: AppThemeData.appThemeData.textTheme.bodyMedium!
                          .copyWith(
                              color: mainController.isDark.value
                                  ? Colors.white
                                  : Colors.black),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // (isDesktop)
          //     ? SizedBox()
          //     : Widgets.gamingSocialsMorphButtons(context, 0, isDesktop: false)
        ],
      ),
    );
  }

  static Widget TwitchDetails(
      {required BuildContext context, required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    return Padding(
      padding: const EdgeInsets.all(44.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Widgets.streamLinkButtons(
                1,
                'twitch',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Widgets.customShadowBox(
                    Text(
                      'i try to stream regularly, as much as i can. i normally just stream for myself. my live streams include games like valorant, apex legends, gta v online, singing sessions, podcasts and coding streams.\nyou can check out my twitch.',
                      style: AppThemeData.appThemeData.textTheme.bodyMedium!
                          .copyWith(
                              color: mainController.isDark.value
                                  ? Colors.white
                                  : Colors.black),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // (isDesktop)
          //     ? SizedBox()
          //     : Widgets.gamingSocialsMorphButtons(context, 1, isDesktop: false)
        ],
      ),
    );
  }

  static Widget DiscordDetails(
      {required BuildContext context, required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    return Padding(
      padding: const EdgeInsets.all(44.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Widgets.streamLinkButtons(
                2,
                'discord',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Widgets.customShadowBox(
                    Text(
                      'you can join my discord server. we can have fun together with my friends.',
                      style: AppThemeData.appThemeData.textTheme.bodyMedium!
                          .copyWith(
                              color: mainController.isDark.value
                                  ? Colors.white
                                  : Colors.black),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // (isDesktop)
          //     ? SizedBox()
          //     : Widgets.gamingSocialsMorphButtons(context, 2, isDesktop: false)
        ],
      ),
    );
  }

  // morph button
  static Widget morphButton(BuildContext context,
      {required MorphButton buttonModel,
      bool isDesktop = true,
      VoidCallback? callBack}) {
    MainController mainController = Get.find<MainController>();

    return GestureDetector(
      onTap: () async {
        buttonModel.isClicked(true);
        await Future.delayed(const Duration(milliseconds: 111), () {
          buttonModel.isClicked(false);

          if (callBack == null)
            Functions.openLink(buttonModel.link);
          else
            callBack();
        });
      },
      child: AnimatedContainer(
        height: MediaQuery.of(context).size.height * .20,
        width: MediaQuery.of(context).size.height * .20,
        duration: Duration(milliseconds: 111),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
            color: (mainController.isDark.value) ? Colors.black : Colors.white,
            gradient: (buttonModel.showDetails.value ||
                    buttonModel.isFocused.value)
                ? LinearGradient(colors: mainController.skillsGradientList[0])
                : null,
            borderRadius: BorderRadius.circular(10),
            boxShadow: !buttonModel.isClicked.value
                ? [
                    BoxShadow(
                        color: Colors.grey[500]!,
                        offset: (mainController.isDark.value)
                            ? Offset(2, 2)
                            : Offset(4, 4),
                        blurRadius: mainController.isDark.value ? 5 : 15,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Colors.white,
                        offset: (mainController.isDark.value)
                            ? Offset(-2, -2)
                            : Offset(-4, -4),
                        blurRadius: mainController.isDark.value ? 5 : 15,
                        spreadRadius: 1)
                  ]
                : null),
        padding: EdgeInsets.all((isDesktop) ? 15 : 5),
        child: MouseRegion(
          onEnter: (a) => buttonModel.isFocused.value = true,
          onExit: (a) => buttonModel.isFocused.value = false,
          child: AnimatedContainer(
            curve: Curves.easeIn,
            width: MediaQuery.of(context).size.height * .20,
            height: MediaQuery.of(context).size.height * .20,
            duration: Duration(milliseconds: 111),
            padding: EdgeInsets.all(buttonModel.pad.value),
            child: Column(
              children: [
                buttonModel.showDetails.value
                    ? (mainController.isDark.value)
                        ? buttonModel.image_hovered
                        : buttonModel.image
                    : (mainController.isDark.value)
                        ? buttonModel.image_hovered
                        : buttonModel.image,
                // if(buttonModel.showDetails.value)
                //   Text(buttonModel.image.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }

// coding morph buttons
  static Widget workSocialsMorphButtons(BuildContext context,
      {bool isDesktop = true}) {
    CodingController codingController = Get.find<CodingController>();

    if (codingController.jobSocialsMorphButtons.isNotEmpty)
      return ListView.separated(
        shrinkWrap: true,
        scrollDirection: isDesktop ? Axis.horizontal : Axis.vertical,
        itemCount: codingController.jobSocialsMorphButtons.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => morphButton(context,
                buttonModel: codingController.jobSocialsMorphButtons[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return (isDesktop)
              ? SizedBox(
                  width: 20,
                )
              : SizedBox(
                  height: 20,
                );
        },
      );
    else {
      return SizedBox.shrink();
    }
  }

  // gaming social morph buttons
  static Widget gamingSocialsMorphButtons(BuildContext context,
      {bool isDesktop = true}) {
    GamingController gamingController = Get.find<GamingController>();

    if (gamingController.gamingSocialsMorphButtons.isNotEmpty)
      return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: gamingController.gamingSocialsMorphButtons.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => morphButton(context,
                buttonModel: gamingController.gamingSocialsMorphButtons[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      );
    else {
      return SizedBox.shrink();
    }
  }

  // social morph buttons
  static Widget socialMorphButtons(BuildContext context,
      {bool isDesktop = true}) {
    SocialsController socialsController = Get.find<SocialsController>();

    if (socialsController.socialMorphButtons.isNotEmpty)
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: socialsController.socialMorphButtons.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => morphButton(context,
                buttonModel: socialsController.socialMorphButtons[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      );
    else {
      return SizedBox.shrink();
    }
  }

  // music morph buttons
  static Widget musicMorphButtons(BuildContext context,
      {bool isDesktop = true}) {
    MusicController musicController = Get.find<MusicController>();

    if (musicController.musicMorphButtons.isNotEmpty)
      return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: musicController.musicMorphButtons.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => morphButton(context,
                buttonModel: musicController.musicMorphButtons[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      );
    else {
      return SizedBox.shrink();
    }
  }

  static Widget streamLinkButtons(
    int id,
    String label,
  ) {
    MainController mainController = Get.find<MainController>();
    GamingController gamingController = Get.find<GamingController>();

    return MouseRegion(
      onEnter: (event) {
        switch (id) {
          case 0:
            gamingController.ytHover.value = true;
            break;
          case 1:
            gamingController.twitchHover.value = true;
            break;
          case 2:
            gamingController.discordHover.value = true;
            break;
        }
      },
      onExit: (event) {
        switch (id) {
          case 0:
            gamingController.ytHover.value = false;
            break;
          case 1:
            gamingController.twitchHover.value = false;
            break;
          case 2:
            gamingController.discordHover.value = false;
            break;
        }
      },
      child: Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 111),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: ((id == 0)
                      ? gamingController.ytHover.value
                      : (id == 1)
                          ? gamingController.twitchHover.value
                          : gamingController.discordHover.value)
                  ? LinearGradient(
                      colors: mainController.streamGradientList[id])
                  : null,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: (((id == 0)
                      ? gamingController.ytHover.value
                      : (id == 1)
                          ? gamingController.twitchHover.value
                          : gamingController.discordHover.value))
                  ? [
                      BoxShadow(
                          color: Colors.grey[500]!,
                          offset: Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1)
                    ]
                  : null),
          child: TextButton.icon(
            onPressed: () {
              switch (id) {
                case 0:
                  Functions.openLink('yt');
                  break;
                case 1:
                  Functions.openLink('twitch');
                  break;
                case 2:
                  Functions.openLink('discord');
                  break;
              }
            },
            label: Text('${label}',
                style: ((id == 0)
                        ? gamingController.ytHover.value
                        : (id == 1)
                            ? gamingController.twitchHover.value
                            : gamingController.discordHover.value)
                    ? AppThemeData.appThemeData.textTheme.headlineMedium!
                        .copyWith(
                            color: (mainController.isDark.value)
                                ? Colors.white.withOpacity(0.9)
                                : Colors.white.withOpacity(0.9))
                    : AppThemeData.appThemeData.textTheme.headlineMedium!
                        .copyWith(
                            color: (mainController.isDark.value)
                                ? Colors.white.withOpacity(0.9)
                                : Colors.black.withOpacity(0.9))),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: ((id == 0)
                      ? gamingController.ytHover.value
                      : (id == 1)
                          ? gamingController.twitchHover.value
                          : gamingController.discordHover.value)
                  ? Colors.white.withOpacity(0.9)
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  // pie chart
  static Widget pieChart(BuildContext context,
      {String label = 'frameworks', bool isDesktop = true}) {
    MainController mainController = Get.find<MainController>();
    CodingController codingController = Get.find<CodingController>();

    if (codingController.frameworks.isNotEmpty) {
      List<PieData> dataMap = [];
      for (var e in codingController.frameworks) {
        dataMap.add(PieData(
            value: e.value, color: Color(int.parse('0xff' + e.hexValue))));
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Obx(
          () => Row(
            children: [
              SizedBox(
                width: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: codingController.frameworks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.circle,
                          color: dataMap[index].color,
                          size: 10,
                        ),
                        Text(
                          codingController.frameworks[index].label,
                          style: AppThemeData.appThemeData.textTheme.bodySmall!,
                        ),
                      ],
                    );
                  },
                ),
              ),
              EasyPieChart(
                showValue: false,
                key: Key(label),
                children: dataMap,
                borderEdge: StrokeCap.square,
                shouldAnimate: false,
                pieType: PieType.fill,
                onTap: (index) async {
                  codingController
                      .frameworkIndex(index); // set selected framework index

                  await codingController.getFrameworkWiseProjects(
                      frameworkId: codingController.frameworks[index]
                          .label); // get projects for selected framework

                  mainController.codingController.animateToPage(1,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                },
                style: AppThemeData.appThemeData.textTheme.bodySmall!
                    .copyWith(color: Colors.white),
                gap: 0,
                borderWidth: 10,
                start: 0,
                size: (isDesktop) ? 240 : 130,
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
