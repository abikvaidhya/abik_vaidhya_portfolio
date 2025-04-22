import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/CodingController.dart';
import 'package:my_porfolio/Controllers/GamingController.dart';
import 'package:my_porfolio/Controllers/MusicController.dart';
import 'package:my_porfolio/Controllers/ProjectsController.dart';
import 'package:my_porfolio/Controllers/SocialsController.dart';
import 'package:my_porfolio/Screens/CodingScreen.dart';
import 'package:my_porfolio/Screens/Desktop/CodingScreen.dart';
import 'package:my_porfolio/Screens/Desktop/GamingScreen.dart';
import 'package:my_porfolio/Screens/Desktop/InfoScreen.dart';
import 'package:my_porfolio/Screens/Desktop/MusicScreen.dart';
import 'package:my_porfolio/Screens/Desktop/SocialScreen.dart';
import 'package:my_porfolio/Screens/InfoScreen.dart';
import 'package:my_porfolio/Utils/AppThemeData.dart';
import 'package:my_porfolio/Utils/UiUtils.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../Controllers/MainController.dart';
import '../Utils/FloatingNavBar.dart';
import '../Utils/FunctionUtils.dart';

class HomeContainer extends StatefulWidget {
  HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  final MainController mainController = Get.find<MainController>();
  final CodingController codingController = Get.find<CodingController>();
  final GamingController gamingController = Get.find<GamingController>();
  final MusicController musicController = Get.find<MusicController>();
  final ProjectsController projectsController = Get.find<ProjectsController>();
  final SocialsController socialsController = Get.find<SocialsController>();

  double bg = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Functions.precacheImages(context); // pre-load images
  }

