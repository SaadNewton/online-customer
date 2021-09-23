import 'dart:ui';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/book_appointment_repo.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BookAppointment extends StatefulWidget {
  final docId;
  final name;
  final image;
  final qualification;
  final selectedDate;
  final selectedTime;
  BookAppointment({this.docId,this.name,this.qualification,this.selectedDate,this.selectedTime,this.image});
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  GlobalKey<FormState> confirmAppointment = GlobalKey();
TextEditingController _namController=TextEditingController();
  TextEditingController _phoneController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _detailController=TextEditingController();
  TextEditingController _ageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var width = MediaQuery.of(context).size.width;

    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(_)=> ModalProgressHUD(
        inAsyncCall: _.formLoader,
        child: Scaffold(
          appBar: AppBar(

            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
              //onPressed: Navigator.pop(),
            ),
          ),
          body: FadedSlideAnimation(
            Form(
key: confirmAppointment,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 5),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: FadedScaleAnimation(
                                  widget.image!=null?Image.asset(
                                    'assets/Doctors/doc1.png',
                                  ):
                                  Image.network("$imageBaseUrl"
                                      "assets/doctor/images/profile/"
                                      "${widget.image}"),
                                  durationInMilliseconds: 400,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 22),
                                child: RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.subtitle2,
                                    children: [
                                      TextSpan(
                                          text: 'Dr.\n${widget.name}\n',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.4)),
                                      TextSpan(
                                          text: '${widget.qualification} \n',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  color:
                                                      Theme.of(context).disabledColor,
                                                  fontSize: 18,
                                                  height: 1.6))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Text(
                              locale.selectDate!,
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 22),
                            ),
                            Spacer(flex: 1),
                            Text(
                              widget.selectedDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: kMainTextColor, fontSize: 22),
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    DateFormat('dd').format(DateTime.parse(widget.selectedDate)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                        color:
                                        Theme.of(context).disabledColor,
                                        fontSize: 12,
                                        height: 2),
                                  ),
                                  Text(
                                    DateFormat('MMM').format(DateTime.parse(widget.selectedDate)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                      color: kMainTextColor,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer()
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selected Time',
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 22),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Container(
                           padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                widget.selectedTime,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                  color: kMainTextColor,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            Spacer()
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              locale.appointmentFor!,
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 22),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        /// name
                        ///
                        TextFormField(
                          validator: (v){
                            if(v!.isEmpty) {
                              return 'Please enter patient name';
                            }
                            return null;

                          },
                          controller: _namController,
                          decoration: InputDecoration(
                              hintText: 'Patient Name',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none)),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        /// age
                        ///
                        TextFormField(
                          validator: (v){
                            if(v!.isEmpty) {
                              return 'Please enter age';
                            }
                            return null;

                          },
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Patient Age',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none)),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        /// email
                        ///
                        TextFormField(
                          validator: (v){
                            if(v!.isEmpty || !GetUtils.isEmail(v) ) {
                              return 'Please enter valid email';
                            }
                            return null;

                          },
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none)),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        /// phone
                        ///
                        TextFormField(
                          validator: (v){
                            if(v!.isEmpty) {
                              return 'Please enter phone number';
                            }
                            return null;
                          },
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: 'Phone',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none)),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        /// details
                        ///
                        TextFormField(
                          validator: (v){
                            if(v!.isEmpty) {
                              return 'Please enter details';
                            }
                              return null;

                          },
                          controller: _detailController,
                          decoration: InputDecoration(
                              hintText: 'eg. Heart pain, Body ache, etc.',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none)),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      onTap: () {
                        if(confirmAppointment.currentState!.validate()){
                          _.updateFormController(true);
                          postMethod(context, bookAppointmentService, {
                            'doctor_id':widget.docId,
                            'booking_date':widget.selectedDate,
                            'time_serial':widget.selectedTime,
                            'name':_namController.text,
                            'email':_emailController.text,
                            'mobile':_phoneController.text,
                            'age':_ageController.text,
                            'disease':_detailController.text,
                            'payment_system': 2,
                            'customer_id':storageBox!.read('customerId')
                          }, true, bookAppointmentRepo);

                        }

                      },
                      label: locale.confirmAppointment,
                      radius: 0,
                    ),
                  ),
                ],
              ),
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
