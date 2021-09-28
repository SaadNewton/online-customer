import 'package:doctoworld_user/Models/get_all_articles_model.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getAllDoctorsArticlesRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getAllDoctorsArticles = GetAllDoctorsArticles.fromJson(response);
    if (getAllDoctorsArticles.status == true) {
      print('getAllLArticlesRepo ------>> ${getAllDoctorsArticles.data}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}