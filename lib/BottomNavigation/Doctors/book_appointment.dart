import 'dart:ui';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/book_appointment_repo.dart';
import 'package:doctoworld_user/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/services.dart';
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
  final type;
  final clinicId;
  BookAppointment({this.docId,this.name,this.qualification,this.selectedDate,this.selectedTime,
    this.image,this.type,this.clinicId});
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  GlobalKey<FormState> confirmAppointment = GlobalKey();
TextEditingController _namController=TextEditingController();
  TextEditingController _phoneController=TextEditingController();
  // TextEditingController _emailController=TextEditingController();
  // TextEditingController _detailController=TextEditingController();
  TextEditingController _ageController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }
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
            title: Text("Fill Details",style: TextStyle(color: Colors.black),),

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
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: FadedScaleAnimation(
                                  widget.image==null
                                      ?Image.asset(
                                    'assets/Doctors/doc1.png',
                                  ):
                                  Image.network("$imageBaseUrl"
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
                                  .bodyText2!
                                  .copyWith(
                                color: kMainTextColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),

                        SizedBox(
                          height: 20,
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
                            Spacer(flex: 1),
                            Text(
                              widget.selectedTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                color: kMainTextColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        // SizedBox(height: 10,),
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
                        EntryField(
                          textInputFormatter: FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                          textInputType: TextInputType.name,
                          controller: _namController,
                          prefixIcon: Icons.person,
                          color: Theme.of(context).backgroundColor,
                          hint: 'Name',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Field is Required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15.0),

                        /// age
                        ///
                        EntryField(
                          textInputFormatter: LengthLimitingTextInputFormatter(2),
                          textInputType: TextInputType.number,
                          controller: _ageController,
                          prefixIcon: Icons.person,
                          color: Theme.of(context).backgroundColor,
                          hint: 'Age',
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Field is Required';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        /// email
                        ///
                        // EntryField(
                        //   textInputType: TextInputType.emailAddress,
                        //   controller: _emailController,
                        //   prefixIcon: Icons.person,
                        //   color: Theme.of(context).backgroundColor,
                        //   hint: 'Email',
                        //   validator: (value) {
                        //     if (value.isEmpty) {
                        //       return 'Field is Required';
                        //     } else if (!GetUtils.isEmail(_emailController.text)) {
                        //       return 'Please Enter Valid Email';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),

                        /// phone
                        ///
                        EntryField(
                          textInputFormatter: LengthLimitingTextInputFormatter(11),
                          textInputType: TextInputType.phone,
                          controller: _phoneController,
                          prefixIcon: Icons.person,
                          color: Theme.of(context).backgroundColor,
                          hint: 'Phone',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Field is Required';
                            } else if (value.length < 11) {
                              return 'Enter Valid Number';
                            } else {
                              return null;
                            }
                          },
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),

                        /// details
                        ///
                        // EntryField(
                        //   textInputType: TextInputType.text,
                        //   controller: _detailController,
                        //   prefixIcon: Icons.person,
                        //   color: Theme.of(context).backgroundColor,
                        //   hint: 'Detail',
                        //   validator: (value) {
                        //     if (value.isEmpty) {
                        //       return 'Field is Required';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        // ),
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
                            'email':'cybex@gmail.com',
                            'mobile':_phoneController.text,
                            'age':'25',
                            'disease':'Dummy',
                            'clinic_id':widget.clinicId,
                            'type':widget.type,
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
