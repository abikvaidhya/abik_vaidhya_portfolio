import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import '../Controllers/CodingController.dart';
import '../Controllers/SocialsController.dart';
import '../Utils/Constants.dart';
import '../Utils/UiUtils.dart';

class MobileInfoScreen extends StatefulWidget {
  const MobileInfoScreen({Key? key}) : super(key: key);

  @override
  State<MobileInfoScreen> createState() => _MobileInfoScreenState();
}

class _MobileInfoScreenState extends State<MobileInfoScreen> {
  MainController mainController = Get.find<MainController>();
  CodingController codingController = Get.find<CodingController>();
  SocialsController socialsController = Get.find<SocialsController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(20)),
              image:DecorationImage(
                  filterQuality: FilterQuality.low,
                  opacity: 0.2,
                  fit: BoxFit.cover,
                  image: AssetImage(ImageConstants.imagesPath +
                      'androidparty.png'))),
          child: Column(
            spacing: 20,
            children: [
              Text(
                'abik vaidhya',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 80,
                  color: mainController.isDark.value ? Colors.white : null,
                ),
              ),
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    'mobile application developer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: mainController.isDark.value ? Colors.white : null,
                    ),
                  ),
                ),
              ),
              Divider(
                indent: 30,
                endIndent: 30,
              ),
              Row(
                spacing: 15,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300.withOpacity(0.3),
                    child: Icon(
                      Icons.mail_outline,
                      color: mainController.isDark.value ? Colors.white : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Clipboard.setData(
                        ClipboardData(text: "abikvaidhya@gmail.com")),
                    child: Text(
                      'abikvaidhya@gmail.com',
                      style: TextStyle(
                        color:
                            mainController.isDark.value ? Colors.white : null,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: "+46-739-810-135"));
                },
                child: Row(
                  spacing: 15,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300.withOpacity(0.3),
                      child: Icon(
                        Icons.phone_iphone_rounded,
                        color:
                            mainController.isDark.value ? Colors.white : null,
                      ),
                    ),
                    Text(
                      '+46-739-810-135',
                      style: TextStyle(
                        color:
                            mainController.isDark.value ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 15,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300.withOpacity(0.3),
                    child: Icon(
                      Icons.pin_drop,
                      color: mainController.isDark.value ? Colors.white : null,
                    ),
                  ),
                  Text(
                    'Gothenburg',
                    style: TextStyle(
                      color: mainController.isDark.value ? Colors.white : null,
                    ),
                  ),
                ],
              ),

              Divider(
                indent: 30,
                endIndent: 30,
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
                      separatorBuilder:
                          (BuildContext context, int index) {
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
                            buttonModel: socialsController
                                .socialMorphButtons[index],
                            isCircle: true,
                            height: 60,
                            width: 60);
                      },
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return SizedBox(
                          width: 20,
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
