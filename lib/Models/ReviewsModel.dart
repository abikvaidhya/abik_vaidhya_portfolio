import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:get/get.dart';

class ReviewsModel {
  RxString image = ''.obs,
      link = ''.obs,
      company = ''.obs,
      name = ''.obs,
      review = ''.obs;

  ReviewsModel({
    required this.name,
    required this.company,
    required this.link,
    required this.image,
    required this.review,
  });

  factory ReviewsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;
    return ReviewsModel(
      name: ((docData['name'] ?? '').toString()).obs,
      company: ((docData['company'] ?? '').toString()).obs,
      link: ((docData['link'] ?? '').toString()).obs,
      image: ((docData['image'] ?? '').toString()).obs,
      review: ((docData['review'] ?? '').toString()).obs,
    );
  }
}
