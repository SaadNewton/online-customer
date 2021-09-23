import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Doctors/list_of_doctors.dart';
import 'package:doctoworld_user/BottomNavigation/Medicine/medicines.dart';
import 'package:doctoworld_user/BottomNavigation/labs_page.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(locale.saved!),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).hintColor.withOpacity(0.4),
            labelStyle: Theme.of(context).textTheme.subtitle1,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(text: locale.medicine),
              Tab(text: locale.doctors),
              Tab(text: locale.hospitals),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FadedSlideAnimation(
              Medicines(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
            FadedSlideAnimation(
              DoctorsList(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
            FadedSlideAnimation(
              LabsHome(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
          ],
        ),
      ),
    );
  }
}
