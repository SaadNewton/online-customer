import 'dart:developer';
import 'package:doctoworld_user/BottomNavigation/More/Order/recent_orders_page.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/contact_us_model.dart';
import 'package:doctoworld_user/Models/prescription_order_status_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- Order Status change
prescriptionOrderStatus(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    prescriptionOrderStatusModel = PrescriptionOrderStatusModel.fromJson(response);
    if (prescriptionOrderStatusModel.status == true) {
      Get.off(RecentOrdersPage());
      // storeDataLocally('user_detail', response);
      // storeDataLocally('session', 'active');
      // storeDataLocally('authToken', userDetailModel.data!.auth!.token);
      // Get.offAll(BottomNavigation());
      print(
          'Order Status Message------>> ${prescriptionOrderStatusModel.message}');

    } else {
      log('data ' + response.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: prescriptionOrderStatusModel.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {

    print('Not Accepted');
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
