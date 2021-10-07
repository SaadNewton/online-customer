// @dart = 2.9
import 'dart:developer';

import 'package:doctoworld_user/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/repositories/login_repo.dart';
import 'package:doctoworld_user/repositories/sign_up_repo.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


String verificationIDForVerify;
Future<bool> otpFunction(String phone, BuildContext context,) async {
  print('otpFunction');
  FirebaseAuth _auth = FirebaseAuth.instance;
  _auth.verifyPhoneNumber(
    phoneNumber: phone,
    timeout: Duration(seconds: 55),
    verificationCompleted: (AuthCredential credential) async {
      // method();

      print('Credential from verificationCompleted ---->> ${credential}');
    },
    verificationFailed: (FirebaseAuthException exception) {
      // method();
      print('Exception ---->> ${exception.message}');

    },
    codeSent: (String verificationId, [int forceResendingToken]) {
      // method();
      verificationIDForVerify = verificationId;
      log('verificationId ---->> ${verificationId}');
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}



verifyOTP(BuildContext context,var otp,bool fromSignUp,postData) async {
  print('verify');
  try {
    AuthCredential credential = PhoneAuthProvider.credential(

      verificationId: verificationIDForVerify, smsCode: otp,);

    User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    Get.find<LoaderController>().updateFormController(false);
    if (user != null) {
      print('user added by otp');

      if(fromSignUp){
        postMethod(context, customerSignUpService, postData, true, getSignUpUserData ) ;
      }else{
        postMethod(context, loginWithPhone, postData, true, getLoginData) ;
      }

    } else {
      print("Error");
    }
    print('Credential ---->> ${credential}');
  } catch (e) {
    Get.find<LoaderController>().updateFormController(false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'FAILED!',
            titleColor: customDialogErrorColor,
            descriptions: '${e.code}',
            text: 'Ok',
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/dialog_error.svg',
          );
        });
    print('Exception --->> ${e.code}');
  }
}