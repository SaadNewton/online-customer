import 'dart:developer';

import 'package:doctoworld_user/BottomNavigation/Doctors/doctor_info.dart';
import 'package:doctoworld_user/BottomNavigation/appointments_page.dart';
import 'package:doctoworld_user/BottomNavigation/doctors_page.dart';
import 'package:doctoworld_user/BottomNavigation/labs_page.dart';
import 'package:doctoworld_user/BottomNavigation/more_options.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/repositories/create_notify_repo.dart';
import 'package:doctoworld_user/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'medicine_find_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  double start = 0;

  final List<Widget> _children = [
    MedicinePage(),
    DoctorsHome(),
    LabsHome(),
    AppointmentPage(),
    MoreOptions(),
  ];
String? fcmToken;
  updateToken() async {

      await FirebaseMessaging.instance.getToken().then((value) {
        fcmToken = value;
        storageBox!.write('fcmToken', fcmToken);
        log(" token >>>> $fcmToken");
      });
      postMethod(context, createNotifyUserService, {'role':'customer',
        'user_id':storageBox!.read('customerId'),
        'token':fcmToken
      }, false, createNotifyRepo);
    }

  @override
  void initState() {
    forCustomer=true;
    // TODO: implement initState
    updateToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<BottomNavigationBarItem> _bottomBarItems = [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_medicine.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_medicineact.png')),
        label: locale.medicine,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_doctors.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_doctorsact.png')),
        label: locale.doctors,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_hospitals.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_hospitalsact.png')),
        label: 'Labs',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_appointments.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_appointmentsact.png')),
        label: locale.appointments,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_more.png')),
        activeIcon: ImageIcon(AssetImage('assets/FooterIcons/ic_moreact.png')),
        label: locale.more,

      ),
    ];
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(loaderController)=> WillPopScope(
        onWillPop: ()async{
          if(loaderController.currentIndex != 0){
            loaderController.changeCurrentIndexCheck(0);
            return false;
          }else{
            return true;
          }
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              _children[loaderController.currentIndex],
              // AnimatedPositionedDirectional(
              //   bottom: 0,
              //   start: start,
              //   child: Container(
              //     color: Theme.of(context).primaryColor,
              //     height: 2,
              //     width: MediaQuery.of(context).size.width / 5,
              //   ),
              //   duration: Duration(milliseconds: 200),
              // ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: loaderController.currentIndex,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 20.0,
            type: BottomNavigationBarType.fixed,
            iconSize: 22.0,
            selectedItemColor: Theme.of(context).primaryColor,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            unselectedItemColor: Theme.of(context).disabledColor,
            items: _bottomBarItems,
            onTap: (int index) {
              setState(() {
                loaderController.currentIndex = index;
                loaderController.changeCurrentIndexCheck(index);
                start = MediaQuery.of(context).size.width *
                    index /
                    _bottomBarItems.length;
              });
            },
          ),
        ),
      ),
    );
  }
}
