// @dart=2.9

import 'package:doctoworld_user/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_user/Models/user_detail_model.dart';
import 'package:doctoworld_user/controllers/auth_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

///-------- get-Sign up-data-API-call
getSignUpUserData(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<AuthController>().changeSignUpCheckerState(true);
    userDetailModel = UserDetailModel.fromJson(response);
    print('getSignUpUserData ------>> ${userDetailModel.data.phone}');
    Get.offAll(BottomNavigation());
    storageBox.write('session', 'true');
  } else if (!responseCheck && response == null) {
    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
