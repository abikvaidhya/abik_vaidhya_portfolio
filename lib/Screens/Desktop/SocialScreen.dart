import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import 'package:my_porfolio/Utils/AppThemeData.dart';
import 'package:my_porfolio/Utils/UiUtils.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({Key? key, required this.isDesktop}) : super(key: key);

  final bool isDesktop;

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 60,
      children: [
        Widgets.customShadowBox(
          Text(
            mainController.infos.last.label.value,
            style: AppThemeData.appThemeData.textTheme.headlineMedium!.copyWith(
                color: (mainController.isDark.value)
                    ? Colors.white
                    : Colors.black),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Widgets.socialMorphButtons(context, isDesktop: widget.isDesktop),
            ],
          ),
        ),
      ],
    );
  }
}
