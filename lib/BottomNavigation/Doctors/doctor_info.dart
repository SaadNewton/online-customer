import 'dart:developer';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:doctoworld_user/BottomNavigation/Doctors/book_appointment.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/get_all_doctors_model.dart';
import 'package:doctoworld_user/Models/get_clinic_schedule.dart';
import 'package:doctoworld_user/Models/get_clinics_model.dart';
import 'package:doctoworld_user/Models/get_online_schedule.dart';
import 'package:doctoworld_user/Models/get_schedule_model.dart';
import 'package:doctoworld_user/Pages/calendar.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/doctor_schedule_repo.dart';
import 'package:doctoworld_user/repositories/get_all_time_slots_repo.dart';
import 'package:doctoworld_user/repositories/get_doctor_profile_repo.dart';
import 'package:doctoworld_user/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

bool forCustomer = true;
List<DateTime>? dateList = <DateTime>[];

getDayList() {
  dateList=[];
  List.generate(3000, (index) {
    DateTime bk = DateTime.now();

    log(Get.find<LoaderController>().getScheduleModel.data!.length.toString());
    Get.find<LoaderController>().getScheduleModel.data!.forEach((element) {
      if (DateFormat('EEEE')
              .format(DateTime.now().add(Duration(days: index))) ==
          element.day) {
        print('test ${element.day}');
        bk = DateTime.now().add(Duration(days: index));
        dateList!.add(bk);
      }
    });
  });
}

class DoctorInfo extends StatefulWidget {
  // final DoctorDetailData? doctorInfo;
  final docId;

  // final image;
  // final name;
  // final fees;
  // final speciality;
  // final qualification;
  // final startTime;
  // final endTime;
  // final serialDay;
  DoctorInfo({
    this.docId,
    //   this.docId,this.name,this.fees,this.speciality,
    //   this.image,this.qualification,this.startTime,this.endTime,
    // this.serialDay
  });

  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  int selectedSlot = 10000;
  String? slot;
  String? selectedHospital = '';
  String? appointmentDate;
  int currentHospital = 0;
  int currentDay = 0;
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  List selectedDates = ['27', '29'];

  List slotDropDown = [];

