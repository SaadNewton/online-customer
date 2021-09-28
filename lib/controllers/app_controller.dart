import 'package:get/get.dart';

class AppController extends GetxController {
  ///-------------------------------internet-check
  bool internetChecker = true;
  changeInternetCheckerState(bool value) {
    internetChecker = value;
    update();
  }

  ///-------------------------------server-check
  bool serverErrorCheck = true;
  changeServerErrorCheck(bool value) {
    serverErrorCheck = value;
    update();
  }



}
