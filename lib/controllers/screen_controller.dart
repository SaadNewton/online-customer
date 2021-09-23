import 'package:doctoworld_user/Auth/Login/UI/login_ui.dart';
import 'package:doctoworld_user/Auth/phone_auth.dart';
import 'package:doctoworld_user/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';

class ScreenController extends StatefulWidget {
  @override
  _ScreenControllerState createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  @override
  Widget build(BuildContext context) {
    if (storageBox!.read('session') == 'active') {
      return BottomNavigation();
    } else if (storageBox!.read('session') == 'inactive') {
      return PhoneAuthUI();
    } else {
      return PhoneAuthUI();
    }
  }
}
