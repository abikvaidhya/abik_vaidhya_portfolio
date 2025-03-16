import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import 'package:my_porfolio/Utils/AppThemeData.dart';
import 'package:my_porfolio/Utils/UiUtils.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key, required this.isDesktop}) : super(key: key);

  final bool isDesktop;

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 60,
      children: [
        Widgets.customShadowBox(
          Text(mainController
              .infos[3]
              .label
              .value,
              style: AppThemeData.appThemeData.textTheme.headlineMedium!
                  .copyWith(
                      color: (mainController.isDark.value)
                          ? Colors.white
                          : Colors.black)),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * .20,
            child: Widgets.musicMorphButtons(context,
                isDesktop: widget.isDesktop)),
      ],
    );
  }
}
