import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/CategoryController.dart';
import '../../Model/CategoryModel.dart';
import '../Animation/CategoryShimmer.dart';
import '../SubCategory/SubCategory.dart';
import '../VerticalImage/VerticalImage.dart';

class PopularCategories extends StatelessWidget {
  const PopularCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return FutureBuilder<List<CategoryModel>>(
      future: controller.getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CategoryShimmer(
            itemCount: 9, // You can specify a placeholder itemCount
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error loading categories: ${snapshot.error}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.white),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "No categories found!",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.white),
            ),
          );
        } else {
          final categories = snapshot.data!;
          return SizedBox(
            height: 80,
            child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final category = categories[index];
                return VerticalImageText(
                  textColor: Colors.white,
                  image: category.image,
                  title: category.name,
                  onTap: () {
                    Get.to(
                          () => SubCategory(
                        name: category.name,
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
