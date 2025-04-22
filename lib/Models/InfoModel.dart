import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:get/get.dart';

class InfoModel {
  RxString subTitle1 = ''.obs,
      label = ''.obs,
      description = ''.obs,
      subTitle2 = ''.obs;
  RxInt iconCodePoint = 0.obs, id = 0.obs;
  bool show = true;

  InfoModel(
      {required this.id,
      required this.label,
      required this.subTitle1,
      required this.subTitle2,
      required this.description,
      required this.iconCodePoint,
      required this.show});

  factory InfoModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;
    return InfoModel(
      id: int.parse(docData['id'].toString()).obs,
      label: docData['title'].toString().obs,
      subTitle1: docData['sub_title_1'].toString().obs,
      subTitle2: docData['sub_title_2'].toString().obs,
      description: docData['description'].toString().obs,
      iconCodePoint: int.parse(docData['icon'].toString()).obs,
      show: docData['show'] ?? true,
    );
  }
}
