import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:get/get.dart';

class Statusmodel extends GetxController {
  bool live = false;

  Statusmodel({
    required this.live,
  });

  factory Statusmodel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;
    return Statusmodel(
      live: docData['live'],
    );
  }
}
