import 'package:dummy1/Model/categoryModel.dart';

import 'Model/BannerModel.dart';

class DummyData{
  static final List<BannerModel> Banners = [
    BannerModel(imageURL: 'assets/images/featured/CS-Fundamental-Interview-Question-1.png', targetScreen: '', active: true),
    BannerModel(imageURL: 'assets/images/featured/Deploying-Your-website-For-Free-1.png', targetScreen: '', active: true),
    BannerModel(imageURL: 'assets/images/featured/paid/AI-Tools-bbb.png', targetScreen: '', active: true),
    BannerModel(imageURL: 'assets/images/featured/paid/Corporate-email-1.png', targetScreen: '', active: true),
    BannerModel(imageURL: 'assets/images/featured/paid/Digital-Marketing-1.png', targetScreen: '', active: true),
    BannerModel(imageURL: 'assets/images/featured/paid/Excel-For-Professionals-1.png', targetScreen: '', active: true),
    BannerModel(imageURL: 'assets/images/featured/paid/JAVA-Interview-Questions.png', targetScreen: '', active: true),
    BannerModel(imageURL: 'assets/images/featured/paid/JAVASCRIPT-1.png', targetScreen: '', active: true),
    BannerModel(imageURL: 'assets/images/featured/paid/Learn-Coding-1.png', targetScreen: '', active: true),
    BannerModel(imageURL: 'assets/images/featured/paid/LinkedIn-cheet-Sheet.png', targetScreen: '', active: true),
  ];

  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', image: 'assets/images/categories/download.jpeg', name: 'SEO', isFeatured: true),
    CategoryModel(id: '2', image: 'assets/images/categories/download.png', name: 'Cloud Computing', isFeatured: true),
    CategoryModel(id: '3', image: 'assets/images/categories/download (1).jpeg', name: 'Web Development', isFeatured: true),
    CategoryModel(id: '4', image: 'assets/images/categories/download (1).png', name: 'Front Development', isFeatured: true),
    CategoryModel(id: '5', image: 'assets/images/categories/download (4).jpeg', name: 'Back Development', isFeatured: true),
    CategoryModel(id: '6', image: 'assets/images/categories/download (3).jpeg', name: 'Programming', isFeatured: true),
  ];
}