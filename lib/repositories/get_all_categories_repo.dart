// @dart=2.9

import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/all_categories_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-all_categories-data-API-call
getAllCategoriesRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  final LoaderController c = Get.put(LoaderController());
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    allCategoriesModel = AllCategoriesModel.fromJson(response);
    if (allCategoriesModel.status == true) {
      print('get-all_categories-data ------>> ${allCategoriesModel.data}');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: allCategoriesModel.message,
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
