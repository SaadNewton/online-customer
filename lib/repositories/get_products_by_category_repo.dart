// @dart=2.9

import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/get_product_by_category_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///--------get-Products-By-Category-data-API-call
getProductsByCategoryRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    getProductsByCategoryModel = GetProductByCategoryModel.fromJson(response);

    if (getProductsByCategoryModel.status == true) {
      Get.find<LoaderController>().medicineList = [];
      getProductsByCategoryModel.data.data.forEach((element) {
        Get.find<LoaderController>().medicineList.add(element);
      });
      Get.find<LoaderController>().updateDataController(false);
      print('get-Products-By-Category-data ------>> ${getProductsByCategoryModel.data}');
    } else {
      Get.find<LoaderController>().updateDataController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: getProductsByCategoryModel.message,
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
getProductsByCategoryRepoMore(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    getProductsByCategoryModel = GetProductByCategoryModel.fromJson(response);

    if (getProductsByCategoryModel.status == true) {
      getProductsByCategoryModel.data.data.forEach((element) {
        Get.find<LoaderController>().medicineList.add(element);
      });
      Get.find<LoaderController>().updateDataController(false);
      print('get-Products-By-Category-data ------>> ${getProductsByCategoryModel.data}');
    } else {
      Get.find<LoaderController>().updateDataController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: getProductsByCategoryModel.message,
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
