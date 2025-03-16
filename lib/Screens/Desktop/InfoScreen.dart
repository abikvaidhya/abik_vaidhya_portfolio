import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import 'package:my_porfolio/Utils/AppThemeData.dart';
import 'package:my_porfolio/Utils/UiUtils.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Widgets.customShadowBox(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44.0),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Widgets.subtitleTexts(
                                label: mainController.infos[0].subTitle1.value,
                                id: 0,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Widgets.subtitleTexts(
                                  label:
                                      mainController.infos[0].subTitle2.value,
                                  id: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
