import 'dart:developer';

import 'package:doctoworld_user/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/user_detail_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-login-data-API-call
getLoginData(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    userDetailModel = UserDetailModel.fromJson(response);
    if (userDetailModel.status == true) {
      storeDataLocally('user_detail', response);
      storeDataLocally('session', 'active');
      storeDataLocally('authToken', userDetailModel.data.auth.token);
      Get.offAll(BottomNavigation());
      print('getLogin UserData ------>> ${userDetailModel.data}');
    } else {
      log('data ' + response.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: userDetailModel.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
