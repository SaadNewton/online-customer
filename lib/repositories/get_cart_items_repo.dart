// @dart=2.9

import 'package:doctoworld_user/Components/custom_dialog.dart';

import 'package:doctoworld_user/Models/get_cart_items_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/cart_controller.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-all_CartItems-data-API-call
getAllCartItemsRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
Get.put(CartController());
    Get.find<LoaderController>().updateCartDataController(false);
    getCartItemsModel = GetCartItemsModel.fromJson(response);
    if (getCartItemsModel.status == true) {
      int totalPrice=0;
      getCartItemsModel.data.forEach((element) {

         totalPrice+=int.tryParse(element.price)*int.tryParse(element.qty);
         print('price '+totalPrice.toString());
      });
Get.find<CartController>().updateCartValue(totalPrice);
      print('get-all_CartItems-data ------>> ${getCartItemsModel.data}');
    } else {

    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateCartDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
