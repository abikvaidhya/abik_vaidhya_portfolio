import 'dart:ui';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Utils/Constants.dart';
import 'package:my_porfolio/Utils/UiUtils.dart';
import 'package:simple_shadow/simple_shadow.dart';
import '../Controllers/MainController.dart';
import 'FunctionUtils.dart';

class FloatingNavBarDesktop extends StatelessWidget {
  const FloatingNavBarDesktop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();

    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MouseRegion(
            onEnter: (event) => mainController.navHovered.value = 1,
            onExit: (event) => mainController.navHovered.value = 0,
            child: Obx(
              () => AnimatedContainer(
                padding: EdgeInsets.symmetric(
                    horizontal: mainController.navHovered.value == 1 ? 44 : 22),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300.withOpacity(
                      mainController.navHovered.value == 1 ? 0.3 : 0.1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24.0),
                    //   bottomRight: Radius.circular(24.0),
                    topLeft: Radius.circular(24.0),
                    //   bottomLeft: Radius.circular(24.0),
                  ),

                  // borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                // margin: EdgeInsets.only(bottom: 20),
                height: mainController.navHovered.value == 1 ? 70 : 50,
                duration: Duration(milliseconds: Constants.animationDuration),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: mainController.infos.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return FloatingNavBarIcons(
                      hoverID: mainController.infos[index].id.value,
                      iconData: IconData(
                          mainController.infos[index].iconCodePoint.value,
                          fontFamily: 'MaterialIcons'),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingNavBarIcons extends StatelessWidget {
  const FloatingNavBarIcons({
    Key? key,
    required this.hoverID,
    required this.iconData,
  }) : super(key: key);

  final int hoverID;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();

    return Obx(
      () => AnimatedPadding(
        padding: EdgeInsets.symmetric(
            horizontal: (mainController.navHovered.value == 1) ? 20 : 0.0,
            vertical: (mainController.navHovered.value == 1) ? 10 : 0.0),
        duration: Duration(milliseconds: Constants.animationDuration),
        child: MouseRegion(
          onEnter: (a) {
            mainController.navIconID.value = hoverID;
          },
          onExit: (a) {
            mainController.navIconID.value = 0;
          },
          child: AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              duration:
                  const Duration(milliseconds: Constants.animationDuration),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: (mainController.navIconID.value == hoverID)
                  ? Widgets.customShadowBox(
                      GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Icon(
                              iconData,
                              color: mainController.isDark.value
                                  ? Colors.white70
                                  : Colors.black87,
                              size: 24,
                            ),
                          ),
                          onTap: () => Functions.navigate(
                              mainController.navIconID.value,
                              mainController.pageController)),
                    )
                  : IconButton(
                      icon: Widgets.bulletineIcon(true,
                          iconColor: mainController.isDark.value
                              ? Colors.white54
                              : Colors.black45),
                      iconSize: mainController.navHovered == 1 ? 8 : 5,
                      onPressed: () => Functions.navigate(
                          mainController.navIconID.value,
                          mainController.pageController))
              //  Obx(() => SimpleShadow(
              //     opacity: mainController.navHovered.value == 1 ? 0.5 : 0,
              //     child: iconWidget(mainController.navIconID.value))),
              ),
        ),
      ),
    );
  }

  Widget iconWidget(int navID) {
    MainController mainController = Get.find<MainController>();

    return (navID == hoverID)
        ? GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Icon(
                iconData,
                color: mainController.isDark.value
                    ? Colors.white70
                    : Colors.black87,
                size: 24,
              ),
            ),
            onTap: () =>
                Functions.navigate(navID, mainController.pageController))
        : IconButton(
            icon: Widgets.bulletineIcon(true,
                iconColor: mainController.isDark.value
                    ? Colors.white54
                    : Colors.black45),
            iconSize: mainController.navHovered == 1 ? 8 : 5,
            onPressed: () =>
                Functions.navigate(navID, mainController.pageController));
  }
}
