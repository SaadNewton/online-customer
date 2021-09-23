import 'dart:core';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SortFilter extends StatefulWidget {
  @override
  _SortFilterState createState() => _SortFilterState();
}

enum RadioList { consultancyfee, ratings, distance }

class _SortFilterState extends State<SortFilter> {
  RadioList? _character = RadioList.consultancyfee;
  String? _selectedRadioButton = 'Consultancy fees';
  RangeValues _currentRangeValues = RangeValues(40, 80);
  bool? maleValue = false;
  bool? femaleValue = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(locale.sortFilter!),
        textTheme: Theme.of(context).textTheme,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _character = RadioList.consultancyfee;
                _selectedRadioButton = locale.consultancyFees;
                maleValue = false;
                femaleValue = false;
                _currentRangeValues = RangeValues(40, 80);
              });
            },
            child: Text(
              locale.reset!,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
            ),
          ),
        ],
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              color: Theme.of(context).backgroundColor,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            locale.sortBy!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 20),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            locale.consultancyFees!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 20),
                          ),
                          trailing: Radio(
                            activeColor: Colors.amber,
                            value: RadioList.consultancyfee,
                            groupValue: _character,
                            onChanged: (RadioList? value) {
                              setState(() {
                                _character = value;
                                _selectedRadioButton = locale.consultancyFees;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            locale.rating!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 20),
                          ),
                          trailing: Radio(
                            activeColor: Colors.amber,
                            value: RadioList.ratings,
                            groupValue: _character,
                            onChanged: (RadioList? value) {
                              setState(() {
                                _character = value;
                                _selectedRadioButton = locale.rating;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            locale.distance!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 20),
                          ),
                          trailing: Radio(
                            activeColor: Colors.amber,
                            value: RadioList.distance,
                            groupValue: _character,
                            onChanged: (RadioList? value) {
                              setState(() {
                                _character = value;
                                _selectedRadioButton = locale.distance;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            _selectedRadioButton!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 20),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              '1 \$',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 20),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              '100 \$',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbColor: Colors.amber,
                              activeTrackColor: Theme.of(context).primaryColor),
                          child: RangeSlider(
                            inactiveColor: Theme.of(context).backgroundColor,
                            values: _currentRangeValues,
                            min: 1,
                            max: 100,
                            divisions: 99,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            locale.gender!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 20),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            // [Monday] checkbox
                            SizedBox(
                              width: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: maleValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      maleValue = value;
                                    });
                                  },
                                ),
                                Text(
                                  locale.male!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            // [Tuesday] checkbox
                            Spacer(
                              flex: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: femaleValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      femaleValue = value;
                                    });
                                  },
                                ),
                                Text(
                                  locale.female!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            Spacer(
                              flex: 3,
                            ),
                            // [Wednesday] checkbox
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, PageRoutes.listOfDoctorsPage);
                },
                label: locale.applyNow,
                radius: 0,
              ),
            ),
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
