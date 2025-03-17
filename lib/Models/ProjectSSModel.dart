import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:get/get.dart';

class Projectssmodel {
  RxString link = ''.obs;

  Projectssmodel({
    required this.link,
  });

  factory Projectssmodel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;
    return Projectssmodel(
      link: ((docData['link'] ?? '').toString()).obs,
    );
  }
}
