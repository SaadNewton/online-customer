import 'package:get/get.dart';

class CartController extends GetxController{
   /// cart total
  ///
  double cartTotalPrice=0.0;

  updateCartValue(double value){
cartTotalPrice=value;
update();
  }
}