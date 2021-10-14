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
import 'package:modal_progress_hud/modal_progress_hud.dart';
bool forCustomer=true;
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
  DoctorInfo({this.docId,
  //   this.docId,this.name,this.fees,this.speciality,
  //   this.image,this.qualification,this.startTime,this.endTime,
  // this.serialDay
  });
  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {

 int  selectedSlot=3000;
 String? slot;
 String? selectedHospital='';
  String? appointmentDate;
int currentHospital=0;
int currentDay=0;

List slotDropDown = [];
  @override
  void initState() {
    // TODO: implement initState
    forCustomer=false;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateInnerDataLoader(true);
      Get.find<LoaderController>().updateDataController(true);
      getMethod(context, getNotifyTokenService, {'user_id':widget.docId,
        'role':'doctor'}, false, getNotifyTokenRepo);
      Get.find<LoaderController>().getOnSiteClinicsModel = new GetClinicsModel();
      Get.find<LoaderController>().getOnlineSchedule = new GetClinicSchedule();
      Get.find<LoaderController>().getOnSiteClinicScheduleModel = GetClinicSchedule();
    });
    print('--------->>${widget.docId.toString()}');
    // getMethod(context, getAppointmentSlotsService,
    //     {'doctor_id':widget.docId,
    //       'booking_date':appointmentDate}, true, getAllTimeSlotsRepo
    // );
    getMethod(context, getDoctorProfileService, {'doctor_id': widget.docId}, true,
        getDoctorProfileRepo);
    super.initState();
  }

 String? selectedClinic;
 String? onlineSelectedDate;
 String? onSiteSelectedDate;
 String? scheduleType;
 List<String> scheduleTypeList = [
   'Online',
   'On Site'
 ];

 DateTime? scheduleDate = DateTime.now();


 @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(loaderController)=> ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
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
              ?Center(child: CircularProgressIndicator())
              :FadedSlideAnimation(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      child: FadedScaleAnimation(
                                        getDoctorProfileModal.data.imagePath == null
                                            ?Image.asset(
                                          'assets/Doctors/doc1.png',
                                        ):
                                        Image.network("${imageBaseUrl}"
                                            "${getDoctorProfileModal.data.imagePath}",
                                        height: 200,
                                            width: MediaQuery.of(context).size.width*.5,),
                                        durationInMilliseconds: 400,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 45,
                                      ),
                                      /// fees
                                      RichText(
                                        text: TextSpan(
                                            style:
                                                Theme.of(context).textTheme.subtitle2,
                                            children: [
                                              TextSpan(
                                                  text: locale.consulFees,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                          color: Theme.of(context)
                                                              .disabledColor,
                                                          fontSize: 13)),
                                              TextSpan(
                                                  text: 'Rs. ${getDoctorProfileModal.data.fees}',
                                                  style: TextStyle(height: 1.4))
                                            ]),
                                      ),

                                      SizedBox(
                                        height: 45,
                                      ),
                                      ///qualification
                                      ///
                                      RichText(
                                        text: TextSpan(
                                            style:
                                            Theme.of(context).textTheme.subtitle2,
                                            children: [
                                              TextSpan(
                                                  text: 'Qualification',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: 13)),
                                              TextSpan(
                                                  text: '\n${getDoctorProfileModal.data.qualification}',
                                                  style: TextStyle(height: 1.4))
                                            ]),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 20, right: 20),
                              child: Wrap(

                                children: [
                                  RichText(
                                    text: TextSpan(
                                        style:
                                            Theme.of(context).textTheme.subtitle2,
                                        children: [
                                          TextSpan(
                                              text: getDoctorProfileModal.data.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(fontSize: 26)),
                                          TextSpan(
                                              text: "\n${getDoctorProfileModal.data.qualification}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: 13))
                                        ]),
                                  ),

                                ],
                              ),
                            ),
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
                        padding: EdgeInsets.only(top: 10, left: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Specialities',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Theme.of(context).disabledColor),
                            ),
                            Wrap(
                              children: List.generate(getDoctorProfileModal.data.speciality!.length, (indexx) {
                                return getDoctorProfileModal.data.speciality![indexx].toString()
                                    == 'null'
                                    ?SizedBox()
                                    :Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                                      child: Text(
                                        '${getDoctorProfileModal.data.speciality![indexx]}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                        ),
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
                                  color: Colors.black,
                                  fontSize: 17
                              ),
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
                                color: Colors.black,
                                fontSize: 17
                            ),
                            iconEnabledColor: Colors.black,
                            value: scheduleType,
                            items: scheduleTypeList
                                .map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                      TextStyle(
                                          color: Colors.black,
                                          fontSize: 17
                                      ),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? value) {
                              print(value);
                              setState(() {
                                selectedSlot=3000;
                                scheduleType = value;
                                Get.find<LoaderController>().updateFormController(true);
                                loaderController.getOnSiteClinicsModel = new GetClinicsModel();
                                loaderController.getOnlineSchedule = new GetClinicSchedule();
                                loaderController.getOnSiteClinicScheduleModel = GetClinicSchedule();
                              });
                              scheduleType == 'Online'
                                  ? getMethod(
                                  context,
                                  getScheduleBySiteService,
                                  {
                                    'type': 'online',
                                    'doctor_id': widget.docId
                                  },
                                  true,
                                  getOnlineClinicsRepo
                              )
                                  : getMethod(
                                  context,
                                  getScheduleBySiteService,
                                  {
                                    'type': 'onsite',
                                    'doctor_id': widget.docId
                                  },
                                  true,
                                  getOnSiteClinicsRepo
                              );
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

                      loaderController.getOnlineSchedule.data == null
                          ? loaderController.getOnlineSchedule.status.toString() != 'false'
                          ?SizedBox()
                          :Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                        'No slot available',
                        style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                        ),
                      ),
                            ),
                          )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  hintText: 'Select Date',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17
                                  ),
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
                                    color: Colors.black,
                                    fontSize: 17
                                ),
                                iconEnabledColor: Colors.black,
                                value: onlineSelectedDate,
                                items: loaderController.getOnlineScheduleDateList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style:
                                          TextStyle(
                                              color: Colors.black,
                                              fontSize: 17
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (String? value) {
                                  print(value);
                                  setState(() {
                                    appointmentDate = value;
                                    onlineSelectedDate = value;
                                    loaderController.onlineScheduleDateIndex =
                                        loaderController.getOnlineScheduleDateList
                                            .indexOf(onlineSelectedDate!);
                                  });
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
                          onlineSelectedDate == null
                              ?SizedBox()
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 15, 15, 0),
                                child: Text(
                                  'Slots',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: Theme.of(context).disabledColor),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(20, 0, 15, 20),
                                child: Wrap(
                                  children: List.generate(
                                      loaderController.getOnlineSchedule.data
                                          .availableSlots[loaderController.onlineScheduleDateIndex!
                                      ].date.slots.length, (index) {
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedSlot=index;
                                          slot=loaderController.getOnlineSchedule.data
                                              .availableSlots[loaderController.onlineScheduleDateIndex!]
                                              .date.slots![index];
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: selectedSlot==index?Colors.green:Theme.of(context).primaryColor
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: selectedSlot==index?Colors.green:Theme.of(context).primaryColor,
                                          ),
                                          child: Text(
                                              loaderController.getOnlineSchedule.data
                                                  .availableSlots[loaderController.onlineScheduleDateIndex!]
                                                  .date.slots![index],
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      loaderController.getOnSiteClinicsModel.data == null
                          ? loaderController.getOnSiteClinicsModel.status.toString() != 'false'
                          ?SizedBox()
                          :Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'No slot available',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                          : Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  hintText: 'Select Clinic',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17
                                  ),
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
                                    color: Colors.black,
                                    fontSize: 17
                                ),
                                iconEnabledColor: Colors.black,
                                value: selectedClinic,
                                items: loaderController.getClinicsList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style:
                                          TextStyle(
                                              color: Colors.black,
                                              fontSize: 17
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (String? value) {
                                  print(value);
                                  setState(() {
                                    selectedClinic = value;
                                    Get.find<LoaderController>().getOnSiteClinicScheduleModel = GetClinicSchedule();
                                    Get.find<LoaderController>().updateFormController(true);
                                  });
                                  getMethod(
                                      context,
                                      getScheduleByClinicService,
                                      {
                                        'clinic_id': loaderController.getOnSiteClinicsModel.data[
                                        loaderController.getOnSiteClinicsModel.data.indexWhere(
                                                (element) => element.name == selectedClinic)
                                        ].id,
                                        'doctor_id': widget.docId
                                      },
                                      true,
                                      getOnSiteClinicsScheduleRepo
                                  );
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
                              loaderController.getOnSiteClinicScheduleModel.data == null
                              && loaderController.getOnSiteScheduleDateList.length == 0
                                  ? SizedBox()
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),
                                          fillColor: Colors.grey.withOpacity(0.2),
                                          filled: true,
                                          hintText: 'Select Date',
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17
                                          ),
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
                                            color: Colors.black,
                                            fontSize: 17
                                        ),
                                        iconEnabledColor: Colors.black,
                                        value: onSiteSelectedDate,
                                        items: loaderController.getOnSiteScheduleDateList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style:
                                                  TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (String? value) {
                                          print(value);
                                          setState(() {
                                            appointmentDate = value;
                                            onSiteSelectedDate = value;
                                            loaderController.onSiteScheduleDateIndex =
                                                loaderController.getOnSiteScheduleDateList.indexOf(onSiteSelectedDate!);
                                          });
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
                                  onSiteSelectedDate == null
                                      ?SizedBox()
                                      :Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 15, 15, 0),
                                        child: Text(
                                          'Slots',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(color: Theme.of(context).disabledColor),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.fromLTRB(20, 0, 15, 20),
                                        child: Wrap(
                                          children: List.generate(
                                              loaderController.getOnSiteClinicScheduleModel.data
                                                  .availableSlots[loaderController.onSiteScheduleDateIndex!].date.
                                              slots.length, (index) {
                                            return InkWell(
                                              onTap: (){
                                                setState(() {
                                                  slot=loaderController.getOnSiteClinicScheduleModel.data
                                                      .availableSlots[loaderController.onSiteScheduleDateIndex!]
                                                      .date.slots![index];
                                                  selectedSlot=index;
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 15,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: selectedSlot==index?Colors.green
                                                            :Theme.of(context).primaryColor
                                                    ),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                    color: selectedSlot==index?Colors.green
                                                        :Theme.of(context).primaryColor,
                                                  ),
                                                  child: Text(
                                                      loaderController.getOnSiteClinicScheduleModel.data
                                                          .availableSlots[loaderController.onSiteScheduleDateIndex!]
                                                          .date.slots![index],
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),



                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          onTap: () {
                            if(selectedSlot!=3000){
                              Get.to(BookAppointment(
                                docId: widget.docId,
                                name: getDoctorProfileModal.data.name,
                                qualification: getDoctorProfileModal.data.qualification,
                                image: getDoctorProfileModal.data.imagePath,
                                selectedDate: appointmentDate,
                                selectedTime: slot,
                                type: scheduleType == 'Online'
                                    ?'online'
                                    :'onsite',
                                clinicId: scheduleType == 'Online'
                                    ? 1
                                    : loaderController.getOnSiteClinicsModel.data[
                                loaderController.getOnSiteClinicsModel.data.indexWhere(
                                        (element) => element.name == selectedClinic)
                                ].id,
                              ));
                            }else{
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      title: 'warning!'.toUpperCase(),
                                      titleColor: customDialogInfoColor,
                                      descriptions: 'PLease Select A Slot',
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
}
