import 'dart:developer';
import 'package:doctoworld_user/BottomNavigation/appointments_page.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/contact_us_model.dart';
import 'package:doctoworld_user/Models/doctor_rating_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///--------
doctorRatingRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    doctorRatingModel = DoctorRatingModel.fromJson(response);
    if (doctorRatingModel.status == true) {
      Navigator.pop(context, true);
  // storeDataLocally('user_detail', response);
      // storeDataLocally('session', 'active');
      // storeDataLocally('authToken', userDetailModel.data!.auth!.token);
      // Get.offAll(BottomNavigation());
      print(
          'Doctor rating Message Message------>> ${doctorRatingModel.message}');

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'SUCCESS',
              titleColor: customDialogSuccessColor,
              descriptions: doctorRatingModel.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_success.svg',
            );
          });

    } else {
      log('data ' + response.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: doctorRatingModel.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {

    print('Email not sent');
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
