
import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/CodingController.dart';
import 'package:my_porfolio/Controllers/GamingController.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import 'package:my_porfolio/Controllers/MusicController.dart';
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
      backgroundColor: Colors.grey.shade700.withValues(alpha: 0.6),
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
            duration: Duration(milliseconds: Constants.animationDuration),
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
          duration: Duration(milliseconds: Constants.animationDuration),
          child: child,
        ),
      ),
    );
  }


  // project details
  static Widget projectDetail(
      {required ProjectModel project, bool isDesktop = false}) {
    MainController mainController = Get.find<MainController>();

    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
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
          children: [
            Expanded(
              child: Text(
                project.description.value,
                softWrap: true,
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
            children: [
              Expanded(
                child: Text(
                  project.detail.value,
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
          children: [
            Chip(
                backgroundColor: (mainController.isDark.value)
                    ? Colors.grey.shade900
                    : Colors.grey.shade100,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 5),
                label: Text(
                  project.devLang.value,
                  style:
                      AppThemeData.appThemeData.textTheme.bodySmall!.copyWith(
                    color: mainController.isDark.value
                        ? Colors.white
                        : Colors.black,
                  ),
                ))
          ],
        ),
        Row(
          spacing: 20,
          children: [
            SizedBox(
              height: 80,
              child: ListView.separated(
                itemCount: project.platform.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Chip(
                    backgroundColor: (mainController.isDark.value)
                        ? Colors.grey.shade900
                        : Colors.grey.shade100,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    label: Text(
                      project.platform[index],
                      style: AppThemeData.appThemeData.textTheme.bodySmall!
                          .copyWith(
                        color: mainController.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 10,
                ),
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
    double height = 200,
    double width = 200,
    bool isDesktop = true,
    bool isCircle = false,
    bool onlyText = false,
    VoidCallback? callBack,
  }) {
    MainController mainController = Get.find<MainController>();

    return GestureDetector(
      onTap: () async {
        buttonModel.isClicked(true);
        await Future.delayed(
            const Duration(milliseconds: Constants.animationDuration), () {
          buttonModel.isClicked(false);

          if (callBack == null)
            Functions.openLink(buttonModel.link);
          else
            callBack();
        });
      },
      child: Obx(
        () => MouseRegion(
          onEnter: (a) => buttonModel.isFocused.value = true,
          onExit: (a) => buttonModel.isFocused.value = false,
          child: AnimatedContainer(
            height: height,
            width: width,
            duration: Duration(milliseconds: Constants.animationDuration),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
                color: (buttonModel.isFocused.value)
                    ? (mainController.isDark.value)
                        ? Colors.black
                        : Colors.white
                    : Colors.transparent,
                gradient: (buttonModel.isFocused.value)
                    ? LinearGradient(
                        colors: mainController
                            .morphButtonGradients[buttonModel.gradientId.value])
                    : null,
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: !isCircle ? BorderRadius.circular(10) : null,
                boxShadow: !buttonModel.isClicked.value &&
                        buttonModel.isFocused.value
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
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: width * 0.7,
                    height: height * 0.7,
                    padding: isCircle || (height < 200) || (width < 200)
                        ? null
                        : EdgeInsets.all(buttonModel.pad.value - 20),
                    child: (mainController.isDark.value)
                        ? buttonModel.image_hovered
                        : buttonModel.image,
                  ),
                ),
                if (!isCircle && (height > 200 || width > 200))
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Obx(() => AnimatedOpacity(
                          duration: Duration(
                              milliseconds: Constants.animationDuration),
                          opacity: onlyText
                              ? 1
                              : buttonModel.isFocused.value
                                  ? 1
                                  : 0,
                          child: Text(
                            buttonModel.label.value,
                            style: AppThemeData
                                .appThemeData.textTheme.bodySmall!
                                .copyWith(
                                    color: (buttonModel.isFocused.value)
                                        ? Colors.white
                                        : mainController.isDark.value
                                            ? Colors.white
                                            : Colors.black87),
                          ),
                        )),
                  )
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              // EasyPieChart(
              //   showValue: false,
              //   key: Key(label),
              //   children: dataMap,
              //   shouldAnimate: false,
              //   pieType: PieType.fill,
              //   style: AppThemeData.appThemeData.textTheme.bodySmall!
              //       .copyWith(color: Colors.white),
              //   gap: 0,
              //   borderWidth: 0,
              // ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

// cursor follow shadow
class ShadowPainter extends CustomPainter {
  final Offset mousePosition;
  final bool isDark;

  ShadowPainter(this.mousePosition, this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          isDark ? Colors.white.withAlpha(100) : Colors.black.withAlpha(100)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 70.0);

    canvas.drawCircle(mousePosition, 70.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
