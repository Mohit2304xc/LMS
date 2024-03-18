import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/OrderController.dart';
import '../../Model/CourseModel.dart';
import '../Animation/AnimationLoaderWidget.dart';
import '../Appbar/Appbar.dart';
import '../BottomNavigation/BottomNavigationBar.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        onPressed: () => Get.back(),
        opacity: 1,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.white),
        ),
      ),
      body: FutureBuilder<CourseModel>(
        future: controller.getPdfBasedOnTitle(title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final course = snapshot.data!;
            return PDFViewerScreen(document: course.document);
          }
        },
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  const PDFViewerScreen({super.key, required this.document});

  final String? document;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PDFDocument>(
      future: PDFDocument.fromURL(document!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          print(document);
          return AnimationLoaderWidget(
            text: 'No Course Content',
            animation: 'assets/images/success/141594-animation-of-docer.json',
            showAction: false,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return PDFViewer(document: snapshot.data!);
        }
      },
    );
  }
}