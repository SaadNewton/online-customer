import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Doctors/book_appointment.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_all_time_slots_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class DoctorInfo extends StatefulWidget {
  final docId;
  final image;
  final name;
  final fees;
  final speciality;
  final qualification;
  final startTime;
  final endTime;
  final serialDay;
  DoctorInfo({this.docId,this.name,this.fees,this.speciality,
    this.image,this.qualification,this.startTime,this.endTime,
  this.serialDay});
  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
 int  selectedSlot=3000;
 String? slot;
  String? appointmentDate;

  @override
  void initState() {
    // TODO: implement initState
    appointmentDate=DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateInnerDataLoader(true);
    });
    getMethod(context, getAppointmentSlotsService,
        {'doctor_id':widget.docId,
          'booking_date':appointmentDate}, true, getAllTimeSlotsRepo
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
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
                        SizedBox(
                          height: 20,
                        ),
                        ...List.generate(widget.speciality!.length,
                              (i) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.speciality![i],
                          style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 18, height: 2),
                        ),
                                  Divider(
                                    height: 5,
                                    thickness: 5,
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                ],
                              ),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
/// slots
                  ///

                  GetBuilder<LoaderController>(
                    init:LoaderController() ,
                    builder:(loader)=> Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.only(top: 10, left: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Slots',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Theme.of(context).primaryColor,
                                    fontSize: 20),
                              ),

                              SizedBox(
                                width: 160,
                                height: 50,
                                child: Material(
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true),
                                    hint: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10),
                                      child: Text(
                                        DateFormat('yyyy-MM-dd').format(DateTime.now()).toString() ,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    items: List.generate((
                                        widget.serialDay!+1),
                                            (a) {
                                          return DropdownMenuItem(
                                            child: Text(DateFormat('yyyy-MM-dd').format(DateTime.now()
                                                .add(Duration(days: a))).toString()),
                                            value: DateFormat('yyyy-MM-dd').format(DateTime.now()
                                                .subtract(Duration(days: a))).toString(),
                                          );
                                        }),
                                    onChanged: (value) {
setState(() {

  selectedSlot=3000;
  appointmentDate=value!;
  loader.updateInnerDataLoader(true);
  getMethod(context, getAppointmentSlotsService,
      {'doctor_id':widget.docId,
        'booking_date':appointmentDate}, true, getAllTimeSlotsRepo
  );
});
                                    },

                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                        loader.innerLoader?Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: CircularProgressIndicator(),),
                        ): !getAppointmentSlotsModel.status!

                              ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('No Slot Available'),
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: List.generate(
                                  getAppointmentSlotsModel.data!.length,
                                      (i) => InkWell(
                                        onTap: (){
                                          setState(() {
                                            slot=getAppointmentSlotsModel.data![i].slot;
                                            selectedSlot=getAppointmentSlotsModel.data!.indexOf(
                                                getAppointmentSlotsModel.data![i]);
                                            print('slot '+selectedSlot.toString()+i.toString());
                                          });

                                        },
                                        child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: getAppointmentSlotsModel.data![i].status!?

                                         Colors.grey:
                                          selectedSlot==i?Colors.green:Theme.of(context).primaryColor
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                        getAppointmentSlotsModel.data![i].status!?

                                        Colors.grey:
                                        selectedSlot==i?Colors.green:Theme.of(context).primaryColor,
                                    ),
                                    child: Text(
                                          getAppointmentSlotsModel.data![i].slot!,
                                          style: TextStyle(
                                              color: Colors.white)),
                                  ),
                                      )),
                            ),
                          )
                        ],
                      ),
                    ),
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
    );
  }
}
