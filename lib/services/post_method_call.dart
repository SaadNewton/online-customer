import 'dart:io';

import 'package:dio/dio.dart' as dio_instance;
import 'package:doctoworld_user/services/headers.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';

postMethod(
    BuildContext context,
    String apiUrl,
    dynamic postData,
    bool addAuthHeader,
    Function executionMethod // for performing functionalities
    ) async {
  dio_instance.Response response;
  dio_instance.Dio dio = new dio_instance.Dio();
  dio.options.connectTimeout = 10000;
  dio.options.receiveTimeout = 6000;
  setAcceptHeader(dio);
  setContentHeader(dio);
  //-- if API need headers then this if works and it based on bool value come from function calling
  if (addAuthHeader && storageBox!.hasData('authToken')) {
    setCustomHeader(dio, 'token', '${storageBox!.read('authToken')}');
    setCustomHeader(dio, 'role', 'customer');

    print('token ' + storageBox!.read('authToken'));
  }
  if(apiUrl == fcmService){
    setCustomHeader(dio, 'Content-Type', 'application/json');
    setCustomHeader(dio, 'Authorization', 'key=AAAAduWJyWU:APA91bHVCY3iYxyYWn5P2OokjDdJYQFCm2vCs5y7_X9z8Rsqsgzg_yqZC8MvPZTjfcKBqe1R4tkyqY6uZdwVq9Z-8UR0XKZtkxpiADRbdXa6wxB7UzColblr9JSgfH4qL5AF8VkGxa_a');

  }
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet Connected');
      // Get.find<AppController>().changeInternetCheckerState(true);
      try {
        print('postData--->> ${postData}');
        response = await dio.post(apiUrl, data: postData);
        if (response.statusCode == 200) {
          executionMethod(true, response.data, context);
        } else {
          print(response.data.toString());
          executionMethod(false, null, context);
        }
      } on dio_instance.DioError catch (e) {
        print('Dio Error From Post $apiUrl -->> ${e.response.toString()}');
        executionMethod(false, null, context);
        // messageShowService(response.data,false);
      }
    }
  } on SocketException catch (_) {
    // Get.find<AppController>().changeInternetCheckerState(false);
    print('Internet Not Connected');
  }
}
