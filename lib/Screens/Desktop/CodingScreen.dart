import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/CodingController.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import 'package:my_porfolio/Utils/UiUtils.dart';

class CodingScreen extends StatefulWidget {
  const CodingScreen({Key? key, required this.isDesktop}) : super(key: key);

  final bool isDesktop;

  @override
  State<CodingScreen> createState() => _CodingScreenState();
}

class _CodingScreenState extends State<CodingScreen> {
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    CodingController codingController = Get.find<CodingController>();
    return Obx(
      () => (codingController.gettingFrameworks.value ||
              codingController.gettingWorkSocials.value)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: PageView(
                        pageSnapping: widget.isDesktop ? false : true,
                        allowImplicitScrolling: widget.isDesktop ? false : true,
                        physics: widget.isDesktop
                            ? NeverScrollableScrollPhysics()
                            : ClampingScrollPhysics(),
                        scrollDirection: (widget.isDesktop)
                            ? Axis.vertical
                            : Axis.horizontal,
                        children: [
                          Widgets.CodingIntroDetails(
                            context: context,
                            isDesktop: widget.isDesktop,
                          ),
                          Widgets.FrameworksDetails(
                            isDesktop: widget.isDesktop,
                          ),
                          Widgets.ExperienceDetails(
                            isDesktop: widget.isDesktop,
                          ),
                          if (widget.isDesktop)
                            Widgets.projectDetails(isDesktop: widget.isDesktop)
                        ],
                        controller: mainController.codingController,
                        onPageChanged: (value) {
                          // scroll up/down button icon changes
                          if (mainController.codingController.page!.round() >
                                  0 &&
                              widget.isDesktop) {
                            mainController.isCodeScrollDown.value = false;
                          } else {
                            mainController.isCodeScrollDown.value = true;
                          }

                          mainController.codingIndex.value =
                              mainController.codingController.page!.round();
                        },
                      ),
                    ),
                  ],
                ),

                // scroll up/down button
                if (widget.isDesktop)
                  Positioned(
                    right: 30,
                    bottom: MediaQuery.of(context).size.height / 8,
                    child: Obx(
                      () => Widgets.desktopScrollButton(
                          mainController.codingController,
                          mainController.isCodeScrollDown),
                    ),
                  ),
              ],
            ),
    );
  }
}
