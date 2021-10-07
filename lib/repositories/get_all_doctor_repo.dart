// @dart=2.9

import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/get_all_doctors_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-all_Doctors-data-API-call
getAllDoctorsRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  final LoaderController c = Get.put(LoaderController());
  if (responseCheck) {
    allDoctorsModel = GetAllDoctorsModel.fromJson(response);
    if (allDoctorsModel.status == true) {
      Get.find<LoaderController>().doctorsList = [];
      allDoctorsModel.data.data.forEach((element) {
        Get.find<LoaderController>().doctorsList.add(element);
      });
      Get.find<LoaderController>().updateDataController(false);
      print('get-all_Doctors-data ------>> ${allDoctorsModel.data}');
    } else {
      Get.find<LoaderController>().updateDataController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: allDoctorsModel.message,
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
getAllDoctorsRepoMore(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  final LoaderController c = Get.put(LoaderController());
  if (responseCheck) {
    allDoctorsModel = GetAllDoctorsModel.fromJson(response);
    if (allDoctorsModel.status == true) {
      allDoctorsModel.data.data.forEach((element) {
        Get.find<LoaderController>().doctorsList.add(element);
      });
      Get.find<LoaderController>().updateDataController(false);
      print('get-all_Doctors-data ------>> ${allDoctorsModel.data}');
    } else {
      Get.find<LoaderController>().updateDataController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: allDoctorsModel.message,
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
