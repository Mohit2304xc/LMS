import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dummy1/Model/BannerModel.dart';

import '../Exceptions/firebase_exceptions.dart';
import '../Exceptions/format_exceptions.dart';
import '../Exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return result.docs
          .map((document) => BannerModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FormatExceptions();
    } on PlatformException catch (e) {
      throw PlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching banners';
    }
  }


  /*Future<void> uploadDummyData(List<BannerModel> banners)async{
    try{
      final storage = Get.put(FirebaseStorageService());

      for(var banner in banners){
        final file = await storage.getImageDataFromAssets(banner.imageURL);

        final url = await storage.uploadImageData('Banners/Images',file);

        banner.imageURL = url;
        _db.collection("Banners").doc().set(banner.toJson());
      }
    } on FirebaseException catch(e){
      throw FirebaseExceptions(e.code).message;
    } on PlatformException catch(e){
      throw PlatformExceptions(e.code).message;
    } catch(e){
      throw e.toString();
    }
  }*/
}
