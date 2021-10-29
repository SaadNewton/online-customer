import 'package:doctoworld_user/Models/get_doctor_from_search_model.dart';
import 'package:doctoworld_user/Models/get_lab_from_search.dart';
import 'package:doctoworld_user/Models/get_medicine_from_search_model.dart';
import 'package:doctoworld_user/Models/labs_tests_search_model.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getMedicineFromSearchRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().getMedicineFromSearchModel = GetMedicineFromSearchModel.fromJson(response);
    if (Get.find<LoaderController>().getMedicineFromSearchModel.status == true) {
      print('getMedicineFromSearchRepo ------>> ${Get.find<LoaderController>().getMedicineFromSearchModel.message}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}

doctorSearchRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().getDoctorFromSearchModel = GetDoctorFromSearchModel.fromJson(response);
    if (Get.find<LoaderController>().getDoctorFromSearchModel.status == true) {
      print('doctorSearchRepo ------>> ${Get.find<LoaderController>().getDoctorFromSearchModel.message}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}

getAllLabTestsSearchRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().labsTestsSearchModel = LabsTestsSearchModel.fromJson(response);
    if (Get.find<LoaderController>().labsTestsSearchModel.status == true) {
      print('getMedicineFromSearchRepo ------>> ${Get.find<LoaderController>().labsTestsSearchModel.message}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}



labSearchRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().getLabFromSearch = GetLabFromSearch.fromJson(response);
    if (Get.find<LoaderController>().getLabFromSearch.status == true) {
      print('labSearchRepo ------>> ${Get.find<LoaderController>().getLabFromSearch.message}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}