import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/get_all_tests_by_category.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-TestsByCategory-data-API-call
getAllTestsByCategoryRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateInnerDataLoader(false);
    getAllTestsByCategory = GetAllTestsByCategory.fromJson(response);
    if (getAllTestsByCategory.status == true) {
      print(
          'get-all_TestsByCategory_data ------>> ${getAllTestsByCategory.data}');
    } else {

    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateInnerDataLoader(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