  @override
  void initState() {
    // TODO: implement initState
    Get.find<LoaderController>().selectedDay=10000;
    forCustomer = false;
    Get.find<LoaderController>().getScheduleModel = GetScheduleModel();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateInnerDataLoader(true);
      Get.find<LoaderController>().updateDataController(true);
      getMethod(
          context,
          getNotifyTokenService,
          {'user_id': widget.docId, 'role': 'doctor'},
          false,
          getNotifyTokenRepo);
      Get.find<LoaderController>().getOnSiteClinicsModel =
          new GetClinicsModel();
      Get.find<LoaderController>().getOnlineSchedule = new GetClinicSchedule();
      Get.find<LoaderController>().getOnSiteClinicScheduleModel =
          GetClinicSchedule();
    });

    print('--------->>${widget.docId.toString()}');
    // getMethod(context, getAppointmentSlotsService,
    //     {'doctor_id':widget.docId,
    //       'booking_date':appointmentDate}, true, getAllTimeSlotsRepo
    // );
    getMethod(context, getDoctorProfileService, {'doctor_id': widget.docId},
        true, getDoctorProfileRepo);
    super.initState();
  }

  String? selectedClinic;
  int? selectedClinicId;
  String? onlineSelectedDate;
  String? onSiteSelectedDate;
  String? scheduleType;
  List<String> scheduleTypeList = ['Online', 'On Site'];

  DateTime? scheduleDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (loaderController) => ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Doctor Detail",style: TextStyle(color: Colors.black),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_outline_outlined),
                  )
                ],
              )
            ],
          ),
          body: loaderController.dataLoader
              ? Center(child: CircularProgressIndicator())
              : FadedSlideAnimation(
            Stack(
              children: [
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height:150,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: FadedScaleAnimation(
                                          getDoctorProfileModal
                                              .data.imagePath ==
                                              null
                                              ? Image.asset(
                                            'assets/Doctors/doc1.png',
                                          )
                                              : Image.network(
                                            "${imageBaseUrl}"
                                                "${getDoctorProfileModal.data.imagePath}",
                                            height: 200,
                                            width:
                                            MediaQuery.of(context)
                                                .size
                                                .width *
                                                .5,
                                          ),
                                          durationInMilliseconds: 400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                                children: [
                                                  TextSpan(
                                                      text: getDoctorProfileModal
                                                          .data.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!
                                                          .copyWith(
                                                          fontSize: 26)),
                                                  TextSpan(
                                                      text:
                                                      "\n${getDoctorProfileModal.data.qualification}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!
                                                          .copyWith(
                                                          color: Theme.of(
                                                              context)
                                                              .disabledColor,
                                                          fontSize: 13))
                                                ]),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),

                                      /// fees
                                      RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            children: [
                                              TextSpan(
                                                  text: locale.consulFees,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                      color: Theme.of(
                                                          context)
                                                          .disabledColor,
                                                      fontSize: 18)),
                                              TextSpan(
                                                  text:
                                                  'Rs. ${getDoctorProfileModal.data.fees}',
                                                  style: TextStyle(
                                                      height: 1.4))
                                            ]),
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),

                                      ///qualification
                                      ///
                                      RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            children: [
                                              TextSpan(
                                                  text: 'Qualification',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                      color: Theme.of(
                                                          context)
                                                          .disabledColor,
                                                      fontSize: 18)),
                                              TextSpan(
                                                  text:
                                                  '\n${getDoctorProfileModal.data.qualification}',
                                                  style: TextStyle(
                                                      height: 1.4))
                                            ]),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 20,
                            //       top: 10,
                            //       bottom: 20,
                            //       right: 20),
                            //   child: Wrap(
                            //     children: [
                            //       RichText(
                            //         text: TextSpan(
                            //             style: Theme.of(context)
                            //                 .textTheme
                            //                 .subtitle2,
                            //             children: [
                            //               TextSpan(
                            //                   text: getDoctorProfileModal
                            //                       .data.name,
                            //                   style: Theme.of(context)
                            //                       .textTheme
                            //                       .subtitle2!
                            //                       .copyWith(
                            //                           fontSize: 26)),
                            //               TextSpan(
                            //                   text:
                            //                       "\n${getDoctorProfileModal.data.qualification}",
                            //                   style: Theme.of(context)
                            //                       .textTheme
                            //                       .subtitle2!
                            //                       .copyWith(
                            //                           color: Theme.of(
                            //                                   context)
                            //                               .disabledColor,
                            //                           fontSize: 13))
                            //             ]),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      /// specialities
                      ///
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.only(
                            top: 10, left: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Specialities',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                  color: Theme.of(context)
                                      .disabledColor),
                            ),
                            Wrap(
                              children: List.generate(
                                  getDoctorProfileModal
                                      .data.speciality!.length, (indexx) {
                                return getDoctorProfileModal
                                    .data.speciality![indexx]
                                    .toString() ==
                                    'null'
                                    ? SizedBox()
                                    : Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(
                                      0, 10, 10, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor,
                                        borderRadius:
                                        BorderRadius.circular(
                                            5)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                          12, 5, 12, 5),
                                      child: Text(
                                        '${getDoctorProfileModal.data.speciality![indexx]}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      /// slots
                      ///

                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 17.0, horizontal: 10.0),
                              fillColor: Colors.grey.withOpacity(0.2),
                              filled: true,
                              hintText: 'Select Schedule Type',
                              hintStyle: TextStyle(
                                  color: Colors.black, fontSize: 17),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4))),
                            ),
                            // isExpanded: true,
                            focusColor: Colors.white,
                            // dropdownColor: Colors.grey.withOpacity(0.2),
                            // iconSize: 10,
                            style: TextStyle(
                                color: Colors.black, fontSize: 17),
                            iconEnabledColor: Colors.black,
                            value: scheduleType,
                            items: scheduleTypeList
                                .map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? value) {
                              print(value);
                              Get.find<LoaderController>().updateSelectDay(10000);
                              setState(() {
                                selectedSlot = 3000;
                                scheduleType = value;

                                loaderController.getOnSiteClinicsModel =
                                new GetClinicsModel();
                                loaderController.getOnlineSchedule =
                                new GetClinicSchedule();
                                loaderController
                                    .getOnSiteClinicScheduleModel =
                                    GetClinicSchedule();
                                loaderController.getScheduleModel =
                                    GetScheduleModel();
                              });
                              scheduleType == 'Online'
                                  ? Get.find<LoaderController>()
                                  .updateFormController(true)
                                  : Get.find<LoaderController>()
                                  .updateFormController(false);
                              scheduleType == 'Online'
                                  ? getMethod(
                                  context,
                                  getScheduleByClinicService,
                                  {
                                    'type': 'online',
                                    'doctor_id': widget.docId,
                                    'clinic_id': null
                                  },
                                  true,
                                  getOnlineClinicsRepo)
                                  : SizedBox();
                            },
                            validator: (String? value) {
                              if (value == null) {
                                return 'Field is Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),

                      scheduleType == 'On Site'
                          ? ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 17.0, horizontal: 10.0),
                              fillColor:
                              Colors.grey.withOpacity(0.2),
                              filled: true,
                              hintText: 'Select Clinic',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4))),
                            ),
                            // isExpanded: true,
                            focusColor: Colors.white,
                            // dropdownColor: Colors.grey.withOpacity(0.2),
                            // iconSize: 10,
                            style: TextStyle(
                                color: Colors.black, fontSize: 17),
                            iconEnabledColor: Colors.black,
                            value: selectedClinic,
                            items: loaderController.getClinicsList
                                .map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? value) {
                              Get.find<LoaderController>().updateSelectDay(10000);
                              print(value);
                              setState(() {
                                selectedClinic = value;
                                loaderController.getScheduleModel =
                                    GetScheduleModel();
                                Get.find<LoaderController>()
                                    .updateFormController(true);
                              });
                              print(
                                  'clinicId--->>${
                                      getDoctorProfileModal.
                                      data.clinics[getDoctorProfileModal.
                                      data.clinics.indexWhere((element) =>
                                      element.name == selectedClinic)].id}');

                              getMethod(
                                  context,
                                  getScheduleByClinicService,
                                  {
                                    'type': 'onsite',
                                    'doctor_id': widget.docId,
                                    'clinic_id': getDoctorProfileModal
                                        .data
                                        .clinics[getDoctorProfileModal
                                        .data.clinics
                                        .indexWhere((element) =>
                                    element.name ==
                                        selectedClinic)]
                                        .id
                                  },
                                  true,
                                  getOnlineClinicsRepo);
                            },
                            validator: (String? value) {
                              if (value == null) {
                                return 'Field is Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      )
                          : SizedBox(),
                      loaderController.getScheduleModel.data == null
                          ? SizedBox()
                          : _getCustomizedDatePicker(dateList!),
                      loaderController.selectedDay!=10000?Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                20, 15, 15, 0),
                            child: Text(
                              'Slots',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                  color: Theme.of(
                                      context)
                                      .disabledColor),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(
                                20, 0, 15, 20),
                            child: Wrap(
                              children: List.generate(
                                  loaderController
                                      .getScheduleModel.data![loaderController.selectedDay!].slots!.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      //slot on tap
                                      selectedSlot = index;
                                      slot = loaderController
                                          .getScheduleModel.data![loaderController.selectedDay!].slots![index].slot;
                                      print("slot $slot");
                                    });
                                  },
                                  child: Padding(
                                    padding:
                                    const EdgeInsets
                                        .fromLTRB(
                                        0, 10, 10, 0),
                                    child: Container(
                                      padding: EdgeInsets
                                          .symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                      ),
                                      decoration:
                                      BoxDecoration(
                                        border: Border.all(
                                            color: selectedSlot ==
                                                index
                                                ? Colors
                                                .green
                                                : Theme.of(
                                                context)
                                                .primaryColor),
                                        borderRadius: BorderRadius
                                            .all(Radius
                                            .circular(
                                            10)),
                                        color: selectedSlot ==
                                            index
                                            ? Colors.green
                                            : Theme.of(
                                            context)
                                            .primaryColor,
                                      ),
                                      child: Text(
                                          loaderController.getScheduleModel.data![loaderController.selectedDay!].slots![
                                          index].slot!,
                                          style: TextStyle(
                                              color: Colors
                                                  .white)),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ):SizedBox(),
                      // loaderController.getOnlineSchedule.data == null
                      //     ? loaderController.getOnlineSchedule.status
                      //                 .toString() !=
                      //             'false'
                      //         ? SizedBox()
                      //         : Center(
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(20.0),
                      //               child: Text(
                      //                 'No slot available',
                      //                 style: TextStyle(
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.black,
                      //                 ),
                      //               ),
                      //             ),
                      //           )
                      //     : Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment:
                      //             CrossAxisAlignment.start,
                      //         children: [
                      //           SizedBox(
                      //             height: 10,
                      //           ),
                      //           ButtonTheme(
                      //             alignedDropdown: true,
                      //             child: DropdownButtonHideUnderline(
                      //               child:
                      //                   DropdownButtonFormField<String>(
                      //                 decoration: InputDecoration(
                      //                   contentPadding:
                      //                       EdgeInsets.symmetric(
                      //                           vertical: 17.0,
                      //                           horizontal: 10.0),
                      //                   fillColor:
                      //                       Colors.grey.withOpacity(0.2),
                      //                   filled: true,
                      //                   hintText: 'Select Date',
                      //                   hintStyle: TextStyle(
                      //                       color: Colors.black,
                      //                       fontSize: 17),
                      //                   border: OutlineInputBorder(
                      //                       borderSide: BorderSide.none,
                      //                       borderRadius:
                      //                           BorderRadius.all(
                      //                               Radius.circular(4))),
                      //                 ),
                      //                 // isExpanded: true,
                      //                 focusColor: Colors.white,
                      //                 // dropdownColor: Colors.grey.withOpacity(0.2),
                      //                 // iconSize: 10,
                      //                 style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 17),
                      //                 iconEnabledColor: Colors.black,
                      //                 value: onlineSelectedDate,
                      //                 items: loaderController
                      //                     .getOnlineScheduleDateList
                      //                     .map<DropdownMenuItem<String>>(
                      //                         (String value) {
                      //                   return DropdownMenuItem<String>(
                      //                     value: value,
                      //                     child: Text(
                      //                       value,
                      //                       style: TextStyle(
                      //                           color: Colors.black,
                      //                           fontSize: 17),
                      //                     ),
                      //                   );
                      //                 }).toList(),
                      //                 onChanged: (String? value) {
                      //                   print(value);
                      //                   setState(() {
                      //                     appointmentDate = value;
                      //                     onlineSelectedDate = value;
                      //                     loaderController
                      //                             .onlineScheduleDateIndex =
                      //                         loaderController
                      //                             .getOnlineScheduleDateList
                      //                             .indexOf(
                      //                                 onlineSelectedDate!);
                      //                   });
                      //                 },
                      //                 validator: (String? value) {
                      //                   if (value == null) {
                      //                     return 'Field is Required';
                      //                   } else {
                      //                     return null;
                      //                   }
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //           onlineSelectedDate == null
                      //               ? SizedBox()
                      //               : Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Padding(
                      //                       padding: EdgeInsets.fromLTRB(
                      //                           20, 15, 15, 0),
                      //                       child: Text(
                      //                         'Slots',
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .subtitle1!
                      //                             .copyWith(
                      //                                 color: Theme.of(
                      //                                         context)
                      //                                     .disabledColor),
                      //                       ),
                      //                     ),
                      //                     Container(
                      //                       width: double.infinity,
                      //                       padding: EdgeInsets.fromLTRB(
                      //                           20, 0, 15, 20),
                      //                       child: Wrap(
                      //                         children: List.generate(
                      //                             loaderController
                      //                                 .getOnlineSchedule
                      //                                 .data
                      //                                 .availableSlots[
                      //                                     loaderController
                      //                                         .onlineScheduleDateIndex!]
                      //                                 .date
                      //                                 .slots
                      //                                 .length, (index) {
                      //                           return InkWell(
                      //                             onTap: () {
                      //                               setState(() {
                      //                                 selectedSlot =
                      //                                     index;
                      //                                 slot = loaderController
                      //                                     .getOnlineSchedule
                      //                                     .data
                      //                                     .availableSlots[
                      //                                         loaderController
                      //                                             .onlineScheduleDateIndex!]
                      //                                     .date
                      //                                     .slots![index];
                      //                               });
                      //                             },
                      //                             child: Padding(
                      //                               padding:
                      //                                   const EdgeInsets
                      //                                           .fromLTRB(
                      //                                       0, 10, 10, 0),
                      //                               child: Container(
                      //                                 padding: EdgeInsets
                      //                                     .symmetric(
                      //                                   vertical: 10,
                      //                                   horizontal: 15,
                      //                                 ),
                      //                                 decoration:
                      //                                     BoxDecoration(
                      //                                   border: Border.all(
                      //                                       color: selectedSlot ==
                      //                                               index
                      //                                           ? Colors
                      //                                               .green
                      //                                           : Theme.of(
                      //                                                   context)
                      //                                               .primaryColor),
                      //                                   borderRadius: BorderRadius
                      //                                       .all(Radius
                      //                                           .circular(
                      //                                               10)),
                      //                                   color: selectedSlot ==
                      //                                           index
                      //                                       ? Colors.green
                      //                                       : Theme.of(
                      //                                               context)
                      //                                           .primaryColor,
                      //                                 ),
                      //                                 child: Text(
                      //                                     loaderController
                      //                                             .getOnlineSchedule
                      //                                             .data
                      //                                             .availableSlots[loaderController
                      //                                                 .onlineScheduleDateIndex!]
                      //                                             .date
                      //                                             .slots![
                      //                                         index],
                      //                                     style: TextStyle(
                      //                                         color: Colors
                      //                                             .white)),
                      //                               ),
                      //                             ),
                      //                           );
                      //                         }),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 )
                      //         ],
                      //       ),

                      // loaderController.getOnSiteClinicsModel.data == null
                      //     ? loaderController.getOnSiteClinicsModel.status
                      //                 .toString() !=
                      //             'false'
                      //         ? SizedBox()
                      //         : Center(
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(20.0),
                      //               child: Text(
                      //                 'No slot available',
                      //                 style: TextStyle(
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.black,
                      //                 ),
                      //               ),
                      //             ),
                      //           )
                      //     : Column(
                      //         children: [
                      //           SizedBox(
                      //             height: 10,
                      //           ),
                      //           // ButtonTheme(
                      //           //   alignedDropdown: true,
                      //           //   child: DropdownButtonHideUnderline(
                      //           //     child:
                      //           //         DropdownButtonFormField<String>(
                      //           //       decoration: InputDecoration(
                      //           //         contentPadding:
                      //           //             EdgeInsets.symmetric(
                      //           //                 vertical: 17.0,
                      //           //                 horizontal: 10.0),
                      //           //         fillColor:
                      //           //             Colors.grey.withOpacity(0.2),
                      //           //         filled: true,
                      //           //         hintText: 'Select Clinic',
                      //           //         hintStyle: TextStyle(
                      //           //             color: Colors.black,
                      //           //             fontSize: 17),
                      //           //         border: OutlineInputBorder(
                      //           //             borderSide: BorderSide.none,
                      //           //             borderRadius:
                      //           //                 BorderRadius.all(
                      //           //                     Radius.circular(4))),
                      //           //       ),
                      //           //       // isExpanded: true,
                      //           //       focusColor: Colors.white,
                      //           //       // dropdownColor: Colors.grey.withOpacity(0.2),
                      //           //       // iconSize: 10,
                      //           //       style: TextStyle(
                      //           //           color: Colors.black,
                      //           //           fontSize: 17),
                      //           //       iconEnabledColor: Colors.black,
                      //           //       value: selectedClinic,
                      //           //       items: loaderController
                      //           //           .getClinicsList
                      //           //           .map<DropdownMenuItem<String>>(
                      //           //               (String value) {
                      //           //         return DropdownMenuItem<String>(
                      //           //           value: value,
                      //           //           child: Text(
                      //           //             value,
                      //           //             style: TextStyle(
                      //           //                 color: Colors.black,
                      //           //                 fontSize: 17),
                      //           //           ),
                      //           //         );
                      //           //       }).toList(),
                      //           //       onChanged: (String? value) {
                      //           //         print(value);
                      //           //         setState(() {
                      //           //           selectedClinic = value;
                      //           //           Get.find<LoaderController>()
                      //           //                   .getOnSiteClinicScheduleModel =
                      //           //               GetClinicSchedule();
                      //           //           Get.find<LoaderController>()
                      //           //               .updateFormController(true);
                      //           //         });
                      //           //         getMethod(
                      //           //             context,
                      //           //             getScheduleByClinicService,
                      //           //             {
                      //           //               'clinic_id': loaderController
                      //           //                   .getOnSiteClinicsModel
                      //           //                   .data[loaderController
                      //           //                       .getOnSiteClinicsModel
                      //           //                       .data
                      //           //                       .indexWhere((element) =>
                      //           //                           element.name ==
                      //           //                           selectedClinic)]
                      //           //                   .id,
                      //           //               'doctor_id': widget.docId
                      //           //             },
                      //           //             true,
                      //           //             getOnSiteClinicsScheduleRepo);
                      //           //       },
                      //           //       validator: (String? value) {
                      //           //         if (value == null) {
                      //           //           return 'Field is Required';
                      //           //         } else {
                      //           //           return null;
                      //           //         }
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           // ),
                      //           loaderController.getOnSiteClinicScheduleModel
                      //                           .data ==
                      //                       null &&
                      //                   loaderController
                      //                           .getOnSiteScheduleDateList
                      //                           .length ==
                      //                       0
                      //               ? SizedBox()
                      //               : Column(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     SizedBox(
                      //                       height: 10,
                      //                     ),
                      //                     ButtonTheme(
                      //                       alignedDropdown: true,
                      //                       child:
                      //                           DropdownButtonHideUnderline(
                      //                         child:
                      //                             DropdownButtonFormField<
                      //                                 String>(
                      //                           decoration:
                      //                               InputDecoration(
                      //                             contentPadding:
                      //                                 EdgeInsets
                      //                                     .symmetric(
                      //                                         vertical:
                      //                                             17.0,
                      //                                         horizontal:
                      //                                             10.0),
                      //                             fillColor: Colors.grey
                      //                                 .withOpacity(0.2),
                      //                             filled: true,
                      //                             hintText: 'Select Date',
                      //                             hintStyle: TextStyle(
                      //                                 color: Colors.black,
                      //                                 fontSize: 17),
                      //                             border: OutlineInputBorder(
                      //                                 borderSide:
                      //                                     BorderSide.none,
                      //                                 borderRadius:
                      //                                     BorderRadius
                      //                                         .all(Radius
                      //                                             .circular(
                      //                                                 4))),
                      //                           ),
                      //                           // isExpanded: true,
                      //                           focusColor: Colors.white,
                      //                           // dropdownColor: Colors.grey.withOpacity(0.2),
                      //                           // iconSize: 10,
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 17),
                      //                           iconEnabledColor:
                      //                               Colors.black,
                      //                           value: onSiteSelectedDate,
                      //                           items: loaderController
                      //                               .getOnSiteScheduleDateList
                      //                               .map<
                      //                                   DropdownMenuItem<
                      //                                       String>>((String
                      //                                   value) {
                      //                             return DropdownMenuItem<
                      //                                 String>(
                      //                               value: value,
                      //                               child: Text(
                      //                                 value,
                      //                                 style: TextStyle(
                      //                                     color: Colors
                      //                                         .black,
                      //                                     fontSize: 17),
                      //                               ),
                      //                             );
                      //                           }).toList(),
                      //                           onChanged:
                      //                               (String? value) {
                      //                             print(value);
                      //                             setState(() {
                      //                               appointmentDate =
                      //                                   value;
                      //                               onSiteSelectedDate =
                      //                                   value;
                      //                               loaderController
                      //                                       .onSiteScheduleDateIndex =
                      //                                   loaderController
                      //                                       .getOnSiteScheduleDateList
                      //                                       .indexOf(
                      //                                           onSiteSelectedDate!);
                      //                             });
                      //                           },
                      //                           validator:
                      //                               (String? value) {
                      //                             if (value == null) {
                      //                               return 'Field is Required';
                      //                             } else {
                      //                               return null;
                      //                             }
                      //                           },
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     onSiteSelectedDate == null
                      //                         ? SizedBox()
                      //                         : Column(
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment
                      //                                     .start,
                      //                             children: [
                      //                               Padding(
                      //                                 padding: EdgeInsets
                      //                                     .fromLTRB(20,
                      //                                         15, 15, 0),
                      //                                 child: Text(
                      //                                   'Slots',
                      //                                   style: Theme.of(
                      //                                           context)
                      //                                       .textTheme
                      //                                       .subtitle1!
                      //                                       .copyWith(
                      //                                           color: Theme.of(
                      //                                                   context)
                      //                                               .disabledColor),
                      //                                 ),
                      //                               ),
                      //                               Container(
                      //                                 width:
                      //                                     double.infinity,
                      //                                 padding: EdgeInsets
                      //                                     .fromLTRB(20, 0,
                      //                                         15, 20),
                      //                                 child: Wrap(
                      //                                   children: List.generate(
                      //                                       loaderController
                      //                                           .getOnSiteClinicScheduleModel
                      //                                           .data
                      //                                           .availableSlots[
                      //                                               loaderController
                      //                                                   .onSiteScheduleDateIndex!]
                      //                                           .date
                      //                                           .slots
                      //                                           .length,
                      //                                       (index) {
                      //                                     return InkWell(
                      //                                       onTap: () {
                      //                                         setState(
                      //                                             () {
                      //                                           slot = loaderController
                      //                                               .getOnSiteClinicScheduleModel
                      //                                               .data
                      //                                               .availableSlots[
                      //                                                   loaderController.onSiteScheduleDateIndex!]
                      //                                               .date
                      //                                               .slots![index];
                      //                                           selectedSlot =
                      //                                               index;
                      //                                         });
                      //                                       },
                      //                                       child:
                      //                                           Padding(
                      //                                         padding:
                      //                                             const EdgeInsets.fromLTRB(
                      //                                                 0,
                      //                                                 10,
                      //                                                 10,
                      //                                                 0),
                      //                                         child:
                      //                                             Container(
                      //                                           padding:
                      //                                               EdgeInsets
                      //                                                   .symmetric(
                      //                                             vertical:
                      //                                                 10,
                      //                                             horizontal:
                      //                                                 15,
                      //                                           ),
                      //                                           decoration:
                      //                                               BoxDecoration(
                      //                                             border: Border.all(
                      //                                                 color: selectedSlot == index
                      //                                                     ? Colors.green
                      //                                                     : Theme.of(context).primaryColor),
                      //                                             borderRadius:
                      //                                                 BorderRadius.all(Radius.circular(10)),
                      //                                             color: selectedSlot ==
                      //                                                     index
                      //                                                 ? Colors.green
                      //                                                 : Theme.of(context).primaryColor,
                      //                                           ),
                      //                                           child: Text(
                      //                                               loaderController
                      //                                                   .getOnSiteClinicScheduleModel
                      //                                                   .data
                      //                                                   .availableSlots[loaderController.onSiteScheduleDateIndex!]
                      //                                                   .date
                      //                                                   .slots![index],
                      //                                               style: TextStyle(color: Colors.white)),
                      //                                         ),
                      //                                       ),
                      //                                     );
                      //                                   }),
                      //                                 ),
                      //                               ),
                      //                             ],
                      //                           )
                      //                   ],
                      //                 ),
                      //         ],
                      //       ),

                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          onTap: () {
                            if (selectedSlot != 3000) {
                              Get.to(BookAppointment(
                                docId: widget.docId,
                                name: getDoctorProfileModal.data.name,
                                qualification: getDoctorProfileModal
                                    .data.qualification,
                                image:
                                getDoctorProfileModal.data.imagePath,
                                selectedDate: appointmentDate,
                                selectedTime: slot,
                                type: scheduleType == 'Online'
                                    ? 'online'
                                    : 'onsite',
                                clinicId: scheduleType == 'Online'
                                    ? 1
                                    : getDoctorProfileModal.
                                data.clinics[getDoctorProfileModal.
                                data.clinics.indexWhere((element) =>
                                element.name == selectedClinic)].id,
                              ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      title: 'warning!'.toUpperCase(),
                                      titleColor: customDialogInfoColor,
                                      descriptions:
                                      'PLease Select A Slot',
                                      text: 'Ok',
                                      functionCall: () {
                                        Get.back();
                                      },
                                      img: 'assets/dialog_Info.svg',
                                    );
                                  });
                            }
                          },
                          icon: Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          label: locale.bookAppointmentNow,
                          radius: 0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ),
      ),
    );
  }

  SfDateRangePicker _getCustomizedDatePicker(List<DateTime> specialDates) {
    final Color monthCellBackground = const Color(0xfff7f4ff);
    final Color indicatorColor = const Color(0xFF1AC4C7);
    final Color highlightColor = Colors.deepPurpleAccent;
    final Color cellTextColor = const Color(0xFF130438);

    return SfDateRangePicker(
      selectionShape: DateRangePickerSelectionShape.rectangle,
      selectionColor: highlightColor,
      selectionTextStyle: TextStyle(color: Colors.white, fontSize: 14),
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(const Duration(days: 100)),
      headerStyle: DateRangePickerHeaderStyle(
          textAlign: TextAlign.center,
          textStyle: TextStyle(
            fontSize: 18,
            color: cellTextColor,
          )),
      monthCellStyle: DateRangePickerMonthCellStyle(
          cellDecoration: MonthCellDecoration(
              borderColor: null,
              backgroundColor: monthCellBackground,
              showIndicator: false,
              indicatorColor: indicatorColor),
          todayCellDecoration: MonthCellDecoration(
              borderColor: monthCellBackground,
              backgroundColor: monthCellBackground,
              showIndicator: false,
              indicatorColor: indicatorColor),
          specialDatesDecoration: MonthCellDecoration(
              borderColor: null,
              backgroundColor: indicatorColor,
              showIndicator: true,
              indicatorColor: indicatorColor),
          disabledDatesTextStyle: TextStyle(
            color: const Color(0xffe2d7fe),
          ),
          weekendTextStyle: TextStyle(
            color: const Color(0xffe2d7fe),
          ),
          textStyle: TextStyle(color: const Color(0xffe2d7fe), fontSize: 14),
          specialDatesTextStyle: TextStyle(color: cellTextColor, fontSize: 14),
          todayTextStyle: TextStyle(color: highlightColor, fontSize: 14)),
      yearCellStyle: DateRangePickerYearCellStyle(
        todayTextStyle: TextStyle(color: highlightColor, fontSize: 14),
        textStyle: TextStyle(color: cellTextColor, fontSize: 14),
        disabledDatesTextStyle: TextStyle(color: const Color(0xffe2d7fe)),
        leadingDatesTextStyle:
            TextStyle(color: cellTextColor.withOpacity(0.5), fontSize: 14),
      ),
      showNavigationArrow: true,
      todayHighlightColor: monthCellBackground,
      monthViewSettings: DateRangePickerMonthViewSettings(
        firstDayOfWeek: 1,
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle: TextStyle(
                fontSize: 10,
                color: cellTextColor,
                fontWeight: FontWeight.w600)),
        dayFormat: 'EEE',
        showTrailingAndLeadingDates: false,
        specialDates: specialDates,
      ),
      onSelectionChanged: (value) {
        Get.find<LoaderController>().getScheduleModel.data!.forEach((element) {
          if ( DateFormat('EEEE').format(DateTime.parse(value.value.toString()))==
              element.day) {
            print('test ${DateFormat('EEEE').format(DateTime.parse(value.value.toString()))}');
            appointmentDate=DateFormat('yyyy-MM-dd').format(value.value).toString();
            Get.find<LoaderController>().updateSelectDay(Get.find<LoaderController>().getScheduleModel.data!.indexOf(element));
            print('${Get.find<LoaderController>().selectedDay} ${DateFormat('EEEE').format(DateTime.parse(value.value.toString()))}');
          }else{
            Get.find<LoaderController>().updateSelectDay(10000);
          }
        });

        log(value.value.toString());
      },
    );
  }
}
