import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
            (mainController.isDark.value) ? 0.6 : 0.8;
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
                    fontWeight: FontWeight.bold,
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

  static Widget customShadowBox(
    Widget child, {
    double opacity = 0.6,
    double sigma = 4,
  }) {
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

  static Widget hoveredShadow(Widget child, {bool hoverEffect = true}) {
    MainController mainController = Get.find<MainController>();
    RxBool hovered = (false).obs;

    return Obx(
      () => MouseRegion(
        onEnter: (_) {
          if (hoverEffect) hovered(true);
        },
        onExit: (_) {
          if (hoverEffect) hovered(false);
        },
        child: AnimatedContainer(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: (hovered.value && hoverEffect || !hoverEffect)
                  ? [
                      BoxShadow(
                          color: mainController.isDark.value
                              ? const Color.fromARGB(255, 94, 94, 94)
                              : Colors.grey[500]!,
                          offset: (mainController.isDark.value)
                              ? Offset(2, 4)
                              : Offset(8, 6),
                          blurRadius: mainController.isDark.value ? 5 : 10,
                          spreadRadius: 1),
                      BoxShadow(
                          color: mainController.isDark.value
                              ? const Color.fromARGB(255, 82, 82, 82)
                              : Colors.white,
                          offset: (mainController.isDark.value)
                              ? Offset(-2, 8)
                              : Offset(8, 6),
                          blurRadius: mainController.isDark.value ? 5 : 10,
                          spreadRadius: 1)
                    ]
                  : null),
          duration: Duration(milliseconds: 111),
          child: child,
        ),
      ),
    );
  }

