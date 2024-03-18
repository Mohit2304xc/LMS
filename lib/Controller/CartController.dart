import 'package:dummy1/Model/CartModel.dart';
import 'package:dummy1/Model/CourseModel.dart';
import 'package:dummy1/Widgets/Services/LocalStorage.dart';
import 'package:dummy1/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxDouble discountedPrice = 0.0.obs;
  RxInt courseQuantityInCart = 0.obs;
  RxList<CartModel> cartItems = <CartModel>[].obs;

  CartController(){
    loadCartItems();
  }

  void addOneItemToCart(CartModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.courseId == item.courseId);
    if(index>=0){
      cartItems[index].quantity +=1;
    } else{
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneItemToCart(CartModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.courseId == item.courseId);
    if(index >= 0){
      if(cartItems[index].quantity > 1){
        cartItems[index].quantity -= 1;
      } else{
        cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index){
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are You sure you want to remove this product?',
      onConfirm: (){
        cartItems.removeAt(index);
        updateCart();
        SnackBars.customToast(message: 'Product has been removed from the Cart');
        Get.back();
      },
      onCancel: () => () => Get.back(),
      confirmTextColor: Colors.red,
      cancelTextColor: Colors.grey,
    );
  }

  //Add items to Cart
  void addToCart(CourseModel course) {
    //quantity Check
    if (courseQuantityInCart.value < 1) {
      SnackBars.customToast(message: 'Select Quantity');
      return;
    }
    final selectedCartItems = convertToCartItem(course,courseQuantityInCart.value );
    //check if already added in the cart
    int index = cartItems.indexWhere((cartItem) => cartItem.courseId == selectedCartItems.courseId);

    if(index >= 0){
      cartItems[index].quantity = selectedCartItems.quantity;
    } else{
      cartItems.add(selectedCartItems);
    }

    updateCart();
    SnackBars.customToast(message: 'Your Course has been Added to the Cart');
  }

  //Update Cart values
  void updateCart(){
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void saveCartItems(){
    final cartItemString = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems',cartItemString);
  }

  void updateCartTotals(){
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for(var item in cartItems){
      calculatedTotalPrice +=(item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void updateFinalAmount(double discount){
    discountedPrice.value = discount;
  }

  void loadCartItems(){
    final cartItemStrings = TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if(cartItemStrings != null){
      cartItems.assignAll(cartItemStrings.map((item) => CartModel.fromJson(item as Map<String,dynamic>)));
      updateCartTotals();
    }
  }

  void clearCart(){
    courseQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  int getProductQuantityInCart(String courseId){
    final foundItem = cartItems.where((item) => item.courseId == courseId).fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }



  //Convert CourseModel to cartModel
  CartModel convertToCartItem(CourseModel course, int quantity) {
    final price = course.salePrice > 0.0 ? course.salePrice : course.price;
    return CartModel(
      courseId: course.id,
      quantity: quantity,
      price: price,
      image: course.thumbnail,
      title: course.title,
    );
  }

  void updateAlreadyAddedCourseCount(CourseModel course){
    courseQuantityInCart.value = getProductQuantityInCart(course.id);
  }
}
