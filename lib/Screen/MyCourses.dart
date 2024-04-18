import 'package:dummy1/Controller/OrderController.dart';
import 'package:dummy1/Model/OrderModel.dart';
import 'package:dummy1/Repository/OrderRepository.dart';
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
  const MyCourses({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final repo = Get.put(OrderRepository());
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
                    print(orders);
                    // Use the items list to ensure uniqueness
                    final uniqueItems = repo.items;

                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final item = uniqueItems[index];
                        return CircularContainer(
                          width: double.infinity,
                          height: 95,
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: FutureBuilder<String>(
                                future: controller.getCartModelByTitle(item),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        "Error: ${snapshot.error}");
                                  } else {
                                    final thumbnailUrl =
                                    snapshot.data!;
                                    return Image.network(thumbnailUrl);
                                  }
                                },
                              ),
                              title: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text(
                                        item,
                                        maxLines: 1,
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(
                                          ()=>ExamPage(examTitle: item));
                                    },
                                    child: const Text("Take Test"),
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons
                                    .keyboard_arrow_right_rounded),
                                onPressed: () {
                                  Get.to(() => PdfViewer(
                                      title: item));
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 2),
                      itemCount: uniqueItems.length,
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
