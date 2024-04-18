//import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '');

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'Id': id,
    };
  }

  /*factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }*/

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      image: json['image'] != null ? json['image']['src'] : '', // Use 'src' directly
    );
  }


}
