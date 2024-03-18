class CartModel {
  String courseId;
  String title;
  String image;
  double price;
  int quantity;

  CartModel({
    required this.courseId,
    required this.quantity,
    required this.image,
    this.title = '',
    this.price = 0.0,
  });

  static CartModel empty() => CartModel(courseId: '', quantity: 0, image: '');

  Map<String, dynamic> toJson() {
    return {
      'CourseId': courseId,
      'Title': title,
      'Price': price,
      'Image': image,
      'Quantity': quantity,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      courseId: json['CourseId'],
      quantity: json['Quantity'],
      title: json['Title'],
      price: json['Price']?.toDouble(),
      image: json['Image'],
    );
  }
}
