import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/MainController.dart';
import '../../Controllers/ProjectsController.dart';
import '../../Utils/AppThemeData.dart';
import '../../Utils/Constants.dart';
import '../../Utils/UiUtils.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({key, required this.isDesktop});

  final bool isDesktop;

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  MainController mainController = Get.find<MainController>();
  ProjectsController projectsController = Get.find<ProjectsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(20.0),
      child: Column(
        spacing: 20,
        children: [
          // title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Widgets.customShadowBox(
                Text(
                  'my works',
                  style: AppThemeData.appThemeData.textTheme.headlineMedium!
                      .copyWith(
                          color: mainController.isDark.value
                              ? Colors.white
                              : Colors.black),
                ),
              ),
              // if (projectsController.projectScreenShots.isEmpty)
              //   SizedBox(
              //     width: 300,
              //   )
            ],
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // company selection
                AnimatedContainer(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: 400,
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
                  padding: EdgeInsets.all(20),
                  duration: Duration(milliseconds: Constants.animationDuration),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Center(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount:
                                projectsController.launchedProjects.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    projectsController
                                        .launchedProjectIndex(index);
                                    projectsController.getProjectScreenShots(
                                        id: projectsController
                                            .launchedProjects[index].id.value);
                                  },
                                  child: Obx(
                                    () => Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            projectsController
                                                .launchedProjects[index]
                                                .label
                                                .value,
                                            style: AppThemeData.appThemeData
                                                .textTheme.bodyMedium!
                                                .copyWith(
                                              fontWeight: index ==
                                                      (projectsController
                                                          .launchedProjectIndex
                                                          .value)
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: mainController.isDark.value
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          index ==
                                                  (projectsController
                                                      .launchedProjectIndex
                                                      .value)
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off,
                                          color: mainController.isDark.value
                                              ? Colors.white
                                              : Colors.black,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  VerticalDivider(
                                    endIndent: 5,
                                    indent: 5,
                                    color: mainController.isDark.value
                                        ? Colors.white54
                                        : Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // experience detail section
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
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => Widgets.projectDetail(
                            project: projectsController.launchedProjects[
                                projectsController
                                    .launchedProjectIndex.value])),
                      ),
                    ],
                  ),
                ),

                // screenshot
                AnimatedContainer(
                  width: (projectsController.projectScreenShots.isEmpty)
                      ? 40
                      : 400,
                  height: MediaQuery.of(context).size.height * 0.6,
                  duration: Duration(milliseconds: Constants.animationDuration),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(
                          () => Widgets.customShadowBox((projectsController
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
                                      ? Spacer()
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
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
                                                builder:
                                                    (BuildContext context) {
                                                  return CachedNetworkImage(
                                                    width: 400,
                                                    fit: BoxFit.cover,
                                                    imageUrl: i.link.value,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Icon(
                                                            Icons.error_outline,
                                                            color:
                                                                mainController
                                                                        .isDark
                                                                        .value
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
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
          ),
        ],
      ),
    );
  }
}
