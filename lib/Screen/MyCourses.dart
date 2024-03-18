import 'package:dummy1/Controller/OrderController.dart';
import 'package:dummy1/Model/OrderModel.dart';
import 'package:dummy1/Widgets/Animation/AnimationLoaderWidget.dart';
import 'package:dummy1/Widgets/CircularContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:dummy1/Widgets/BottomNavigation/BottomNavigationBar.dart';
import '../Model/CartModel.dart';
import '../Widgets/PDFViewer/PdfViewerScreen.dart';
import 'QuestionScreen.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
      appBar: AppbarMenu(
        opacity: 1,
        showBackArrow: false,
        title: Text(
          "My Course",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.apply(color: Colors.white),
        ),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              FutureBuilder<List<OrderModel>>(
                future: controller.fetchUserOrders(),
                builder: (_, AsyncSnapshot<List<OrderModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Something Went Wrong. ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                    final uniqueProducts = <String, CartModel>{};

                    for (final order in orders) {
                      for (final item in order.items) {
                        uniqueProducts[item.title] = item;
                      }
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final product = uniqueProducts.values.toList()[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircularContainer(
                              width: double.infinity,
                              height: 95,
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Image.network(product.image),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(child: Text(product.title)),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(ExamPage(
                                            examTitle: product.title,
                                          ));
                                        },
                                        child: const Text("Take Test"),
                                      )
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                        Icons.keyboard_arrow_right_rounded),
                                    onPressed: () {
                                      Get.to(() =>
                                          PdfViewer(title: product.title));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 32),
                      itemCount: uniqueProducts.length,
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
