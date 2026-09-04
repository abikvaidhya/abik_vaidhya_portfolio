import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/CodingController.dart';
import '../../Controllers/MainController.dart';
import '../../Controllers/SocialsController.dart';
import '../../Utils/AppThemeData.dart';
import '../../Utils/UiUtils.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({key, required this.isDesktop});

  final bool isDesktop;

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  MainController mainController = Get.find<MainController>();
  CodingController codingController = Get.find<CodingController>();
  SocialsController socialsController = Get.find<SocialsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // review section
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: CarouselSlider.builder(
            itemCount: codingController.reviews.length,
            options: CarouselOptions(
                viewportFraction: 0.7,
                height: 600,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(
                  seconds: 7,
                )),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Obx(
                () => Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                    color: (mainController.isDark.value)
                        ? Colors.grey.shade900
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // review
                            Expanded(
                              child: Center(
                                child:
                                  Text(
                                      codingController
                                          .reviews[index].review.value,
                                      maxLines: 5,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppThemeData
                                          .appThemeData.textTheme.bodyMedium!
                                          .copyWith(
                                        color: mainController.isDark.value
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                              ),
                            ),

                            Column(
                              children: [
                                Divider(
                                  endIndent: 10,
                                  indent: 10,
                                ),
                                // reviewer name
                                  Text(
                                      codingController
                                          .reviews[index].name.value,
                                      style: AppThemeData.appThemeData
                                          .textTheme.displayMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: mainController.isDark.value
                                            ? Colors.white
                                            : Colors.black,
                                      )),

                                // reviewer company
                                  Text(
                                      codingController
                                          .reviews[index].company.value,
                                      style: AppThemeData
                                          .appThemeData.textTheme.bodySmall!
                                          .copyWith(
                                              color:
                                                  mainController.isDark.value
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // connect details
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.all(22.0),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text("Let me help you build your dream app.",
                    textAlign: TextAlign.end,
                    style: AppThemeData.appThemeData.textTheme.headlineMedium!
                        .copyWith(
                      color: mainController.isDark.value
                          ? Colors.white
                          : Colors.black,
                    )),
                Text("Connect with me",
                    style: AppThemeData.appThemeData.textTheme.displayLarge!
                        .copyWith(
                      color: mainController.isDark.value
                          ? Colors.white
                          : Colors.grey,
                    )),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail,
                      color: mainController.isDark.value
                          ? Colors.grey.shade400
                          : Colors.grey,
                    ),
                    Text('abikvaidhya@gmail.com',
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: mainController.isDark.value
                              ? Colors.grey.shade400
                              : Colors.grey,
                        )),
                  ],
                ),
                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: mainController.isDark.value
                          ? Colors.grey.shade400
                          : Colors.grey,
                    ),
                    Text('+46(739)810-135',
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: mainController.isDark.value
                              ? Colors.grey.shade400
                              : Colors.grey,
                        )),
                    Text(' | ',
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: mainController.isDark.value
                              ? Colors.grey.shade400
                              : Colors.grey,
                        )),
                    Icon(
                      Icons.phone,
                      color: mainController.isDark.value
                          ? Colors.grey.shade400
                          : Colors.grey,
                    ),
                    Text('+977(986)908-0265',
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: mainController.isDark.value
                              ? Colors.grey.shade400
                              : Colors.grey,
                        )),
                    Text(' | ',
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: mainController.isDark.value
                              ? Colors.grey.shade400
                              : Colors.grey,
                        )),
                    Icon(
                      Icons.pin_drop_rounded,
                      color: mainController.isDark.value
                          ? Colors.grey.shade400
                          : Colors.grey,
                    ),
                    Text('Gotenborg, Sweden',
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: mainController.isDark.value
                              ? Colors.grey.shade400
                              : Colors.grey,
                        )),
                  ],
                ),

                // portfolio links
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            codingController.jobSocialsMorphButtons.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Widgets.morphButton(context,
                              buttonModel: codingController
                                  .jobSocialsMorphButtons[index],
                              isCircle: true,
                              height: 60,
                              width: 60);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 20,
                          );
                        },
                      )
                    ],
                  ),
                ),

                // social links
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            socialsController.socialMorphButtons.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Widgets.morphButton(context,
                              buttonModel:
                                  socialsController.socialMorphButtons[index],
                              isCircle: true,
                              height: 60,
                              width: 60);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 20,
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        // footer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Divider(endIndent: 20,indent: 20,),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Developed using ',
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: mainController.isDark.value
                              ? Colors.white
                              : Colors.black,
                        )),
                    Text('Flutter.',
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: Colors.blueAccent,
                        )),
                    VerticalDivider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    Text('©️ 2021. All Rights Reserved',
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(
                          color: mainController.isDark.value
                              ? Colors.white
                              : Colors.grey,
                        )),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
