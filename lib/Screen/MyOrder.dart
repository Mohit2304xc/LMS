import 'package:dummy1/Controller/OrderController.dart';
import 'package:dummy1/Model/CourseModel.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/ProductCardVertical/CourseCardVertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../Widgets/Animation/AnimationLoaderWidget.dart';
import '../Widgets/BottomNavigation/BottomNavigationBar.dart';
import '../Widgets/CircularContainer.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        onPressed: () => Get.to(() => const NavigationMenu()),
        opacity: 1,
        title: Text(
          "My Orders",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder(
            future: controller.fetchUserOrders(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Something Went Wrong. ${snapshot.error}"),
                );
              } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                return AnimationLoaderWidget(
                  text: 'No orders yet!',
                  animation:
                      'assets/images/success/141594-animation-of-docer.json',
                  showAction: true,
                  actionText: 'Let\'s fill it',
                  onActionPressed: () => Get.off(() => const NavigationMenu()),
                );
              } else {
                final orders = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          final order = orders[index];
                          return CircularContainer(
                            onTap: () => Get.to(() => Ordercourses(
                                  orderId: order.id,
                                )),
                            width: double.infinity,
                            height: 100,
                            radius: 20,
                            backgroundColor: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        order.id,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        (order.orderDate).toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    order.status.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemCount: orders.length,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Ordercourses extends StatelessWidget {
  const Ordercourses({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        onPressed: () => Get.to(() => const MyOrder()),
        opacity: 1,
        title: Text(
          "Courses",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              FutureBuilder(
                future: controller.fetchUserOrdersByOrderId(orderId),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Something Went Wrong. ${snapshot.error}"));
                  } else if (!snapshot.hasData ||
                      (snapshot.data as List).isEmpty) {
                    return AnimationLoaderWidget(
                      text: 'No orders yet!',
                      animation:
                          'assets/images/success/141594-animation-of-docer.json',
                      showAction: true,
                      actionText: 'Let\'s fill it',
                      onActionPressed: () =>
                          Get.off(() => const NavigationMenu()),
                    );
                  } else {
                    final orders = snapshot.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final order = orders[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: order.items.length,
                              itemBuilder: (context, itemIndex) {
                                var product = order.items[itemIndex];
                                return ListTile(
                                  leading: const Icon(Icons.book_online),
                                  title: Text(
                                    product,
                                    style: const TextStyle(
                                        fontSize: 25),
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 32),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 32),
                      itemCount: orders.length,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
