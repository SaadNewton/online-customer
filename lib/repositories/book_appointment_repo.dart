// @dart=2.9

import 'package:doctoworld_user/BottomNavigation/Doctors/appointment_booked.dart';
import 'package:doctoworld_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/user_detail_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/auth_controller.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'get_cart_items_repo.dart';

///-------- add to appoint book-data-API-call
bookAppointmentRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if(response['status']){
     Get.off(AppointmentBooked());

    }else{
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: response['message'].toString(),
              text: 'Ok',
              functionCall: () {
                Get.back();
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
    print('cart ------>> $response');
  } else if (!responseCheck && response == null) {

    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}