import 'package:doctoworld_user/Models/get_all_appointments_model.dart';
import 'package:doctoworld_user/Models/get_all_orders_model.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-appointments-data-API-call
getAllAppointmentsRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  final LoaderController c = Get.put(LoaderController());

  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getAllAppointmentsModel = GetAllAppointmentsModel.fromJson(response);
    if (getAllOrdersModel.status == true) {
      print('get-appointments-data ------>> ${getAllOrdersModel.data}');
    } else {

    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}