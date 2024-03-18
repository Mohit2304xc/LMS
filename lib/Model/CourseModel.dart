import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  String id;
  double price;
  String title;
  double salePrice;
  String thumbnail;
  String? document;
  bool isFeatured;
  String? description;
  String? categoryId;
  List<String>? images;
  DateTime? date;

  CourseModel({
    this.date,
    this.document,
    required this.id,
    required this.isFeatured,
    required this.price,
    required this.title,
    this.salePrice = 0,
    required this.thumbnail,
    this.description,
    this.categoryId,
    this.images,
  });

  static CourseModel empty() =>
      CourseModel(id: '', price: 0, title: '', thumbnail: '', isFeatured: false);

  //json format
  toJson() {
    return {
      'CategoryId': categoryId,
      'Document' : document ?? '',
      'Description': description,
      'IsFeatured' : isFeatured,
      'Images': images ?? [],
      'Date' : date,
      'Price': price,
      'Sale Price': salePrice,
      'Thumbnail': thumbnail,
      'Title': title,
    };
  }

  //map json document into model from firebase
  factory CourseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data()==null) return CourseModel.empty();
    final data = document.data()!;
    return CourseModel(
      id: document.id,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      title: data['Title'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      document: data['Document'] ?? '',
      description: data['Description'] ?? '',
      salePrice: double.parse((data['Sale Price'] ?? 0.0).toString()),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      categoryId: data['CategoryId'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
    );
  }



  factory CourseModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String,dynamic>;
    return CourseModel(
      id: document.id,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      title: data['Title'] ?? '',
      thumbnail: data['Thumbnail'] ?? '',
      document: data['Document'] ?? '',
      description: data['Description'] ?? '',
      salePrice: double.parse((data['Sale Price'] ?? 0.0).toString()),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      categoryId: data['CategoryId'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
    );
  }
  static getDescriptionWithoutPTags(String text) {
    // Use regular expression to remove <p> tags
    return text?.replaceAll(RegExp(r'<p[^>]*>|<\/p>'), '') ?? '';
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    try {
      final List<dynamic>? downloads = json['downloads'];
      final String? document = downloads != null && downloads.isNotEmpty
          ? downloads[0]['file']
          : '';
      print("success");

      return CourseModel(
        id: json['id'].toString(),
        price: (json['regular_price'] as int).toDouble(),
        title: json['name'] ?? '',
        thumbnail: json['images'] != null && json['images'].isNotEmpty
            ? json['images'][0]['src'] ?? ''
            : '',
        document: document ?? "",
        description: json['description'] ?? '',
        salePrice: (json['sale_price'] as int).toDouble(),
        images: json['images'] != null && json['images'].isNotEmpty
            ? List<String>.from(json['images'].map((image) => image['src']))
            : [],
        categoryId: json['categories'] != null && json['categories'].isNotEmpty
            ? json['categories'][0]['id'].toString()
            : '',
        isFeatured: json['featured'] ?? false,
        date: json['date_created'] != null
            ? DateTime.parse(json['date_created'])
            : null,
      );
    } catch (e) {
      // Handle parsing error, e.g., log error message and return default value
      print('Error parsing sale_price: $e');
      print(json['id'].toString());
      return CourseModel(
        // Provide default values for other properties
        id: json['id'].toString(),
        price: 0,
        title: json['name'] ?? '',
        thumbnail: '',
        document: '',
        description: '',
        salePrice: 0,
        images: [],
        categoryId: '',
        isFeatured: false,
        date: null,
      );
    }
  }

}
