import 'package:doctoworld_user/BottomNavigation/Doctors/doctor_info.dart';
import 'package:doctoworld_user/Models/get_clinic_schedule.dart';
import 'package:doctoworld_user/Models/get_clinics_model.dart';
import 'package:doctoworld_user/Models/get_schedule_model.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

getOnlineClinicsRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);

    Get.find<LoaderController>().getScheduleModel = GetScheduleModel.fromJson(response);
    if (Get.find<LoaderController>().getScheduleModel.status == true) {
      getDayList();
      print('getOnlineClinicsRepo ------>> ${Get.find<LoaderController>().getScheduleModel.data}');
    } else {}
  } else if (!responseCheck ) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
  }
}
// getOnSiteClinicsRepo(
//     bool responseCheck, Map<String, dynamic> response, BuildContext context) {
//   if (responseCheck) {
//     Get.find<LoaderController>().updateDataController(false);
//     Get.find<LoaderController>().updateFormController(false);
//     Get.find<LoaderController>().getScheduleModel = GetScheduleModel.fromJson(response);
//     if (Get.find<LoaderController>().getScheduleModel.status == true) {
//
//     } else {}
//   } else if (!responseCheck ) {
//     Get.find<LoaderController>().updateDataController(false);
//     Get.find<LoaderController>().updateFormController(false);
//
//     print('Exception........................');
//   }
// }
//
// getOnSiteClinicsScheduleRepo(
//     bool responseCheck, Map<String, dynamic> response, BuildContext context) {
//   if (responseCheck) {
//     Get.find<LoaderController>().updateDataController(false);
//     Get.find<LoaderController>().updateFormController(false);
//     Get.find<LoaderController>().getOnSiteClinicScheduleModel = GetClinicSchedule.fromJson(response);
//     if (Get.find<LoaderController>().getOnSiteClinicScheduleModel.status == true) {
//       Get.find<LoaderController>().onSiteScheduleDateIndex = 0;
//       Get.find<LoaderController>().getOnSiteScheduleDateList = [];
//       Get.find<LoaderController>().getOnSiteClinicScheduleModel.data.availableSlots
//           .forEach((element) {
//             print('---DATE--->>${element.date.date}');
//             DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(element.date.date);
//
//             print('---DATE--->>${tempDate}');
//             if(tempDate.isBefore(DateTime.now()) ){
//               print('BEFORE--->>>');
//             }else{
//               Get.find<LoaderController>().updateOnSiteScheduleDateList(
//                   element.date.date.toString()
//               );
//             }
//
//       });
//
//
//       print('getOnSiteClinicsScheduleRepo ------>> ${Get.find<LoaderController>().getOnSiteClinicScheduleModel.data}');
//     } else {}
//   } else if (!responseCheck && response == null) {
//     Get.find<LoaderController>().updateDataController(false);
//     Get.find<LoaderController>().updateFormController(false);
//
//     print('Exception........................');
//     // Get.find<AppController>().changeServerErrorCheck(true);
//   }
// }