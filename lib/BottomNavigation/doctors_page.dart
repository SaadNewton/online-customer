import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Doctors/doctor_info.dart';
import 'package:doctoworld_user/BottomNavigation/Doctors/list_of_doctors.dart';
import 'package:doctoworld_user/BottomNavigation/doctor_search_screen.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
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
import 'package:google_fonts/google_fonts.dart';
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
      Get.find<LoaderController>().doctorPage = 1;
    });
    getUserDetailRepo();

    getMethod(context, getAllDoctorsService, {'page':1}, true, getAllDoctorsRepo);
    getMethod(context, getDoctorCategoriesService, {'page':1}, true,
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
                title: _.currentCity == null
                    ? Text(
                  'WELCOME',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
                    : Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      _.currentCity!,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),

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
      Get.find<LoaderController>().doctorsList.length,
      (index) => DoctorDetail(
          Get.find<LoaderController>().doctorsList[index].id!,
          Get.find<LoaderController>().doctorsList[index].image ?? 'user',
          Get.find<LoaderController>().doctorsList[index].name ?? 'Doctor',
          Get.find<LoaderController>().doctorsList[index].fees ?? 0,
          Get.find<LoaderController>().doctorsList[index].qualification ?? 'Testing',
          Get.find<LoaderController>().doctorsList[index].startTime ?? '0.00',
          Get.find<LoaderController>().doctorsList[index].endTime ?? '0.00',
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
              child: InkWell(
                onTap: (){
                  Get.to(DoctorSearchScreen());
                },
                child: EntryField(
                  enabled: false,
                  hint: 'Search doctors',
                  prefixIcon: Icons.search,
                ),
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
                                    categoryName:getDoctorCategories
                                        .data!.data![index].name ,
                                    id: getDoctorCategories
                                        .data!.data![index].id,
                                  ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: Container(
                                    width: 110,
                                    height: 170,
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
                                          CrossAxisAlignment.center,
                                      children: [
                                        FadedScaleAnimation(
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(10)),
                                            child: Container(
                                              color: Colors.black,
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
                                          ),
                                          durationInMilliseconds: 300,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            getDoctorCategories
                                                .data!.data![index].name!,
                                            maxLines: 3,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 12),
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
                return Get.find<LoaderController>().doctorsList[index].status==1?
                Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(DoctorInfo(
                                docId: doctorList[index].id,
                              ));
                              // Navigator.pushNamed(
                              //     context, PageRoutes.appointmentDetail);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 70,
                                  child: FadedScaleAnimation(
                                    doctorList[index].image == 'user'
                                        ? Image.asset(
                                            'assets/Doctors/doc2.png',
                                            // scale: 2.5,
                                      width: 70,
                                          )
                                        : Image.network(
                                            "${imageBaseUrl}assets/doctor/images/profile/${doctorList[index].image}",
                                            // scale: 2.5,
                                            // height: 50,
                                      // width: 100,
                                          ),
                                    durationInMilliseconds: 400,
                                  ),
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
                // Text(doctorList[index].speciality,style: TextStyle(color: Colors.black),),
                //                     SizedBox(
                //                       height: 12,
                //                     ),
                //                     Row(
                //                       children: [
                //                         Text(
                // doctorList[index].date.toString()+ ' | ',
                //                           style: Theme.of(context)
                //                               .textTheme
                //                               .subtitle1!
                //                               .copyWith(fontSize: 13),
                //                         ),
                //                         Text(
                // doctorList[index].time.toString(),
                //                           style: Theme.of(context)
                //                               .textTheme
                //                               .subtitle1!
                //                               .copyWith(fontSize: 13),
                //                         ),
                //                       ],
                //                     ),
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
                ):SizedBox();
              },
            ),
            allDoctorsModel.status == false
                ?SizedBox()
                : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: InkWell(
                  onTap: (){

                    Get.find<LoaderController>().doctorPage = Get.find<LoaderController>().doctorPage+1;
                    Get.find<LoaderController>().updateDataController(true);
                    getMethod(context, getAllDoctorsService,
                        {'page':Get.find<LoaderController>().doctorPage},
                        true, getAllDoctorsRepoMore);
                  },
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(
                      child: Text(
                        'Load more',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14
                        ),
                      ),
                    ),
                  )
              )),
            )
          ],
        ),
      ),
    );
  }
}
