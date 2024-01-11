
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: MediaQuery.of(Get.context!).size.width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.search_normal,
              color: Colors.grey[500],
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              "Search in Courses",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.apply(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}