// @dart=2.9

import 'package:doctoworld_user/Components/custom_dialog.dart';

import 'package:doctoworld_user/Models/get_all_orders_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-all_Orders-data-API-call
getAllOrdersRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  final LoaderController c = Get.put(LoaderController());
  print('bk is heree');
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getAllOrdersModel = GetAllOrdersModel.fromJson(response);
    if (getAllOrdersModel.status == true) {
      print('get-all_Orderss-data ------>> ${getAllOrdersModel.data}');
    } else {

    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
