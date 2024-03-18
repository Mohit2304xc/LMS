import 'dart:convert';

import 'package:dummy1/Model/ReviewModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReviewAndRatingController extends GetxController {
  static ReviewAndRatingController get instance => Get.find();

  RxInt count = 0.obs;
  RxInt oneStar = 0.obs;
  RxInt twoStar = 0.obs;
  RxInt threeStar = 0.obs;
  RxInt fourStar = 0.obs;
  RxInt fiveStar = 0.obs;
  double totalRating = 0;
  RxDouble averageRating = 0.0.obs;

  Future<List<ReviewModel>> fetchReviewAndRating(String courseName) async {
    try {
      final response = await http.get(Uri.parse(
          "https://lms.prabisha.com/wp-json/wc/v3/products/reviews?consumer_key=ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa&consumer_secret=cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4"));
      if (response.statusCode == 200) {
        List<dynamic> allProductReviews = json.decode(response.body);
        List<ReviewModel> reviews = allProductReviews
            .where((element) => element['product_name'] == courseName)
            .map((e) => ReviewModel.fromJson(e))
            .toList();

        totalRating = 0;

        for (var review in reviews) {
          totalRating += review.rating;
          switch (review.rating) {
            case 1:
              oneStar.value++;
              //print(oneStar.value);
              break;
            case 2:
              twoStar.value++;
              //print(twoStar.value);
              break;
            case 3:
              threeStar.value++;
              //print(threeStar.value);
              break;
            case 4:
              fourStar.value++;
              //print(fourStar.value);
              break;
            case 5:
              fiveStar.value++;
              //print(fiveStar.value);
              break;
            default:
              break;
          }
        }
        averageRating.value =
            double.parse((totalRating / reviews.length).toStringAsFixed(1));
        count.value = reviews.length;
        return reviews;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<ReviewModel>> fetchFewReviewAndRating(String courseName) async {
    try {
      final response = await http.get(Uri.parse(
          "https://lms.prabisha.com/wp-json/wc/v3/products/reviews?consumer_key=ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa&consumer_secret=cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4"));
      if (response.statusCode == 200) {
        List<dynamic> allProductReviews = json.decode(response.body);
        List<ReviewModel> reviews = allProductReviews
            .where((element) => element['product_name'] == courseName)
            .take(2)
            .map((e) => ReviewModel.fromJson(e))
            .toList();
        return reviews;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
