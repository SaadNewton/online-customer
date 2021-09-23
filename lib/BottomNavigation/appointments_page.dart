import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Pages/appointment_detail.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_user/repositories/get_all_orders_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<Appointments> upcomingAppointments = [
      Appointments('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '12 June 2020', '12:00 pm'),
      Appointments('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '14 June 2020', '2:30 pm'),
    ];
    List<Appointments> pastAppointments = [
      Appointments('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '28 May 2020', '3:00 pm'),
      Appointments('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '11 May 2020', '2:30 pm'),
      Appointments('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '26 April 2020', '10:00 am'),
      Appointments('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22 April 2020', '11:00 am'),
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
          child: getAllAppointmentsModel.status==false?Center(child: Text(getAllAppointmentsModel.message!),):ListView(
            //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
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
                  return getAllAppointmentsModel.data!.data![index].isComplete==1?SizedBox()
                      :Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(AppointmentDetail(appointmentDetail:getAllAppointmentsModel.data!.data![index] ,));
                        },
                        child: Stack(
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
                                  scale: 2.5,),
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
                            ),

                          ],
                        ),
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
                  return getAllAppointmentsModel.data!.data![index].isComplete==0?SizedBox()
                      :Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10.0, left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.appointmentDetail);
                              },
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
                                      scale: 2.5,),
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
      ),
    );
  }
}
