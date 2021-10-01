import 'dart:developer';

import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

createNotifyRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
log(response.toString());
    if(response['status']){
   getMethod(context, getNotifyTokenService, {'user_id':storageBox!.read('customerId'),
   'role':'customer'}, false, getNotifyTokenRepo);

    }else{
     
    }
    print('cart ------>> $response');
  } else if (!responseCheck && response == null) {



    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}