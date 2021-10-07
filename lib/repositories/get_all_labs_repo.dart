// @dart=2.9

import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/get_all_labs_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/controllers/location_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-labs-data-API-call
getAllLabsRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    getAllLabsModel = GetAllLabsModel.fromJson(response);
    if (getAllLabsModel.status == true) {

      Get.find<LocationController>().loadMore = false;
      Get.find<LocationController>().labsList = [];
      getAllLabsModel.data.data.forEach((element) {
        Get.find<LocationController>().labsList.add(
          element
        );
      });
      Get.find<LoaderController>().updateDataController(false);
      print('get-all_labs_data ------>> ${getAllLabsModel.data}');
    } else {
      Get.find<LoaderController>().updateDataController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: getAllLabsModel.message,
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


getAllLabsRepoMore(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    getAllLabsModel = GetAllLabsModel.fromJson(response);
    if (getAllLabsModel.status == true) {

      Get.find<LocationController>().loadMore = false;
      getAllLabsModel.data.data.forEach((element) {
        Get.find<LocationController>().labsList.add(
            element
        );
      });
      Get.find<LoaderController>().updateDataController(false);
      print('get-all_labs_data ------>> ${getAllLabsModel.data}');
    } else {
      Get.find<LoaderController>().updateDataController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: getAllLabsModel.message,
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