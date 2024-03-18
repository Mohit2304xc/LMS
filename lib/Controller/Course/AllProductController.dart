import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy1/Model/CourseModel.dart';
import 'package:dummy1/Repository/CourseRepository.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:get/get.dart';



class AllProductController extends GetxController{
  static AllProductController get instance => Get.find();

  final repo = CourseRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<CourseModel> courses = <CourseModel> [].obs;



  Future<List<CourseModel>> fetchCoursesByQuery(Query? query)async{
    try{
      if(query == null){
        return [];
      }
      final courses = await repo.fetchCoursesByQuery(query);
      return courses;
    } catch(e){
      SnackBars.ErrorSnackBar(title: 'Oh Snap!',message: e.toString());
      return [];
    }
  }

  void sortCourses(String sortOption){
    selectedSortOption.value = sortOption;

    switch (sortOption){
      case "Name" :
        courses.sort((a,b)=> a.title.compareTo(b.title));
        break;

      case "Low to High" :
        courses.sort((a,b) => a.price.compareTo(b.price));
        break;

      case "High to Low" :
        courses.sort((a,b) => b.price.compareTo(a.price));
        break;

      case "Latest" :
        courses.sort((a,b) => a.date!.compareTo(b.date!));
        break;

      default:
        courses.sort((a,b)=>a.title.compareTo(b.title));
    }
  }

  void assignCourses(List<CourseModel> courses){
    this.courses.assignAll(courses);
    sortCourses('Name');
  }



}
