
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Pages/appointment_detail.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/doctor_rating_repo.dart';
import 'package:doctoworld_user/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_user/repositories/get_all_orders_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class Appointments {
  String image;
  String name;
  String speciality;
  String hospital;
  String date;
  String time;
  String? reviews;

  Appointments(this.image, this.name, this.speciality, this.hospital, this.date,
      this.time);
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateDataController(true);

    });
    getMethod(context, getAllAppointmentsService,
        {'customer_id':storageBox!.read('customerId'),'filter':'all'}, true, getAllAppointmentsRepo);
    super.initState();
  }
  GlobalKey<FormState> _ratingKey = GlobalKey();
  TextEditingController _feedController = TextEditingController();
  double rate = 0.0;
  bool rateCheck = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<Appointments> upcomingAppointments = [
      Appointments('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '12 June 2020', '12:00 pm'),
      Appointments('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '14 June 2020', '2:30 pm'),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FadedScaleAnimation(
          Text(
            locale.myAppointments!,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
          ),
          durationInMilliseconds: 400,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<LoaderController>(
        init:LoaderController(),
        builder:(_)=>_.dataLoader?Center(
          child: CircularProgressIndicator(),
        ):Container(
          child: getAllAppointmentsModel.status==false
              ?Center(child: Text(getAllAppointmentsModel.message!),)
              :ListView(
            //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [

              Container(
                padding: EdgeInsets.only(top: 15, left: 10),
                color: Theme.of(context).backgroundColor,
                height: 50,
                child: Text('Pending',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 20, color: Theme.of(context).disabledColor)),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:getAllAppointmentsModel.data!.data!.length,
                itemBuilder: (context, index) {
                  return getAllAppointmentsModel.data!.data![index].isComplete==0
                      ?InkWell(
                    onTap: () {
                      Get.to(AppointmentDetail(appointmentDetail:getAllAppointmentsModel.data!.data![index] ,));
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, left: 10, right: 10),
                              child: Row(
                                children: [
                                  FadedScaleAnimation(
                                    getAllAppointmentsModel.data!.data![index].doctor!.image==null
                                        ?
                                    Image.asset(
                                      upcomingAppointments[index].image,
                                      scale: 2.5,
                                    ):Image.network(
                                      "${imageBaseUrl}assets/doctor/images/profile/${
                                          getAllAppointmentsModel.data!.data![index].doctor!.image}",
                                      width: 60,),
                                    durationInMilliseconds: 400,

                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        getAllAppointmentsModel.data!.data![index].doctor!.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(height: 1.5, fontSize: 16),
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: getAllAppointmentsModel.data!.data![index].doctor!.qualification,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: 12,
                                                      height: 1.5),
                                                ),

                                              ])),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            getAllAppointmentsModel.data!.data![index].bookingDate!+
                                                ' | ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 13),
                                          ),
                                          Text(
                                            getAllAppointmentsModel.data!.data![index].timeSerial!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
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
                    ),
                  ):SizedBox();
                },
              ),

              Container(
                padding: EdgeInsets.only(top: 20, left: 10),
                color: Theme.of(context).backgroundColor,
                height: 50,
                child: Text(locale.upcoming!,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 20, color: Theme.of(context).disabledColor)),
              ),
              Divider(
                thickness: 6,
                height: 6,
                color: Theme.of(context).backgroundColor,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: getAllAppointmentsModel.data!.data!.length,
                itemBuilder: (context, index) {
                  return getAllAppointmentsModel.data!.data![index].isComplete==1?InkWell(
                    onTap: () {
                      Get.to(AppointmentDetail(appointmentDetail:getAllAppointmentsModel.data!.data![index] ,));
                    },
                        child: Column(
                    children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, left: 10, right: 10),
                              child: GestureDetector(

                                child: Row(
                                  children: [
                                    FadedScaleAnimation(
                                getAllAppointmentsModel.data!.data![index].doctor!.image==null
                                    ?
                                Image.asset(
                                        upcomingAppointments[index].image,
                                        scale: 2.5,
                                      ):Image.network(
                                   "${imageBaseUrl}assets/doctor/images/profile/${
                                       getAllAppointmentsModel.data!.data![index].doctor!.image}",
                                  width: 60,),
                                      durationInMilliseconds: 400,

                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),

                                            Text(
                                              getAllAppointmentsModel.data!.data![index].doctor!.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(height: 1.5, fontSize: 16),
                                            ),


                                        RichText(
                                            text: TextSpan(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                                children: <TextSpan>[
                                              TextSpan(
                                                text: getAllAppointmentsModel.data!.data![index].doctor!.qualification,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .disabledColor,
                                                        fontSize: 12,
                                                        height: 1.5),
                                              ),

                                            ])),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              getAllAppointmentsModel.data!.data![index].bookingDate!+
                                                  ' | ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(fontSize: 13),
                                            ),
                                            Text(
                                              getAllAppointmentsModel.data!.data![index].timeSerial!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(fontSize: 13),
                                            ),


                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          getAllAppointmentsModel.data!.data![index].bookingType!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(height: 1.5, fontSize: 16, color: Colors.white),
                                        ),
                                      ),
                                    ),
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
                  ),
                      ):SizedBox();
                },
              ),



              Container(
                padding: EdgeInsets.only(top: 15, left: 10),
                color: Theme.of(context).backgroundColor,
                height: 50,
                child: Text(locale.past!,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 20, color: Theme.of(context).disabledColor)),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:getAllAppointmentsModel.data!.data!.length,
                itemBuilder: (context, index) {
                  return getAllAppointmentsModel.data!.data![index].isComplete==2
                      ?InkWell(
                      onTap: () {
                        Get.to(AppointmentDetail(appointmentDetail:getAllAppointmentsModel.data!.data![index] ,));
                      },
                        child: Column(
                    children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, left: 10, right: 10),
                              child: Row(
                                children: [
                                  FadedScaleAnimation(
                                    getAllAppointmentsModel.data!.data![index].doctor!.image==null
                                        ?
                                    Image.asset(
                                      upcomingAppointments[index].image,
                                      scale: 2.5,
                                    ):Image.network(
                                      "${imageBaseUrl}assets/doctor/images/profile/${
                                          getAllAppointmentsModel.data!.data![index].doctor!.image}",
                                      width: 60,),
                                    durationInMilliseconds: 400,

                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        getAllAppointmentsModel.data!.data![index].doctor!.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(height: 1.5, fontSize: 16),
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: getAllAppointmentsModel.data!.data![index].doctor!.qualification,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: 12,
                                                      height: 1.5),
                                                ),

                                              ])),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            getAllAppointmentsModel.data!.data![index].bookingDate!+
                                                ' | ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 13),
                                          ),
                                          Text(
                                            getAllAppointmentsModel.data!.data![index].timeSerial!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30,right: 5),
                                child: Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(6),

                                  ),
                                  child: Center(child: InkWell(
                                    onTap: (){
                                      showDialog(

                                        context: context,
                                        builder: (_) => Center( // Aligns the container to center
                                          child: Container(
                                              width: MediaQuery.of(context).size.width * .8,
                                              height: MediaQuery.of(context).size.height * .6,
                                              decoration: BoxDecoration(color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),

                                              child:  StatefulBuilder(

                                                  builder: (BuildContext context, StateSetter setState) {
                                                    return Scaffold(
                                                      resizeToAvoidBottomInset: false,
                                                      body: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                                                        child: Form(
                                                          key: _ratingKey,
                                                          child: SingleChildScrollView(
                                                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                            child: Column(

                                                              children: [
                                                                SizedBox(height: 20,),

                                                                SvgPicture.asset('assets/doctor icon.svg',
                                                                  height: 100,),
                                                                SizedBox(height: 20,),
                                                                Text('Feed Back',
                                                                  style: TextStyle(fontSize: 20),
                                                                ),
                                                                SizedBox(height: 30,),
                                                                Center(
                                                                  child: RatingStars(

                                                                    value: rate,
                                                                    onValueChanged: (v) {
                                                                      //

                                                                      setState(() {
                                                                        rate = v;

                                                                      });
                                                                    },
                                                                    starBuilder: (
                                                                        index,
                                                                        color) =>
                                                                        Icon(
                                                                          Icons
                                                                              .star,
                                                                          color: color,

                                                                        ),
                                                                    starCount: 5,
                                                                    starSize: 30,
                                                                    // valueLabelColor: const Color(
                                                                    //     0xff9b9b9b),
                                                                    // valueLabelTextStyle: const TextStyle(
                                                                    //     color: Colors
                                                                    //         .white,
                                                                    //     fontWeight: FontWeight
                                                                    //         .w400,
                                                                    //     fontStyle: FontStyle
                                                                    //         .normal,
                                                                    //     fontSize: 12.0),
                                                                    // valueLabelRadius: 10,
                                                                    maxValue: 5,
                                                                    starSpacing: 2,
                                                                    maxValueVisibility: true,
                                                                    valueLabelVisibility: false,
                                                                    animationDuration: Duration(
                                                                        milliseconds: 1000),
                                                                    valueLabelPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical: 1,
                                                                        horizontal: 8),
                                                                    valueLabelMargin: const EdgeInsets
                                                                        .only(
                                                                        right: 8),
                                                                    starOffColor: const Color(
                                                                        0xffe7e8ea),
                                                                    starColor: Colors
                                                                        .yellow,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 10.0,),
                                                                rateCheck == true ? Text('Please Rate First',
                                                                  style: TextStyle(color: Colors.red),
                                                                ) : SizedBox(),
                                                                SizedBox(height: 30,),
                                                                EntryField(
                                                                  controller: _feedController,
                                                                  hint: 'Your Feed Back ',
                                                                  validator: (value){
                                                                    if(value.isEmpty){
                                                                      return 'Field is Required';
                                                                    }else{
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                                SizedBox(height: 50,),
                                                                Container(
                                                                  height: 40,
                                                                  width: 80,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.blueAccent,
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                  child: Center(child: InkWell(
                                                                    onTap: (){
                                                                      if(_ratingKey.currentState!.validate() && rate > 0.0) {

                                                                        setState(() {
                                                                          rateCheck = false;

                                                                        });




                                                                        Get.find<LoaderController>().updateFormController(true);
                                                                        postMethod(
                                                                          context,
                                                                          ratingService,
                                                                          {
                                                                            'customer_id': storageBox!
                                                                                .read(
                                                                                'customerId'),
                                                                            'doctor_id': getAllAppointmentsModel
                                                                                .data!
                                                                                .data![index]
                                                                                .doctorId,
                                                                            'rating': rate,
                                                                            'review_message': _feedController
                                                                                .text,

                                                                          },
                                                                          true,
                                                                          doctorRatingRepo,
                                                                        );
                                                                      }else{
                                                                        setState(() {
                                                                          rateCheck = true;

                                                                        });
                                                                      }
                                                                    },
                                                                    child: Text('Submit',
                                                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                                                    ),
                                                                  )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );

                                                  }
                                              )
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text('Rate Now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
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
                  ),
                      ):SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
