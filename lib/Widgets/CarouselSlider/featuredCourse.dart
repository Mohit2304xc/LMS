import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import '../../Controller/BannerController.dart';
import '../CircularContainer.dart';
import '../Course/CourseDetail.dart';
import 'RoundedImage.dart';

class Featuredcourses extends StatelessWidget {
  const Featuredcourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(BannerController());
     //Obx(() {
      //if (controller.isLoading.value) {
      //return const ShimmerEffect(width: double.infinity, height: 190);
      //}
      //if (controller.banners.isEmpty) {
      //return const Center(
      //child:
      //Text('No data Found!')
      //,
      //);
      //} else {
    return Column(
      children: [
      CarouselSlider(
      items:/*controller.banners
                  .map((banner) => RoundedImage(
                        isNetworkImage: true,
                        onPressed: () {
                          Get.toNamed(banner.targetScreen);
                        },
                        image: banner.imageURL,
                        applyImageRadius: false,
                      ))
                  .toList(),*/
      [
      RoundedImage(
      onPressed: ()=>Get.to(()=>const CourseDetail()),
      image: "assets/images/featured/paid/AI-Tools-bbb.png",
      applyImageRadius: true,
      borderRadius: 8,
      ),
      const RoundedImage(
      image: "assets/images/featured/paid/Corporate-email-1.png",
      applyImageRadius: true,
      borderRadius: 8,
      ),
      const RoundedImage(
      image: "assets/images/featured/paid/Digital-Marketing-1.png",
      applyImageRadius: true,
      borderRadius: 8,
      ),
      const RoundedImage(
      image: "assets/images/featured/paid/JAVA-Interview-Questions.png",
      applyImageRadius: true,
      borderRadius: 8,
      ),
      const RoundedImage(
      image: "assets/images/featured/paid/JAVASCRIPT-1.png",
      applyImageRadius: true,
      borderRadius: 8,
      ),
      const RoundedImage(
      image: "assets/images/featured/paid/Learn-Coding-1.png",
      applyImageRadius: true,
      borderRadius: 8,
      ),
      const RoundedImage(
      image: "assets/images/featured/paid/LinkedIn-cheet-Sheet.png",
      applyImageRadius: true,
      borderRadius: 8,
      ),
      const RoundedImage(
      image:
      "assets/images/featured/CS-Fundamental-Interview-Question-1.png",
      applyImageRadius: true,
      borderRadius: 8,
      ),
      const RoundedImage(
      image:
      "assets/images/featured/Deploying-Your-website-For-Free-1.png",
      applyImageRadius: true,
      borderRadius: 8,
      ),
      ],
      options: CarouselOptions(
      viewportFraction: 1,
      onPageChanged: (index, _) {}
      //controller.updatePageIndicator(index)
      ),
      ),
      const SizedBox(
      height: 16,
      ),
      Center(
      child: //Obx(
      //() =>
          Row(
      mainAxisSize: MainAxisSize.min,
      children: [
      for (int i = 0; i < 10/*controller.banners.length*/; i++)
      CircularContainer(
      width: 20,
      height: 5,
      Margin: const EdgeInsets.only(right: 10),
      backgroundColor:
      //controller.carouselCurrentIndex.value == i
      Colors.purple
      //: Colors.grey,
      ),
      ],
      ),
      //),
      )
      ]
      ,
      );
    }


  //);
}
