// @dart=2.9

import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/get_doctor_categories.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-all_DoctorCategories-data-API-call
getAllDoctorCategoriesRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  LoaderController controller = Get.put(LoaderController());
  if (responseCheck) {
    Get.find<LoaderController>().doctorCategoryCheck(false);
    getDoctorCategories = GetDoctorCategories.fromJson(response);
    if (getDoctorCategories.status == true) {
      print(
          'get-all_DoctorCategories-data ------>> ${getDoctorCategories.data}');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: getDoctorCategories.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().doctorCategoryCheck(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
