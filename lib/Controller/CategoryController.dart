
import 'package:get/get.dart';
import 'package:dummy1/Model/CategoryModel.dart';
import 'package:dummy1/Repository/CategoryRepository.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final isLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel> [].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel> [].obs;


  @override
  void onInit(){
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async{
    try{
      isLoading.value = true;

      final categories = await _categoryRepository.getAllCategories();

      allCategories.assignAll(categories as Iterable<CategoryModel>);
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured).take(6).toList());
    } catch(e){
      SnackBars.ErrorSnackBar(title: 'Oh Snap!',message: e.toString());
    } finally{
      isLoading.value = false;
    }
  }
}