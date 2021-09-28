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
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class DoctorInfo extends StatefulWidget {
  final DoctorDetailData? doctorInfo;
  final docId;
  final image;
  final name;
  final fees;
  final speciality;
  final qualification;
  final startTime;
  final endTime;
  final serialDay;
  DoctorInfo({this.doctorInfo,this.docId,this.name,this.fees,this.speciality,
    this.image,this.qualification,this.startTime,this.endTime,
  this.serialDay});
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
    appointmentDate=DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateInnerDataLoader(true);

      Get.find<LoaderController>().getOnSiteClinicsModel = new GetClinicsModel();
      Get.find<LoaderController>().getOnlineSchedule = new GetOnlineSchedule();
      Get.find<LoaderController>().getOnSiteClinicScheduleModel = GetClinicSchedule();
    });
    getMethod(context, getAppointmentSlotsService,
        {'doctor_id':widget.docId,
          'booking_date':appointmentDate}, true, getAllTimeSlotsRepo
    );
    // widget.doctorInfo!.serialDayApp!.forEach((element) {
    //   slotDropDown.add(element);
    // });
    super.initState();
  }

 String? selectedClinic;
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
          body: FadedSlideAnimation(
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
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: FadedScaleAnimation(
                                      widget.image!=null?Image.asset(
                                        'assets/Doctors/doc1.png',
                                      ):
                                      Image.network("${imageBaseUrl}"
                                          "assets/doctor/images/profile/"
                                          "${widget.image}"),
                                      durationInMilliseconds: 400,
                                    ),
                                  ),
                                ),
                                Column(
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
                                                text: '\$${widget.fees}',
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
                                                text: '\n${widget.qualification}',
                                                style: TextStyle(height: 1.4))
                                          ]),
                                    ),
                                  ],
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
                                              text: widget.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(fontSize: 26)),
                                          TextSpan(
                                              text: "\n${widget.qualification}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: 13))
                                        ]),
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            locale.availability!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 15),
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                            children: [
                                              TextSpan(
                                                  text: "${widget.startTime} " +
                                                      locale.to! +
                                                      " ${widget.endTime}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(fontSize: 14))
                                            ]),
                                      ),
                                    ],
                                  )
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
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Wrap(
                              children: List.generate(widget.speciality!.length, (indexx) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                                      child: Text(
                                        '${widget.speciality![indexx]}',
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
                            // ...List.generate(widget.speciality!.length,
                            //       (i) => Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             widget.speciality![i],
                            //   style: Theme.of(context)
                            //           .textTheme
                            //           .bodyText2!
                            //           .copyWith(fontSize: 18, height: 2),
                            // ),
                            //           Divider(
                            //             height: 5,
                            //             thickness: 5,
                            //             color: Theme.of(context).backgroundColor,
                            //           ),
                            //         ],
                            //       ),)
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
                                scheduleType = value;
                                Get.find<LoaderController>().updateFormController(true);
                                loaderController.getOnSiteClinicsModel = new GetClinicsModel();
                                loaderController.getOnlineSchedule = new GetOnlineSchedule();
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
                          ? SizedBox()
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              children: List.generate(loaderController.getOnlineSchedule.data![0].serialOrSlot.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Text(
                                        loaderController.getOnlineSchedule.data![0].serialOrSlot![index],
                                        style: TextStyle(
                                            color: Colors.white)),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),

                      loaderController.getOnSiteClinicsModel.data == null
                          ? SizedBox()
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
                                  ? SizedBox()
                                  : loaderController.endDate!.isBefore(DateTime.now())
                                  ?Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('No Slots Available',
                              style: TextStyle(color: Colors.black,fontSize: 18),),
                                  )
                                  :Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: DateTimeField(
                                      style: TextStyle(
                                        color: Colors.black
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                          child: SizedBox(
                                            height: 13,
                                            width: 13,
                                            child: Icon(
                                              Icons.date_range
                                            )
                                          ),
                                        ),
                                      ),
                                      initialValue: scheduleDate,
                                      format: DateFormat.yMd(),
                                      onShowPicker:
                                          (context, currentValue) async {
                                        final date = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            initialDate:
                                            currentValue ?? DateTime.now(),
                                            lastDate: loaderController.endDate!);
                                        if (date != null) {
                                          return date;
                                        } else {
                                          return currentValue;
                                        }
                                      },
                                      validator: (value) {
                                        if (scheduleDate == null) {
                                          return 'Empty Field';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          scheduleDate = value;
                                          print(scheduleDate.toString().substring(0,10));
                                          DateTime tempDate = DateFormat('yyyy-MM-dd').parse('2021-09-24');
                                          DateTime calculatedDate = tempDate.add(Duration(days: 1));
                                          print(calculatedDate);
                                        });

                                      },
                                    ),
                                  ),
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
                                      children: List.generate(loaderController.getOnSiteClinicScheduleModel.data.serialOrSlot.length, (index) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 15,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context).primaryColor
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            child: Text(
                                                loaderController.getOnSiteClinicScheduleModel.data!.serialOrSlot![index],
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),



                      // GetBuilder<LoaderController>(
                      //   init:LoaderController() ,
                      //   builder:(loader)=> Container(
                      //     color: Theme.of(context).scaffoldBackgroundColor,
                      //     padding: EdgeInsets.only(top: 10, left: 20, bottom: 20),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               'Slots',
                      //               style: Theme.of(context)
                      //                   .textTheme
                      //                   .subtitle1!
                      //                   .copyWith(color: Theme.of(context).primaryColor,
                      //                   fontSize: 20),
                      //             ),
                      //
                      //             SizedBox(
                      //               width: 160,
                      //               height: 50,
                      //               child: Material(
                      //                 child: DropdownButtonFormField<String>(
                      //                   decoration: InputDecoration(
                      //                     border: InputBorder.none,
                      //                       fillColor: Colors.white,
                      //                       filled: true),
                      //                   hint: Padding(
                      //                     padding:
                      //                     const EdgeInsets.only(left: 10),
                      //                     child: Text(
                      //                       DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() ,
                      //                       style: TextStyle(color: Colors.black),
                      //                     ),
                      //                   ),
                      //                   items: List.generate((
                      //                       widget.serialDay!+1),
                      //                           (a) {
                      //                         return DropdownMenuItem(
                      //                           child: Text(DateFormat('yyyy-MM-dd').format(DateTime.now()
                      //                               .add(Duration(days: a))).toString()),
                      //                           value: DateFormat('yyyy-MM-dd').format(DateTime.now()
                      //                               .subtract(Duration(days: a))).toString(),
                      //                         );
                      //                       }),
                      //                   onChanged: (value) {
                      //                     setState(() {
                      //
                      //                       selectedSlot=3000;
                      //                       appointmentDate=value!;
                      //                       loader.updateInnerDataLoader(true);
                      //                       getMethod(context, getAppointmentSlotsService,
                      //                           {'doctor_id':widget.docId,
                      //                             'booking_date':appointmentDate}, true, getAllTimeSlotsRepo
                      //                       );
                      //                     });
                      //                   },
                      //
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(
                      //           height: 20,
                      //         ),
                      //
                      //       loader.innerLoader?Padding(
                      //         padding: const EdgeInsets.all(10.0),
                      //         child: Center(child: CircularProgressIndicator(),),
                      //       ): !getAppointmentSlotsModel.status!
                      //
                      //             ? Center(
                      //           child: Padding(
                      //             padding: EdgeInsets.all(10),
                      //             child: Text('No Slot Available'),
                      //           ),
                      //         )
                      //             : Padding(
                      //           padding: const EdgeInsets.symmetric(vertical: 10),
                      //           child: Wrap(
                      //             runSpacing: 10,
                      //             spacing: 10,
                      //             children: List.generate(
                      //                 getAppointmentSlotsModel.data!.length,
                      //                     (i) => InkWell(
                      //                       onTap: (){
                      //                         setState(() {
                      //                           slot=getAppointmentSlotsModel.data![i].slot;
                      //                           selectedSlot=getAppointmentSlotsModel.data!.indexOf(
                      //                               getAppointmentSlotsModel.data![i]);
                      //                           print('slot '+selectedSlot.toString()+i.toString());
                      //                         });
                      //
                      //                       },
                      //                       child: Container(
                      //                   padding: EdgeInsets.symmetric(
                      //                       vertical: 10,
                      //                       horizontal: 15,
                      //                   ),
                      //                   decoration: BoxDecoration(
                      //                       border: Border.all(
                      //                         color: getAppointmentSlotsModel.data![i].status!?
                      //
                      //                        Colors.grey:
                      //                         selectedSlot==i?Colors.green:Theme.of(context).primaryColor
                      //                       ),
                      //                       borderRadius: BorderRadius.all(
                      //                           Radius.circular(10)),
                      //                       color:
                      //                       getAppointmentSlotsModel.data![i].status!?
                      //
                      //                       Colors.grey:
                      //                       selectedSlot==i?Colors.green:Theme.of(context).primaryColor,
                      //                   ),
                      //                   child: Text(
                      //                         getAppointmentSlotsModel.data![i].slot!,
                      //                         style: TextStyle(
                      //                             color: Colors.white)),
                      //                 ),
                      //                     )),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
                                name: widget.name,
                                qualification: widget.qualification,
                                image: widget.image,
                                selectedDate: appointmentDate,
                                selectedTime: slot,
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
