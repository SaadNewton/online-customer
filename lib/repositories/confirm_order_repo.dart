import 'dart:developer';

import 'package:doctoworld_user/BottomNavigation/Medicine/order_placed_page.dart';
import 'package:doctoworld_user/BottomNavigation/More/Order/order_info.dart';
import 'package:doctoworld_user/BottomNavigation/More/Order/recent_orders_page.dart';
import 'package:doctoworld_user/Checkout/confirm_order.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/order_card_model.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- add to cart-data-API-call
///m
bool? orderTypeMedicine;
methodEmpty(){}
confirmOrderRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    log(response.toString());
    Get.find<LoaderController>().updateFormController(false);
    if(response['status']){
      currentTabIndex=2;
      if(orderTypeMedicine==false){
        postMethod(
            context,
            fcmService,
            {
              'notification': <String, dynamic>{
                'body': 'Here is a lab test!',
                'title': 'Doctor Online'
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'channel': Get.find<LoaderController>().agoraModel.channelName,
                'channel_token': Get.find<LoaderController>().agoraModel.token,
                'routeWeb': '/customer/approved/appointment/detail',
                'routeApp':'/labOrders',
              },
              'to': Get.find<LoaderController>().otherRoleToken,
            },
            false,
            methodEmpty
        );
      }

    }else{
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: response['message'].toString(),
              text: 'Ok',
              functionCall: () {
                Get.back();
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
    print('confirm order ------>> $response');
  } else if (!responseCheck && response == null) {

    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}