import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageURL;
  final String targetScreen;
  final bool active;

  BannerModel({
    required this.imageURL,
    required this.targetScreen,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      'ImageURL': imageURL,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
        imageURL: data['ImageURL'] ?? '',
        targetScreen: data['TargetScreen'] ?? '',
        active: data['Active'] ?? false);
  }
}
