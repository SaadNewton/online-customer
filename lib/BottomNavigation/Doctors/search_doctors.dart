import 'dart:core';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchDoctors extends StatefulWidget {
  @override
  _SearchDoctorsState createState() => _SearchDoctorsState();
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

class _SearchDoctorsState extends State<SearchDoctors> {
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
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 14, right: 14),
              child: TextFormField(
                initialValue: 'Surgeon',
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    hintText: locale.searchDoc,
                    filled: true,
                    fillColor: Theme.of(context).backgroundColor,
                    prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PageRoutes.searchHistoryPage);
                      },
                    )),
              ),
            ),
            Container(
              color: Theme.of(context).backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              margin: EdgeInsets.only(top: 15),
              child: Text(
                '27 ' + locale.resultsFound!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 18.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.doctorInfo);
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
                                                    .speciality),
                                            TextSpan(text: locale.at),
                                            TextSpan(
                                                text:
                                                    searchList[index].hospital),
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
                                            width: 12,
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 6,
                            thickness: 6,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ],
                      ),
                      PositionedDirectional(
                        bottom: 28,
                        end: 4,
                        child: Row(
                          children: [
                            RatingBar.builder(
                                itemSize: 12,
                                initialRating: 4,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
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
                                      color: Theme.of(context).disabledColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );

                  /*ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                leading: Image.asset('assets/Doctors/doc1.png', height: 100,),
                title: RichText( text: TextSpan(style: Theme.of(context).textTheme.subtitle2, children: <TextSpan>[
                  TextSpan(text: 'Dr. Joseph Williamson\n', style: Theme.of(context).textTheme.subtitle1),
                  TextSpan(text: 'Cardiac Surgeon'),
                  TextSpan(text: ' at '),
                  TextSpan(text: 'Apple Hospital'),
                ])),
                subtitle: Row(children: [
                  Text('Exp. '),
                  Text('22 years'),
                  Spacer(),
                  Text('Fees '),
                  Text('\$30'),
                  Spacer(flex: 2,),
                  RatingBar(
                    itemSize: 12,
                      initialRating: 4,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating){
                    print(rating);
                  })
                ],),
              );*/
                })
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
