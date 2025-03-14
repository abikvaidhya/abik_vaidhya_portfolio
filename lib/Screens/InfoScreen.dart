import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_porfolio/Controllers/MainController.dart';
import 'package:my_porfolio/Utils/Constants.dart';

class MobileInfoScreen extends StatefulWidget {
  const MobileInfoScreen({Key? key}) : super(key: key);

  @override
  State<MobileInfoScreen> createState() => _MobileInfoScreenState();
}

class _MobileInfoScreenState extends State<MobileInfoScreen> {
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
              color: mainController.isDark.value
                  ? Colors.grey.shade300.withOpacity(0.3)
                  : Colors.grey.shade300.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            spacing: 15,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).width / 1.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageConstants.own),
                      fit: BoxFit.cover,
                    ),
                    color: mainController.isDark.value
                        ? Colors.grey.withOpacity(0.1)
                        : Colors.grey.shade300.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    'flutter developer',
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
                  Clipboard.setData(ClipboardData(text: "+977-986-908-0265"));
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
                      '+977-986-908-0265',
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
                    'Kathmandu, Nepal',
                    style: TextStyle(
                      color: mainController.isDark.value ? Colors.white : null,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 15,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300.withOpacity(0.3),
                    child: Icon(
                      Icons.book,
                      color: mainController.isDark.value ? Colors.white : null,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Herald International College',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color:
                            mainController.isDark.value ? Colors.white : null,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 40,
                  // width: ,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(child: Text('More on mobile coming soon.')))
            ],
          ),
        ),
      ),
    );
  }
}
