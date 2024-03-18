import 'package:dummy1/Controller/OrderController.dart';
import 'package:dummy1/Widgets/Appbar/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DownloadCourseScreen extends StatelessWidget {
  const DownloadCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: false,
        onPressed: () {},
        opacity: 0.8,
        title: Text(
          'Course Download',
          style:
              Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: orderController.fetchUserOrders(), // Fetch orders from Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Show error if data fetching fails
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return FutureBuilder(
                  future: orderController.fetchCourseDetails(order.items),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Show loading indicator while fetching data
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Show error if data fetching fails
                    } else {
                      final courseDetailsList = snapshot.data!;
                      // Display PDF here using the URL from courseDetailsList
                      // Example: Use a PDF viewer widget or open the PDF in a webview
                      // Navigate to another screen to display PDF
                      return ListTile(
                        title: Text('Order ID: ${order.id}'),
                        onTap: () {
                          // Example: Open PDF in a new screen
                          // navigateToPDFViewer(courseDetailsList);
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
