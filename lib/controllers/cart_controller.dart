import 'package:get/get.dart';

class CartController extends GetxController{
   /// cart total
  ///
  var cartTotalPrice=0.obs;

  updateCartValue(int value){
cartTotalPrice.value=value;
update();
  }
}