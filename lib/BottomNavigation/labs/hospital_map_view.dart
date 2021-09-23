import 'dart:ui';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HospitalMapView extends StatefulWidget {
  @override
  _HospitalMapViewState createState() => _HospitalMapViewState();
}

class HospitalDetail {
  String image;
  String name;
  String type;
  String location;

  HospitalDetail(this.image, this.name, this.type, this.location);
}

final List<String> categories = [
  'assets/DoctorCategory/Doctors.png',
  'assets/DoctorCategory/Dentists.png',
  'assets/DoctorCategory/Ayurvadic.png',
  'assets/DoctorCategory/Therapist.png',
  'assets/DoctorCategory/Doctors.png',
  'assets/DoctorCategory/Dentists.png',
  'assets/DoctorCategory/Ayurvadic.png',
  'assets/DoctorCategory/Therapist.png',
];

class _HospitalMapViewState extends State<HospitalMapView> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<HospitalDetail> _hospitals = [
      HospitalDetail('assets/ProfilePics/dp1.png', 'Apple Hospital',
          'General Hospital', 'Walter street, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'City Light Eye Care',
          'General Hospital', 'Jespora Bridge, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'Silver Soul Hospital',
          'General Hospital', 'Walter street, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'Apple Hospital',
          'General Hospital', 'Walter street, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'City Light Eye Care',
          'General Hospital', 'Jespora Bridge, Wallington, New York.'),
      HospitalDetail('assets/ProfilePics/dp1.png', 'Silver Soul Hospital',
          'General Hospital', 'Walter street, Wallington, New York.'),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          locale.hospitalsNearYou!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
        ),
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Image.asset(
              'assets/map.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 100,
              start: 250,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 200,
              start: 70,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 200,
              start: 300,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin_act.png'),
                durationInMilliseconds: 400,
              ),
              top: 300,
              start: 220,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 350,
              start: 70,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 400,
              start: 200,
              height: 50,
            ),
            Positioned.directional(
              textDirection: TextDirection.ltr,
              child: FadedScaleAnimation(
                Image.asset('assets/map_pin.png'),
                durationInMilliseconds: 400,
              ),
              top: 450,
              start: 350,
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 123.3,
                margin: EdgeInsets.only(bottom: 30),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _hospitals.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PageRoutes.labInfo);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 20),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 400,
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 16),
                                title: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _hospitals[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 23, height: 1.5),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              _hospitals[index].type,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      height: 1.5),
                                            ),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Icon(
                                              Icons.call,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 13,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              locale.callNow!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14, right: 16.0, top: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Theme.of(context).disabledColor,
                                      size: 13,
                                    ),
                                    Text(
                                      _hospitals[index].location,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .disabledColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
//done
