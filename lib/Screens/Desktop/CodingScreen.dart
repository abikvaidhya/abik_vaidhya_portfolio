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
    CodingController codingController = Get.find<CodingController>();

    return Obx(
      () => (codingController.gettingFrameworks.value ||
              codingController.gettingWorkSocials.value)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height * 3,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Widgets.ExperienceDetails(
                      isDesktop: widget.isDesktop,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Widgets.projectDetails(
                      isDesktop: widget.isDesktop,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Widgets.reviews(
                      isDesktop: widget.isDesktop,
                    ),
                  )
                  // Expanded(
                  //   child: PageView(
                  //     pageSnapping: widget.isDesktop ? false : true,
                  //     allowImplicitScrolling: widget.isDesktop ? false : true,
                  //     physics: widget.isDesktop
                  //         ? NeverScrollableScrollPhysics()
                  //         : ClampingScrollPhysics(),
                  //     scrollDirection: (widget.isDesktop)
                  //         ? Axis.horizontal
                  //         : Axis.horizontal,
                  //     children: [
                        // Widgets.CodingIntroDetails(
                        //   context: context,
                        //   isDesktop: widget.isDesktop,
                        // ),
                  //       // Widgets.FrameworksDetails(
                  //       //   isDesktop: widget.isDesktop,
                  //       // ),
                  //       Widgets.ExperienceDetails(
                  //         isDesktop: widget.isDesktop,
                  //       ),
                  //       Widgets.projectDetails(
                  //         isDesktop: widget.isDesktop,
                  //       ),
                  //       Widgets.reviews(
                  //         isDesktop: widget.isDesktop,
                  //       )
                  //     ],
                  //     controller: mainController.codingController,
                  //     onPageChanged: (value) {
                  //       // scroll up/down button icon changes
                  //       if (mainController.codingController.page!.round() >
                  //               0 &&
                  //           widget.isDesktop) {
                  //         mainController.isCodeScrollDown.value = false;
                  //       } else {
                  //         mainController.isCodeScrollDown.value = true;
                  //       }

                  //       mainController.codingIndex.value =
                  //           mainController.codingController.page!.round();
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }
}
