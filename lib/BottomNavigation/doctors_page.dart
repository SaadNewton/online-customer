import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Doctors/doctor_info.dart';
import 'package:doctoworld_user/BottomNavigation/Doctors/list_of_doctors.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_all_doctor_repo.dart';
import 'package:doctoworld_user/repositories/get_doctor_categories_repo.dart';
import 'package:doctoworld_user/repositories/get_user_detail_reop.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class DoctorDetail {
  int id;
  String image;
  String name;
  int fees;
  String hospital;
  String date;
  String time;
  String? reviews;
  String speciality;
  DoctorDetail(this.id,this.image, this.name, this.fees, this.hospital, this.date,
      this.time, this.speciality);
}

class DoctorsHome extends StatefulWidget {
  final LoaderController c = Get.put(LoaderController());
  @override
  _DoctorsHomeState createState() => _DoctorsHomeState();
}

class _DoctorsHomeState extends State<DoctorsHome> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateDataController(true);
      Get.find<LoaderController>().doctorCategoryCheck(true);
    });
    getUserDetailRepo();

    getMethod(context, getAllDoctorsService, null, true, getAllDoctorsRepo);
    getMethod(context, getDoctorCategoriesService, null, true,
        getAllDoctorCategoriesRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (_) => _.dataLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      userDetailModel.data.city ?? 'Faisalabad',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                actions: <Widget>[
                  Stack(
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.pushNamed(context, PageRoutes.myCartPage);
                        },
                      ),
                      Positioned.directional(
                        textDirection: Directionality.of(context),
                        top: 8,
                        end: 12,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 5.5,
                          child: Center(
                              child: Text(
                            '1',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontSize: 9),
                          )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              body: DoctorsBody()),
    );
  }
}

class DoctorsBody extends StatefulWidget {
  @override
  _DoctorsBodyState createState() => _DoctorsBodyState();
}

