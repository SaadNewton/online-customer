import 'dart:ui';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Doctors/doctor_info.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:get/get.dart';

class DoctorMapView extends StatefulWidget {
  @override
  _DoctorMapViewState createState() => _DoctorMapViewState();
}

class SearchDoctorTile {
  String image;
  String name;
  String speciality;
  String hospital;
  String experience;
  String fee;
  String reviews;

  SearchDoctorTile(this.image, this.name, this.speciality, this.hospital,
      this.experience, this.fee, this.reviews);
}

class _DoctorMapViewState extends State<DoctorMapView> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<SearchDoctorTile> searchList = [
      SearchDoctorTile('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '22', '30', '152'),
      SearchDoctorTile('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22', '30', '201'),
      SearchDoctorTile('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '22', '30', '135'),
      SearchDoctorTile('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '22', '30', '438'),
      SearchDoctorTile('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '22', '30', '152'),
      SearchDoctorTile('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22', '30', '201'),
      SearchDoctorTile('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '22', '30', '135'),
      SearchDoctorTile('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '22', '30', '438'),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: FadedScaleAnimation(
          Text(
            locale.mapView! + '\"' + locale.cardio! + '\"',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
          ),
          durationInMilliseconds: 400,
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/map.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            child: FadedScaleAnimation(
              Image.asset('assets/Doctors/doc1.png'),
              durationInMilliseconds: 400,
            ),
            top: 200,
            start: 300,
            height: 50,
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            child: FadedScaleAnimation(
              Image.asset('assets/Doctors/doc2.png'),
              durationInMilliseconds: 400,
            ),
            top: 300,
            start: 220,
            height: 50,
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            child: FadedScaleAnimation(
              Image.asset('assets/Doctors/doc3.png'),
              durationInMilliseconds: 400,
            ),
            top: 350,
            start: 70,
            height: 50,
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            child: FadedScaleAnimation(
              Image.asset('assets/Doctors/doc4.png'),
              durationInMilliseconds: 400,
            ),
            top: 450,
            start: 350,
            height: 50,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 132,
              margin: EdgeInsets.only(bottom: 30),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(DoctorInfo());
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 400,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 18.0),
                              child: GestureDetector(
                                onTap: () {
                                 Get.to(DoctorInfo());
                                },
                                child: Row(
                                  children: [
                                    FadedScaleAnimation(
                                      Image.asset(
                                        searchList[index].image,
                                        height: 80,
                                        width: 80,
                                      ),
                                      durationInMilliseconds: 400,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 12,
                                        ),
                                        RichText(
                                            text: TextSpan(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                                children: <TextSpan>[
                                              TextSpan(
                                                  text: searchList[index].name +
                                                      '\n',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1),
                                              TextSpan(
                                                text: searchList[index]
                                                    .speciality,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .disabledColor,
                                                        fontSize: 12),
                                              ),
                                              TextSpan(
                                                text: locale.at,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: kButtonTextColor,
                                                        fontSize: 10),
                                              ),
                                              TextSpan(
                                                text:
                                                    searchList[index].hospital,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .disabledColor,
                                                        fontSize: 12),
                                              ),
                                            ])),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              locale.exp!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: 12),
                                            ),
                                            Text(
                                              searchList[index].experience +
                                                  locale.years!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              locale.fee!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: 12),
                                            ),
                                            Text(
                                              '\$' + searchList[index].fee,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: 35,
                                            ),
                                            RatingBar.builder(
                                                itemSize: 12,
                                                initialRating: 4,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                }),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '(${searchList[index].reviews})',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontSize: 10,
                                                      color: Theme.of(context)
                                                          .disabledColor),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
    );
  }
}
