import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/BannerModel.dart';

class BannerController extends ChangeNotifier {
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  List<BannerModel> banners = [];

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse(
          'https://lms.prabisha.com/wp-json/wc/v3/products?per_page=100&consumer_key=ck_a57db437f1c9d5273d73fe76d0beac292e85d0aa&consumer_secret=cs_0e2c4571b4035f97cdac6693c71b082b79fe52a4'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        banners = responseData
            .where((bannerData) => bannerData['featured'] == true)
            .map((bannerData) => BannerModel.fromJson(bannerData))
            .toList();
        notifyListeners();
      } else {
        throw 'Failed to load banners';
      }
    } catch (e) {
      throw 'Failed to load banners: $e';
    }
  }
}
