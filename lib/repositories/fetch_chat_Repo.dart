//-------- get-chat-API-call
import 'package:doctoworld_user/Models/fetch_chat_model.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

fetchChatRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    fetchChatModel = FetchChatModel.fromJson(response);
    Get.find<LoaderController>().emptyMessageList();
    fetchChatModel.data!.forEach((element) {
      Get.find<LoaderController>().updateMessageList(element);
    });
    Get.find<LoaderController>().updateDataController(false);
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}