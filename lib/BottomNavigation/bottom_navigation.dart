import 'package:doctoworld_user/BottomNavigation/appointments_page.dart';
import 'package:doctoworld_user/BottomNavigation/doctors_page.dart';
import 'package:doctoworld_user/BottomNavigation/labs_page.dart';
import 'package:doctoworld_user/BottomNavigation/more_options.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
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

  @override
  void initState() {
    // TODO: implement initState

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
