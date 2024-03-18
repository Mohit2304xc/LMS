class ReviewModel {
  String name;
  String courseName;
  String email;
  String review;
  int rating;
  DateTime date;

  ReviewModel({
    required this.name,
    required this.courseName,
    required this.email,
    required this.review,
    required this.rating,
    required this.date,
  });

  static ReviewModel empty() => ReviewModel(
      name: "",
      courseName: '',
      email: '',
      review: '',
      rating: 0,
      date: '' as DateTime);

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      name: json['reviewer'] ?? '',
      courseName: json['product_name'] ?? '',
      email: json['reviewer_email'] ?? '',
      review: json['review'],
      rating: json['rating'],
      date: DateTime.parse(json['date_created']),
    );
  }
}