class _DoctorsBodyState extends State<DoctorsBody> {
  bool showSlots = false;
  int? doctorId;
  List<DoctorDetail> doctorList = List.generate(
      allDoctorsModel.data!.data!.length,
      (index) => DoctorDetail(allDoctorsModel.data!.data![index].id!,
          allDoctorsModel.data!.data![index].image ?? 'user',
          allDoctorsModel.data!.data![index].name ?? 'Doctor',
          allDoctorsModel.data!.data![index].fees ?? 0,
          allDoctorsModel.data!.data![index].qualification ?? 'Testing',
          allDoctorsModel.data!.data![index].startTime ?? '0.00',
          allDoctorsModel.data!.data![index].endTime ?? '0.00',
          'speciality'));
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (_) => Scaffold(
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
              child: Text(
                locale.hello! + ', ${userDetailModel.data.name}',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FadedScaleAnimation(
                Text(
                  locale.findDoctors!,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                durationInMilliseconds: 400,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: TextFormField(
                onTap: () {
                  Navigator.pushNamed(context, PageRoutes.searchDoctors);
                },
                decoration: InputDecoration(
                    hintText: locale.searchDoctors,
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).backgroundColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Text(
                'Find by Categories',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
            _.doctorCategoryLoader
                ? SkeletonLoader(
                    period: Duration(seconds: 2),
                    highlightColor: Colors.grey,
                    direction: SkeletonDirection.ltr,
                    builder: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 130,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 30,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ],
                        )),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          getDoctorCategories.data!.data!.length,
                          (index) => InkWell(
                                onTap: () {
                                  Get.to(DoctorsPage(
                                    id: getDoctorCategories
                                        .data!.data![index].id,
                                  ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 1)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FadedScaleAnimation(
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(10)),
                                            child: Image.network(
                                              "${imageBaseUrl}assets/sector/${getDoctorCategories.data!.data![index].image}",
                                              // height: 100,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.32,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          durationInMilliseconds: 300,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            getDoctorCategories
                                                .data!.data![index].name!,
                                            maxLines: 2,
                                            softWrap: true,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),

            SizedBox(
              height: 5,
            ),

            /// sponsor
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            //   child: Text(
            //     locale.sponsorAd!,
            //     style: Theme.of(context)
            //         .textTheme
            //         .bodyText1!
            //         .copyWith(color: Theme.of(context).disabledColor),
            //   ),
            // ),
            // Container(
            //   height: 110,
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       physics: BouncingScrollPhysics(),
            //       scrollDirection: Axis.horizontal,
            //       itemCount: doctorBanners.length,
            //       itemBuilder: (context, index) {
            //         return Padding(
            //           padding: EdgeInsets.only(left: 16),
            //           child: FadedScaleAnimation(
            //             Image.asset(
            //               doctorBanners[index],
            //               width: 250,
            //             ),
            //             durationInMilliseconds: 300,
            //           ),
            //         );
            //       }),
            // ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Text(
                'List of doctors',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctorList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {

                              Get.to(DoctorInfo(docId: doctorList[index].id,
                              name: doctorList[index].name,
                              fees: allDoctorsModel.data!.data![index].fees,
                              qualification: allDoctorsModel.data!.data![index].qualification,
                              endTime: allDoctorsModel.data!.data![index].endTime,
                              startTime: allDoctorsModel.data!.data![index].startTime,
                              image: allDoctorsModel.data!.data![index].image,
                              serialDay: allDoctorsModel.data!.data![index].serialDay,
                              speciality: allDoctorsModel.data!.data![index].speciality,));
                              // Navigator.pushNamed(
                              //     context, PageRoutes.appointmentDetail);
                            },
                            child: Row(
                              children: [
                                FadedScaleAnimation(
                                  doctorList[index].image == 'user'
                                      ? Image.asset(
                                          'assets/Doctors/doc2.png',
                                          scale: 2.5,
                                        )
                                      : Image.network(
                                          "${imageBaseUrl}assets/doctor/images/profile/${doctorList[index].image}",
                                          // scale: 2.5,
                                          height: 50,
                                        ),
                                  durationInMilliseconds: 400,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
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
                                                  text: doctorList[index].name+ '\n',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1),
                                              TextSpan(
                                                text: doctorList[index].hospital,
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
                doctorList[index].date+ ' | ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(fontSize: 13),
                                        ),
                                        Text(
                doctorList[index].time,
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
                                                text: doctorList[index].fees
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
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     SizedBox(
                                //       height: 20,
                                //     ),
                                //     Text(
                                //       doctorList[index].name,
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .subtitle1!
                                //           .copyWith(height: 1.5, fontSize: 16),
                                //     ),
                                //     RichText(
                                //         text: TextSpan(
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .subtitle2,
                                //             children: <TextSpan>[
                                //           TextSpan(
                                //             text: doctorList[index]
                                //                 .speciality
                                //                 .toString(),
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .bodyText2!
                                //                 .copyWith(
                                //                     color: Theme.of(context)
                                //                         .disabledColor,
                                //                     fontSize: 12,
                                //                     height: 1.5),
                                //           ),
                                //           TextSpan(
                                //             text: locale.at,
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .caption!
                                //                 .copyWith(
                                //                     color: kButtonTextColor,
                                //                     fontSize: 10,
                                //                     height: 1.5),
                                //           ),
                                //           TextSpan(
                                //             text: doctorList[index].hospital,
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .bodyText2!
                                //                 .copyWith(
                                //                     color: Theme.of(context)
                                //                         .disabledColor,
                                //                     fontSize: 12,
                                //                     height: 1.5),
                                //           ),
                                //         ])),
                                //     SizedBox(
                                //       height: 18,
                                //     ),
                                //     Row(
                                //       children: [
                                //         Text(
                                //           doctorList[index].date + ' | ',
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .subtitle1!
                                //               .copyWith(fontSize: 13),
                                //         ),
                                //         Text(
                                //           doctorList[index].time,
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .subtitle1!
                                //               .copyWith(fontSize: 13),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),


                      ],
                    ),

                    Divider(
                      height: 6,
                      thickness: 6,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
