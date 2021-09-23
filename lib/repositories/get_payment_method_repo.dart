// @dart=2.9

import 'package:doctoworld_user/Components/custom_dialog.dart';

import 'package:doctoworld_user/Models/get_cart_items_model.dart';
import 'package:doctoworld_user/Models/get_payment_method_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-all_PaymentMethods-data-API-call
getAllPaymentMethodsRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  final LoaderController c = Get.put(LoaderController());
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getPaymentMethodModel = GetPaymentMethodModel.fromJson(response);
    if (getPaymentMethodModel.status == true) {
      print('get-all_PaymentMethods-data ------>> ${getPaymentMethodModel.data}');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: getPaymentMethodModel.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
