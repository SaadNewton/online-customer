import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/get_doctors_by_category_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-all_Doctors-data-API-call
getDoctorsByCategoryRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  final LoaderController c = Get.put(LoaderController());
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getDoctorsByCategoryModel = GetDoctorsByCategoryModel.fromJson(response);
    if (getDoctorsByCategoryModel.status == true) {
      print('get-all_Doctors-data ------>> ${getDoctorsByCategoryModel.data}');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: getDoctorsByCategoryModel.message,
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
