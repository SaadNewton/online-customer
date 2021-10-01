import 'package:doctoworld_user/Models/get_clinic_schedule.dart';
import 'package:doctoworld_user/Models/get_clinics_model.dart';
import 'package:doctoworld_user/Models/get_online_schedule.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

getOnlineClinicsRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);
    Get.find<LoaderController>().getOnlineSchedule = GetClinicSchedule.fromJson(response);
    if (Get.find<LoaderController>().getOnlineSchedule.status == true) {
      Get.find<LoaderController>().onlineScheduleDateIndex = 0;
      Get.find<LoaderController>().getOnlineScheduleDateList = [];
      Get.find<LoaderController>().getOnlineSchedule.data.availableSlots.forEach((element) {
        Get.find<LoaderController>().updateOnlineScheduleDateList(
            element.date.date.toString()
        );
      });
      print('getOnlineClinicsRepo ------>> ${Get.find<LoaderController>().getOnlineSchedule.data}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
getOnSiteClinicsRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);
    Get.find<LoaderController>().getOnSiteClinicsModel = GetClinicsModel.fromJson(response);
    if (Get.find<LoaderController>().getOnSiteClinicsModel.status == true) {
      Get.find<LoaderController>().getClinicsList = [];
      Get.find<LoaderController>().getOnSiteClinicsModel.data.forEach((element) {
        Get.find<LoaderController>().updateGetClinicsList(element.name);
      });
      print('getOnSiteClinicsRepo ------>> ${Get.find<LoaderController>().getOnSiteClinicsModel.data}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}

getOnSiteClinicsScheduleRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);
    Get.find<LoaderController>().getOnSiteClinicScheduleModel = GetClinicSchedule.fromJson(response);
    if (Get.find<LoaderController>().getOnSiteClinicScheduleModel.status == true) {
      Get.find<LoaderController>().onSiteScheduleDateIndex = 0;
      Get.find<LoaderController>().getOnSiteScheduleDateList = [];
      Get.find<LoaderController>().getOnSiteClinicScheduleModel.data.availableSlots.forEach((element) {
        Get.find<LoaderController>().updateOnSiteScheduleDateList(
            element.date.date.toString()
        );
      });


      print('getOnSiteClinicsScheduleRepo ------>> ${Get.find<LoaderController>().getOnSiteClinicScheduleModel.data}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}