// coding
  static Widget CodingIntroDetails(
      {required BuildContext context, required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    CodingController codingController = Get.find<CodingController>();

    return Padding(
      padding: EdgeInsets.all((isDesktop) ? 44.0 : 20.0),
      child: (mainController.infos.isEmpty)
          ? SizedBox.shrink()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 60,
              children: [
                Column(
                  spacing: 20,
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
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // pie chart
                      Widgets.pieChart(context,
                          isDesktop: isDesktop, label: 'frameworks'),

                      // morph buttons
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          Obx(
                            () => morphButton(context, callBack: () {
                              Functions.navigate(
                                  3, mainController.codingController);
                            },
                                buttonModel:
                                    codingController.experienceButton.value),
                          ),
                          Obx(
                            () => morphButton(context, callBack: () {
                              Functions.navigate(
                                  4, mainController.codingController);
                            },
                                buttonModel:
                                    codingController.projectButton.value),
                          ),
                          Obx(
                            () => morphButton(context, callBack: () {
                              Functions.navigate(
                                  5, mainController.codingController);
                            },
                                buttonModel:
                                    codingController.reviewsButtons.value),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Widgets.workSocialsMorphButtons(context,
                            isDesktop: isDesktop),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  static Widget FrameworksDetails({required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    CodingController codingController = Get.find<CodingController>();

    return Obx(
      () => (codingController.frameworks.isNotEmpty &&
              codingController.frameworkIndex.value > -1)
          ? Padding(
              padding: const EdgeInsets.all(44.0),
              child: Column(
                spacing: 20,
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
                  Row(
                    children: [
                      Widgets.customShadowBox(
                        Text(
                          codingController
                              .frameworks[codingController.frameworkIndex.value]
                              .description,
                          maxLines: 5,
                          style: AppThemeData.appThemeData.textTheme.bodyMedium!
                              .copyWith(
                                  color: mainController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: codingController.frameworkProjects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Widgets.customShadowBox(
                        Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 20,
                              children: [
                                Text(
                                  '> ' +
                                      codingController
                                          .frameworkProjects[index].label,
                                  style: AppThemeData
                                      .appThemeData.textTheme.bodyMedium!
                                      .copyWith(
                                          color: mainController.isDark.value
                                              ? Colors.white
                                              : Colors.black),
                                  softWrap: true,
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
          : SizedBox.shrink(),
    );
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
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets.customShadowBox(
                        Text(
                          'experiences',
                          style: AppThemeData
                              .appThemeData.textTheme.headlineMedium!
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          codingController
                                              .experiences[experiencesIndex]
                                              .name
                                              .value,
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
                                              .textTheme.bodyMedium!
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
                                              child: Text(
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
                                          child: Text(
                                            '- ' +
                                                codingController
                                                        .experiences[
                                                            experiencesIndex]
                                                        .responsibilities[
                                                    responsibilitiesIndex],
                                            maxLines: 2,
                                            style: AppThemeData.appThemeData
                                                .textTheme.bodyMedium!
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
                                      () => customShadowBox(
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
                                                //   fontSize: (index ==
                                                //           (codingController
                                                //               .experienceIndex.value))
                                                //       ? 20
                                                //       : 16,
                                                color:
                                                    mainController.isDark.value
                                                        ? Colors.white
                                                        : Colors.black,
                                              )),
                                          opacity: codingController
                                                      .experienceIndex.value ==
                                                  index
                                              ? 0.6
                                              : 0.2),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 10,
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

  static Widget reviews({required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    CodingController codingController = Get.find<CodingController>();

    return Padding(
      padding: EdgeInsets.all(44.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Widgets.customShadowBox(
                      Text(
                        'reviews',
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
                Center(
                  child: SizedBox(
                    height: 450,
                    child: CarouselSlider.builder(
                      itemCount: codingController.reviews.length,
                      options: CarouselOptions(
                          viewportFraction: 0.9,
                          autoPlay: true,
                          autoPlayInterval: Duration(
                            seconds: 7,
                          )),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Obx(
                          () => AnimatedContainer(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[500]!,
                                    offset: (mainController.isDark.value)
                                        ? Offset(2, 2)
                                        : Offset(4, 4),
                                    blurRadius:
                                        mainController.isDark.value ? 5 : 15,
                                    spreadRadius: 1),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: (mainController.isDark.value)
                                        ? Offset(-2, -2)
                                        : Offset(-4, -4),
                                    blurRadius:
                                        mainController.isDark.value ? 5 : 15,
                                    spreadRadius: 1)
                              ],
                              color: (mainController.isDark.value)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            duration: Duration(milliseconds: 111),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    spacing: 10,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      customShadowBox(
                                        CircleAvatar(
                                          radius: 60,
                                          backgroundImage: NetworkImage(
                                              codingController
                                                  .reviews[index].image.value),
                                          onBackgroundImageError:
                                              (exception, stackTrace) =>
                                                  Icon(Icons.person),
                                        ),
                                      ),
                                      customShadowBox(
                                        Text(
                                            codingController
                                                .reviews[index].name.value,
                                            style: AppThemeData.appThemeData
                                                .textTheme.displayMedium!
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: mainController.isDark.value
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                      ),
                                      customShadowBox(
                                        Text(
                                            codingController
                                                .reviews[index].company.value,
                                            style: AppThemeData.appThemeData
                                                .textTheme.bodyMedium!
                                                .copyWith(
                                              color: mainController.isDark.value
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                      ),
                                      customShadowBox(
                                        Text(
                                            codingController
                                                .reviews[index].review.value,
                                            maxLines: 5,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppThemeData.appThemeData
                                                .textTheme.bodyMedium!
                                                .copyWith(
                                              color: mainController.isDark.value
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget projectDetails({required bool isDesktop}) {
    MainController mainController = Get.find<MainController>();
    ProjectsController projectsController = Get.find<ProjectsController>();

    return Padding(
      padding: EdgeInsets.all(44.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Widgets.customShadowBox(
                      Text(
                        'projects',
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
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // company selection
                      AnimatedContainer(
                        width: 250,
                        duration: Duration(milliseconds: 111),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount:
                              projectsController.launched_projects.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                // Functions.navigate(
                                //     index - 1, mainController.projectController,
                                //     isMain: false);
                                projectsController.launchedProjectIndex(index);
                                projectsController.getProjectScreenShots(
                                    id: projectsController
                                        .launched_projects[index].id.value);
                              },
                              child: Obx(
                                () => customShadowBox(
                                    Text(
                                        projectsController
                                            .launched_projects[index]
                                            .label
                                            .value,
                                        style: AppThemeData
                                            .appThemeData.textTheme.bodyMedium!
                                            .copyWith(
                                          fontWeight: index ==
                                                  (projectsController
                                                      .launchedProjectIndex
                                                      .value)
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          // fontSize: (index ==
                                          //         (projectsController
                                          //             .launchedProjectIndex
                                          //             .value))
                                          //     ? 20
                                          //     : 16,
                                          color: mainController.isDark.value
                                              ? Colors.white
                                              : Colors.black,
                                        )),
                                    opacity: projectsController
                                                .launchedProjectIndex.value ==
                                            index
                                        ? 0.6
                                        : 0.2),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10,
                              child: Row(
                                children: [
                                  VerticalDivider(
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

                      // experience detail
                      Expanded(
                        child: customShadowBox(
                          Obx(() => projectDetail(
                              project: projectsController.launched_projects[
                                  projectsController
                                      .launchedProjectIndex.value])),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // screenshot
          AnimatedContainer(
            margin: EdgeInsets.only(left: 20),
            width: !projectsController.gettingScreenShots.value &&
                    projectsController.projectScreenShots.isEmpty
                ? 50
                : 320,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            duration: Duration(milliseconds: 111),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(
                    () => customShadowBox((projectsController
                            .gettingScreenShots.value)
                        ? Center(
                            child: CircularProgressIndicator(
                              color: mainController.isDark.value
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )
                        : Center(
                            child: (projectsController
                                    .projectScreenShots.isEmpty)
                                ? RotatedBox(
                                    quarterTurns: -1,
                                    child: Text(
                                        'Sorry, no screenshots available...',
                                        style: AppThemeData
                                            .appThemeData.textTheme.bodySmall!
                                            .copyWith(
                                                color:
                                                    mainController.isDark.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                          autoPlay: true,
                                          autoPlayInterval:
                                              Duration(seconds: 5),
                                          viewportFraction: 1,
                                          height: double.maxFinite),
                                      items: projectsController
                                          .projectScreenShots
                                          .map((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return CachedNetworkImage(
                                              width: 300,
                                              fit: BoxFit.cover,
                                              imageUrl: i.link.value,
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                      Icons.error_outline,
                                                      color: mainController
                                                              .isDark.value
                                                          ? Colors.white
                                                          : Colors.black),
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      LinearProgressIndicator(
                                                value: progress.progress,
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                          )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget projectDetail(
      {required ProjectModel project, bool isDesktop = false}) {
    MainController mainController = Get.find<MainController>();

    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 20,
          children: [
            Text(
              project.label.value,
              style: AppThemeData.appThemeData.textTheme.displayLarge!.copyWith(
                color:
                    mainController.isDark.value ? Colors.white : Colors.black,
              ),
            ),
            if (project.link.isNotEmpty)
              GestureDetector(
                onTap: () => Functions.openLink(project.link.value),
                child: Icon(Icons.android_rounded,
                    color: mainController.isDark.value
                        ? Colors.white
                        : Colors.black),
              ),
            if (project.ios_link.isNotEmpty)
              GestureDetector(
                onTap: () => Functions.openLink(project.ios_link.value),
                child: Icon(Icons.apple_rounded,
                    color: mainController.isDark.value
                        ? Colors.white
                        : Colors.black),
              ),
            if (project.site.isNotEmpty)
              GestureDetector(
                onTap: () => Functions.openLink(project.site.value),
                child: Icon(Icons.link_rounded,
                    color: mainController.isDark.value
                        ? Colors.white
                        : Colors.black),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                project.description.value,
                softWrap: true,
                textAlign: TextAlign.end,
                style: AppThemeData.appThemeData.textTheme.bodySmall!.copyWith(
                  color:
                      mainController.isDark.value ? Colors.white : Colors.black,
                ),
                maxLines: 5,
              ),
            )
          ],
        ),
        if (project.detail.trim().isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  project.detail.value,
                  textAlign: TextAlign.end,
                  softWrap: true,
                  style:
                      AppThemeData.appThemeData.textTheme.bodyMedium!.copyWith(
                    color: mainController.isDark.value
                        ? Colors.white
                        : Colors.black,
                  ),
                  maxLines: 5,
                ),
              )
            ],
          ),
        Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'developed using:',
              style: AppThemeData.appThemeData.textTheme.bodyMedium!.copyWith(
                color:
                    mainController.isDark.value ? Colors.white : Colors.black,
              ),
            ),
            Text(
              project.devLang.value,
              style: AppThemeData.appThemeData.textTheme.bodyMedium!.copyWith(
                color:
                    mainController.isDark.value ? Colors.white : Colors.black,
              ),
            )
          ],
        ),
        Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'platforms:',
              style: AppThemeData.appThemeData.textTheme.bodyMedium!.copyWith(
                color:
                    mainController.isDark.value ? Colors.white : Colors.black,
              ),
            ),
            Text(
              project.platform
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', ''),
              style: AppThemeData.appThemeData.textTheme.bodyMedium!.copyWith(
                color:
                    mainController.isDark.value ? Colors.white : Colors.black,
              ),
            )
          ],
        )
      ],
    );
  }

  // morph button
  static Widget morphButton(
    BuildContext context, {
    required MorphButton buttonModel,
    bool isDesktop = true,
    VoidCallback? callBack,
  }) {
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
            gradient:
                (buttonModel.showDetails.value || buttonModel.isFocused.value)
                    ? LinearGradient(
                        colors: mainController
                            .morphButtonGradients[buttonModel.gradientId.value])
                    : null,
            borderRadius: BorderRadius.circular(10),
            boxShadow:
                !buttonModel.isClicked.value && buttonModel.isFocused.value
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
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.height * .15,
                height: MediaQuery.of(context).size.height * .15,
                padding: EdgeInsets.all(buttonModel.pad.value - 20),
                child: (mainController.isDark.value)
                    ? buttonModel.image_hovered
                    : buttonModel.image,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() => AnimatedOpacity(
                      duration: Duration(milliseconds: 111),
                      opacity: buttonModel.isFocused.value ? 1 : 0,
                      child: Text(
                        buttonModel.label.value,
                        style: AppThemeData.appThemeData.textTheme.bodySmall!
                            .copyWith(
                                color: mainController.isDark.value
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

// coding morph buttons
  static Widget workSocialsMorphButtons(BuildContext context,
      {bool isDesktop = true}) {
    CodingController codingController = Get.find<CodingController>();

    return (codingController.jobSocialsMorphButtons.isNotEmpty)
        ? Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: codingController.jobSocialsMorphButtons
                .map((i) => Obx(
                      () => morphButton(context, buttonModel: i),
                    ))
                .toList(),
          )
        :
        //    ListView.builder(
        //     shrinkWrap: true,
        //     scrollDirection: isDesktop ? Axis.horizontal : Axis.vertical,
        //     itemCount: codingController.jobSocialsMorphButtons.length,
        //     itemBuilder: (BuildContext context, int index) {
        //   return Obx(
        //     () => morphButton(context,
        //         buttonModel: codingController.jobSocialsMorphButtons[index]),
        //   );
        //     },
        //   )

        SizedBox.shrink();
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

//   static Widget streamLinkButtons(
//     int id,
//     String label,
//   ) {
//     MainController mainController = Get.find<MainController>();
//     GamingController gamingController = Get.find<GamingController>();

//     return MouseRegion(
//       onEnter: (event) {
//         switch (id) {
//           case 0:
//             gamingController.ytHover.value = true;
//             break;
//           case 1:
//             gamingController.twitchHover.value = true;
//             break;
//           case 2:
//             gamingController.discordHover.value = true;
//             break;
//         }
//       },
//       onExit: (event) {
//         switch (id) {
//           case 0:
//             gamingController.ytHover.value = false;
//             break;
//           case 1:
//             gamingController.twitchHover.value = false;
//             break;
//           case 2:
//             gamingController.discordHover.value = false;
//             break;
//         }
//       },
//       child: Obx(
//         () => AnimatedContainer(
//           duration: Duration(milliseconds: 111),
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//               gradient: ((id == 0)
//                       ? gamingController.ytHover.value
//                       : (id == 1)
//                           ? gamingController.twitchHover.value
//                           : gamingController.discordHover.value)
//                   ? LinearGradient(
//                       colors: mainController.morphButtonGradients[id])
//                   : null,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               boxShadow: (((id == 0)
//                       ? gamingController.ytHover.value
//                       : (id == 1)
//                           ? gamingController.twitchHover.value
//                           : gamingController.discordHover.value))
//                   ? [
//                       BoxShadow(
//                           color: Colors.grey[500]!,
//                           offset: Offset(4, 4),
//                           blurRadius: 15,
//                           spreadRadius: 1),
//                       BoxShadow(
//                           color: Colors.white,
//                           offset: Offset(-4, -4),
//                           blurRadius: 15,
//                           spreadRadius: 1)
//                     ]
//                   : null),
//           child: TextButton.icon(
//             onPressed: () {
//               switch (id) {
//                 case 0:
//                   Functions.openLink('yt');
//                   break;
//                 case 1:
//                   Functions.openLink('twitch');
//                   break;
//                 case 2:
//                   Functions.openLink('discord');
//                   break;
//               }
//             },
//             label: Text('${label}',
//                 style: ((id == 0)
//                         ? gamingController.ytHover.value
//                         : (id == 1)
//                             ? gamingController.twitchHover.value
//                             : gamingController.discordHover.value)
//                     ? AppThemeData.appThemeData.textTheme.headlineMedium!
//                         .copyWith(
//                             color: (mainController.isDark.value)
//                                 ? Colors.white.withOpacity(0.9)
//                                 : Colors.white.withOpacity(0.9))
//                     : AppThemeData.appThemeData.textTheme.headlineMedium!
//                         .copyWith(
//                             color: (mainController.isDark.value)
//                                 ? Colors.white.withOpacity(0.9)
//                                 : Colors.black.withOpacity(0.9))),
//             icon: Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: ((id == 0)
//                       ? gamingController.ytHover.value
//                       : (id == 1)
//                           ? gamingController.twitchHover.value
//                           : gamingController.discordHover.value)
//                   ? Colors.white.withOpacity(0.9)
//                   : Colors.transparent,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

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
                width: 120,
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
                          style: AppThemeData.appThemeData.textTheme.bodySmall!
                              .copyWith(
                                  color: mainController.isDark.value
                                      ? Colors.white
                                      : Colors.black),
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
                shouldAnimate: false,
                pieType: PieType.fill,
                onTap: (index) async {
                  codingController
                      .frameworkIndex(index); // set selected framework index

                  codingController.getFrameworkWiseProjects(
                      frameworkId: codingController.frameworks[index]
                          .label); // get projects for selected framework

                  mainController.codingController.animateToPage(1,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                },
                style: AppThemeData.appThemeData.textTheme.bodySmall!
                    .copyWith(color: Colors.white),
                gap: 0,
                borderWidth: 0,
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
