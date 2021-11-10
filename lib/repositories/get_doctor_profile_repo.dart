import 'package:doctoworld_user/Models/get_doctor_profile_model.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getDoctorProfileRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getDoctorProfileModal = GetDoctorProfileModal.fromJson(response);
    if (getDoctorProfileModal.status == true) {
      Get.find<LoaderController>().getClinicsList = [];
      getDoctorProfileModal.data.clinics.forEach((element) {
        Get.find<LoaderController>().updateGetClinicsList(element.name);
      });
      print('getDoctorProfileRepo ------>> ${getDoctorProfileModal.data}');
    } else {}
  } else if (!responseCheck ) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
  }
}
