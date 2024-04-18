import 'dart:io';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Repository/AuthenticationRepository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Service extends GetxController {
  static Service get instance => Get.find();

  /*Future<String> getUserName() async {
    final currentUserUID = AuthenticationRepository.instance.authUser?.uid;
    if (currentUserUID != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserUID)
          .get();
      final firstName = userDoc.get('FirstName');
      final lastName = userDoc.get('LastName');
      return '$firstName $lastName';
    }
    return '';
  }*/

  Future<Uint8List> createPDF(String title) async {
    final pdf = pw.Document();
    final ByteData imageData = await rootBundle
        .load('assets/images/Blue  Professional Certificate of Completion.png');
    final Uint8List bytes = imageData.buffer.asUint8List();
    const PdfColor whiteColor = PdfColor.fromInt(00000);
    //final fullName = await getUserName();
    final currentDate = DateTime.now();
    final ByteData image = await rootBundle.load('assets/images/logo.png');
    final Uint8List byte = image.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              image: pw.DecorationImage(
                image: pw.MemoryImage(bytes),
                fit: pw.BoxFit.fill,
              ),
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.only(left: 60, right: 60, top: 75),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Image(pw.MemoryImage(byte)),
                  pw.SizedBox(height: 20),
                  pw.Center(
                    child: pw.Text(
                      "Certificate Of Completion",
                      style: pw.TextStyle(
                        fontSize: 30,
                      fontWeight: pw.FontWeight.bold,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Proudly presented to',
                    style: const pw.TextStyle(
                      fontSize: 20,
                      color: whiteColor,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "fullName",
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: 30,
                      fontWeight: pw.FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Divider(
                    color: whiteColor,
                    thickness: 1.0,
                    height: 20.0,
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Has successfully completed a course on',
                    style: const pw.TextStyle(
                      fontSize: 20,
                      color: whiteColor,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    title,
                    style: pw.TextStyle(
                      fontSize: 30,
                      fontWeight: pw.FontWeight.bold,
                      color: whiteColor,
                    ),
                    maxLines: 1
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Date: ${currentDate.year}-${currentDate.month}-${currentDate.day}',
                    style: const pw.TextStyle(
                      fontSize: 18,
                      color: whiteColor,
                    ),
                  ),
                  pw.SizedBox(height: 60),
                  pw.Container(
                    width: 200,
                    color: whiteColor,
                    height: 1,
                  ),
                  pw.SizedBox(height: 10),
                  pw.Center(
                    child: pw.Text(
                      'Issued by Mr.Pratyush Kumar,',
                      style: const pw.TextStyle(
                        fontSize: 18,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  pw.Center(
                    child: pw.Text(
                      'Director at Prabisha Consulting',
                      style: const pw.TextStyle(
                        fontSize: 18,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = '${output.path}/$fileName.pdf';
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
