import 'dart:core';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Doctors/doctor_info.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_all_time_slots_repo.dart';
import 'package:doctoworld_user/repositories/get_doctors_by_category_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorsPage extends StatefulWidget {
  final id;
  final categoryName;
  DoctorsPage({this.id,this.categoryName});
  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateDataController(true);
    });
    getMethod(context, getDoctorsByCategoryService,
        {'doctor_category_id': widget.id}, true, getDoctorsByCategoryRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text( widget.categoryName),
            textTheme: Theme.of(context).textTheme,
            actions: [

            ],
          ),
          body: _.dataLoader
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : DoctorsList()),
    );
  }
}

class DoctorsList extends StatefulWidget {
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class DoctorListTile {
  String image;
  String name;
  dynamic speciality;
  String qualification;
  String fee;
  String startTime;
  String endTime;

  DoctorListTile(this.image, this.name, this.speciality, this.qualification,
      this.fee, this.startTime, this.endTime);
}


class _DoctorsListState extends State<DoctorsList> {
  bool showSlots = false;
  int? doctorId;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    List<DoctorListTile> searchList = List.generate(
      getDoctorsByCategoryModel.data!.data!.length,
      (index) => DoctorListTile(
        getDoctorsByCategoryModel.data!.data![index].image ?? 'user',
        getDoctorsByCategoryModel.data!.data![index].name ?? 'user',
        getDoctorsByCategoryModel.data!.data![index].speciality,
        getDoctorsByCategoryModel.data!.data![index].qualification ?? 'Testing',
        getDoctorsByCategoryModel.data!.data![index].fees.toString() ?? '0',
        getDoctorsByCategoryModel.data!.data![index].startTime ?? '0.00',
        getDoctorsByCategoryModel.data!.data![index].endTime ?? '0.00',
      ),
    );
    return GetBuilder<LoaderController>(
      builder:(_)=> Scaffold(
        body: FadedSlideAnimation(
          Container(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Divider(
                  thickness: 6,
                  height: 6,
                  color: Theme.of(context).backgroundColor,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searchList.length,
                  itemBuilder: (context, i) {
                    return getDoctorsByCategoryModel.data!.data![i].status==1?Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 18.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(DoctorInfo(docId: getDoctorsByCategoryModel.data!.data![i].id,));
                            },
                            child: Row(
                              children: [
                                FadedScaleAnimation(
                                  searchList[i].image == 'user'
                                      ? Image.asset(
                                          'assets/Doctors/doc1.png',
                                          height: 80,
                                          width: 80,
                                        )
                                      : Image.network(
                                          "${imageBaseUrl}assets/doctor/images/profile/${searchList[i].image}",
                                          height: 80,
                                          width: 80,
                                        ),
                                  durationInMilliseconds: 400,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                text: searchList[i].name + '\n',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                            TextSpan(
                                              text: searchList[i].qualification,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: kButtonTextColor,
                                                      fontSize: 12),
                                            ),
                                          ])),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            searchList[i].startTime + ' | ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 13),
                                          ),
                                          Text(
                                            searchList[i].endTime,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                              children: <TextSpan>[
                                            TextSpan(
                                                text: 'Fees ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2),
                                            TextSpan(
                                              text: getDoctorsByCategoryModel
                                                  .data!.data![i].fees
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: 12),
                                            ),
                                            TextSpan(
                                              text: ' Rs',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: kButtonTextColor,
                                                      fontSize: 10),
                                            ),
                                          ])),
                                    ],
                                  ),
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
                    ):SizedBox();

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
                  },
                ),
              ],
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
