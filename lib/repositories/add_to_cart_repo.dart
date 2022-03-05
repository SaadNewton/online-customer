import 'package:doctoworld_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/user_detail_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/auth_controller.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'get_cart_items_repo.dart';

///-------- add to cart-data-API-call
addToCartRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  Get.find<LoaderController>().updateFormController(false);

  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
  if(response['status']){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'Success',
            titleColor: customDialogSuccessColor,
            descriptions: response['message'].toString(),
            text: 'Ok',
            functionCall: () {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Get.find<LoaderController>().updateDataController(true);

              });
              Get.back();
              getMethod(context, getCartProductsService,
                  {'customer_id':storageBox!.read('customerId')}, true, getAllCartItemsRepo);
              Get.to(CartPage());

            },
            img: 'assets/dialog_success.svg',
          );
        });
  }else{
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'FAILED!',
            titleColor: customDialogErrorColor,
            descriptions: response['message'].toString(),
            text: 'Ok',
            functionCall: () {
             Get.back();
            },
            img: 'assets/dialog_error.svg',
          );
        });
  }
    print('cart ------>> $response');
  } else if (!responseCheck && response == null) {

    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}