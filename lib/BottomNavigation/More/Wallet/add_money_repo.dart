import 'dart:developer';
import 'package:doctoworld_user/BottomNavigation/More/Wallet/add_money_model.dart';
import 'package:doctoworld_user/BottomNavigation/More/Wallet/get_wallet_by_user_repo.dart';
import 'package:doctoworld_user/BottomNavigation/More/Wallet/wallet_page.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/contact_us_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- Add Money repo
addMoneyRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    addMoneyModel = AddMoneyModel.fromJson(response);
    if (addMoneyModel.status == true) {

      Get.find<LoaderController>().updateDataController(true);
      getMethod(context, walletHistoryService,
          {'user_id':storageBox!.read('customerId'), 'user_type': 'customer'}, true, getWalletByUserRepo);

      Get.back();
      print(
          ' Add Money Message------>> ${addMoneyModel.message}');

    } else {
      log('data ' + response.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: addMoneyModel.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {

    print('Email not sent');
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