// fetches mouse pointer location
  void _updateLocation(PointerEvent details) {
    mainController.cursorX.value = details.position.dx;
    mainController.cursorY.value = details.position.dy;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizingInformation) {
      return SafeArea(
        child: Obx(
          () => Scaffold(
            backgroundColor:
                (mainController.isDark.value) ? Colors.black : Colors.white,
            body: mainController.gettingStatus.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: mainController.isDark.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                : (!mainController.statusmodel.live)
                    ? Widgets.customShadowBox(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Icon(Icons.error,
                              size: 30,
                              color: mainController.isDark.value
                                  ? Colors.white
                                  : Colors.black),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'site is currently being updated, please check back again later.\nsorry for the inconvience',
                                style: AppThemeData
                                    .appThemeData.textTheme.displayMedium!
                                    .copyWith(
                                        color: mainController.isDark.value
                                            ? Colors.white
                                            : Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ))
                    : Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Row(
                              children: [
                                (sizingInformation.deviceScreenType ==
                                        DeviceScreenType.desktop)
                                    ? Expanded(
                                        child: MouseRegion(
                                          onHover: _updateLocation,
                                          child: NotificationListener<
                                              UserScrollNotification>(
                                            onNotification: (notification) {
                                              if (notification.direction ==
                                                      ScrollDirection.forward &&
                                                  sizingInformation
                                                          .deviceScreenType !=
                                                      DeviceScreenType
                                                          .desktop &&
                                                  (mainController.pageController
                                                              .page !=
                                                          null &&
                                                      mainController
                                                              .pageController
                                                              .page!
                                                              .round() >
                                                          0)) {
                                                mainController.scrollBtn.value =
                                                    1.0;
                                              }
                                              return false;
                                            },
                                            child: SingleChildScrollView(
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: PageView(
                                                  onPageChanged: (value) {
                                                    if (mainController
                                                                .codingIndex
                                                                .value >
                                                            0 &&
                                                        sizingInformation
                                                                .deviceScreenType ==
                                                            DeviceScreenType
                                                                .desktop) {
                                                      Functions.navigate(
                                                        mainController
                                                                .codingIndex
                                                                .value +
                                                            1,
                                                        mainController
                                                            .codingController,
                                                      );
                                                    }

                                                    if (mainController
                                                                .gamingIndex
                                                                .value >
                                                            0 &&
                                                        sizingInformation
                                                                .deviceScreenType ==
                                                            DeviceScreenType
                                                                .desktop) {
                                                      Functions.navigate(
                                                        mainController
                                                                .gamingIndex
                                                                .value +
                                                            1,
                                                        mainController
                                                            .streamController,
                                                      );
                                                    }
                                                  },
                                                  // physics:
                                                  // sizingInformation.deviceScreenType ==
                                                  //         DeviceScreenType.mobile
                                                  //     ? ClampingScrollPhysics()
                                                  //     : NeverScrollableScrollPhysics(),
                                                  // allowImplicitScrolling:
                                                  //     sizingInformation.deviceScreenType ==
                                                  //             DeviceScreenType.desktop
                                                  //         ? true
                                                  //         : false,
                                                  pageSnapping: sizingInformation
                                                              .deviceScreenType ==
                                                          DeviceScreenType
                                                              .mobile
                                                      ? true
                                                      : false,
                                                  scrollDirection: sizingInformation
                                                              .deviceScreenType ==
                                                          DeviceScreenType
                                                              .desktop
                                                      ? Axis.vertical
                                                      : Axis.vertical,
                                                  children: [
                                                    InfoScreen(),
                                                    Widgets.CodingIntroDetails(
                                                      context: context,
                                                      isDesktop: sizingInformation
                                                              .deviceScreenType ==
                                                          DeviceScreenType
                                                              .desktop,
                                                    ),
                                                    Widgets.ExperienceDetails(
                                                      isDesktop: sizingInformation
                                                              .deviceScreenType ==
                                                          DeviceScreenType
                                                              .desktop,
                                                    ),
                                                    Widgets.projectDetails(
                                                      isDesktop: sizingInformation
                                                              .deviceScreenType ==
                                                          DeviceScreenType
                                                              .desktop,
                                                    ),
                                                    // Widgets.projectDetails(
                                                    //   isDesktop: sizingInformation
                                                    //           .deviceScreenType ==
                                                    //       DeviceScreenType.desktop,
                                                    // ),
                                                    //   GamingScreen(
                                                    //       isDesktop: sizingInformation
                                                    //               .deviceScreenType ==
                                                    //           DeviceScreenType.desktop),
                                                    //   MusicScreen(
                                                    //     isDesktop: sizingInformation
                                                    //             .deviceScreenType ==
                                                    //         DeviceScreenType.desktop,
                                                    //   ),
                                                    //   SocialScreen(
                                                    //     isDesktop: sizingInformation
                                                    //             .deviceScreenType ==
                                                    //         DeviceScreenType.desktop,
                                                    //   ),
                                                    Widgets.footer(
                                                      isDesktop: sizingInformation
                                                              .deviceScreenType ==
                                                          DeviceScreenType
                                                              .desktop,
                                                    ),
                                                  ],
                                                  controller: mainController
                                                      .pageController,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                        child: PageView(children: [
                                          MobileInfoScreen(),
                                          MobileCodingScreen(),
                                        ]),
                                      ),
                              ],
                            ),
                          ),

                          // dark-light theme toggle
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 10),
                                child: GestureDetector(
                                  onTap: () => mainController.saveDarkModeState(
                                      state: !mainController.isDark.value),
                                  child: Widgets.hoveredShadow(
                                    Icon(
                                        (mainController.isDark.value)
                                            ? Icons.light_mode
                                            : Icons.dark_mode,
                                        color: mainController.isDark.value
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // floating nav bar
                          if (sizingInformation.deviceScreenType ==
                              DeviceScreenType.desktop)
                            FloatingNavBarDesktop(),
                        ],
                      ),
            floatingActionButton:
                (sizingInformation.deviceScreenType != DeviceScreenType.desktop)
                    ? Widgets.scrollButton()
                    : null,
          ),
        ),
      );
    });
  }
}
