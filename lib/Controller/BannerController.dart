import 'package:get/get.dart';
import 'package:dummy1/Repository/BannerRepository.dart';

import '../Model/BannerModel.dart';
import '../Widgets/snackbar/Snackbar.dart';

class BannerController extends GetxController{

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit(){
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index){
    carouselCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async{
    try{
      isLoading.value = true;

      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      this.banners.assignAll(banners);

    } catch(e){
      SnackBars.ErrorSnackBar(title: 'Oh Snap!',message: e.toString());
    } finally{
      isLoading.value = false;
    }
  }
}