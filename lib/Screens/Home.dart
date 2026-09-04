import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/CodingController.dart';
import 'package:my_porfolio/Controllers/GamingController.dart';
import 'package:my_porfolio/Controllers/MusicController.dart';
import 'package:my_porfolio/Controllers/ProjectsController.dart';
import 'package:my_porfolio/Controllers/SocialsController.dart';
import 'package:my_porfolio/Screens/Desktop/CodingScreen.dart';
import 'package:my_porfolio/Screens/Desktop/FooterSection.dart';
import 'package:my_porfolio/Screens/Desktop/InfoScreen.dart';
import 'package:my_porfolio/Screens/InfoScreen.dart';
import 'package:my_porfolio/Utils/AppThemeData.dart';
import 'package:my_porfolio/Utils/UiUtils.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../Controllers/MainController.dart';
import '../Utils/Constants.dart';
import '../Utils/FloatingNavBar.dart';
import '../Utils/FunctionUtils.dart';
import 'Desktop/ExperienceScreen.dart';
import 'Desktop/ProjectsScreen.dart';

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

    mainController.globalMouseRegion.value = details.position;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizingInformation) {
      return Obx(
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
                  : Container(
                      decoration: BoxDecoration(
                          image: (sizingInformation.deviceScreenType ==
                                  DeviceScreenType.desktop)
                              ? DecorationImage(
                                  filterQuality: FilterQuality.low,
                                  opacity: 0.2,
                                  fit: BoxFit.cover,
                                  image: AssetImage(ImageConstants.imagesPath +
                                      "${(mainController.isDark.value) ? 'patterns_dark.jpeg' : 'patterns.jpg'}"))
                              : null),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          CustomPaint(
                            painter: ShadowPainter(
                                mainController.globalMouseRegion.value,
                                mainController.isDark.value),
                            size: Size.infinite,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                (sizingInformation.deviceScreenType ==
                                        DeviceScreenType.desktop)
                                    // desktop view
                                    ? Expanded(
                                        child: MouseRegion(
                                          onHover: _updateLocation,
                                          child: PageView(
                                            scrollDirection: Axis.vertical,
                                            pageSnapping: false,
                                            children: [
                                              InfoScreen(),
                                              CodingScreen(
                                                isDesktop: sizingInformation
                                                        .deviceScreenType ==
                                                    DeviceScreenType.desktop,
                                              ),
                                              ExperienceScreen(
                                                isDesktop: sizingInformation
                                                        .deviceScreenType ==
                                                    DeviceScreenType.desktop,
                                              ),
                                              ProjectsScreen(
                                                isDesktop: sizingInformation
                                                        .deviceScreenType ==
                                                    DeviceScreenType.desktop,
                                              ),
                                              FooterSection(
                                                isDesktop: sizingInformation
                                                        .deviceScreenType ==
                                                    DeviceScreenType.desktop,
                                              ),
                                            ],
                                            controller:
                                                mainController.pageController,
                                          ),
                                        ),
                                      )

                                    // mobile view
                                    : Expanded(
                                        child: PageView(children: [
                                          MobileInfoScreen(),
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
                    ),
          floatingActionButton:
              (sizingInformation.deviceScreenType != DeviceScreenType.desktop)
                  ? Widgets.scrollButton()
                  : null,
        ),
      );
    });
  }
}
