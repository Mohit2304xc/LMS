import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String imageURL;
  final String name;
  final String description;
  final String courseImage; // Add courseImage field
  final String courseRedirectURL; // Add courseRedirectURL field

  BannerModel({
    required this.imageURL,
    required this.name,
    required this.description,
    required this.courseImage,
    required this.courseRedirectURL,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      imageURL: json['src'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      courseImage: json['images'][0]['src'] ?? '',
      courseRedirectURL: json['permalink'] ?? '',
    );
  }
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      imageURL: data['ImageURL'] ?? '',
      name: data['Name'] ?? '',
      description: data['Description'] ?? '',
      courseImage: data['CourseImage'] ?? '', // Initialize courseImage field
      courseRedirectURL: data['CourseRedirectURL'] ?? '', // Initialize courseRedirectURL field
    );
  }
}

