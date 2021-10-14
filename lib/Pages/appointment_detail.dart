import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/More/Order/chat_screen.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/get_all_appointments_model.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/call/join_channel_video.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/repositories/get_agora_repo.dart';
import 'package:doctoworld_user/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class AppointmentDetail extends StatefulWidget {
  final SingleAppointmentData? appointmentDetail;
  AppointmentDetail({this.appointmentDetail});
  @override
  _AppointmentDetailState createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  @override
  void initState() {
    // TODO: implement initState
    getMethod(
        context,
        getNotifyTokenService,
        {
          'user_id': widget.appointmentDetail!.doctor!.id,
          'role':'doctor'
        },
        false,
        getNotifyTokenRepo
    );
    getMethod(
        context,
        agoraService,
        null,
        false,
        getAgoraRepo
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.appointmentDetails!,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: FadedScaleAnimation(
                                widget.appointmentDetail!.doctor!.image==null?Image.asset(
                                  'assets/Doctors/doc1.png',
                                ):Image.network("${imageBaseUrl}assets/doctor/images/profile/${widget.appointmentDetail!.doctor!.image}"),
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
                                        text: 'Dr.\n${widget.appointmentDetail!.doctor!.name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w500,
                                                height: 1.4)),
                                    TextSpan(
                                        text:
                                            ' \n${widget.appointmentDetail!.doctor!.qualification}'
                                          ,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .disabledColor,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.appointmentDetail!.bookingType!.toUpperCase()} ',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'At',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.appointmentDetail!.bookingDate!} | ${widget.appointmentDetail!.timeSerial!}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 20),
                          ),
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
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.appointmentDetail!.disease!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget.appointmentDetail!.isComplete != 1
                ?SizedBox()
                :widget.appointmentDetail!.bookingType == 'onsite'
                ?SizedBox()
                :Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        if(widget.appointmentDetail!.bookingDate
                        ==DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()
                            ){
                        postMethod(
                            context,
                            fcmService,
                            {
                              'notification': <String, dynamic>{
                                'body': 'Your Patient is calling you for appointment',
                                'title': 'Appointment'
                              },
                              'priority': 'high',
                              'data': <String, dynamic>{
                                'channel': Get.find<LoaderController>().agoraModel.channelName,
                                'channel_token': Get.find<LoaderController>().agoraModel.token,
                                'routeWeb': '/customer/approved/appointment/detail',
                                'routeApp':'/joinVideo',
                              },
                              'to': Get.find<LoaderController>().otherRoleToken,
                            },
                            false,
                            methodRepo
                        );
                      }else{
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: 'FAILED!',
                                  titleColor: customDialogErrorColor,
                                  descriptions: 'Your appointment date is '
                                      '${widget.appointmentDetail!.bookingDate}',
                                  text: 'Ok',
                                  functionCall: () {
                                    Navigator.pop(context);
                                  },
                                  img: 'assets/dialog_error.svg',
                                );
                              });
                        }
                        },
                      child: Container(
                        height: 60,
                        color: Theme.of(context).backgroundColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              locale.call!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                       Get.to(ChatScreen(
                         appointment:widget.appointmentDetail ,
                       ));
                        // Navigator.pushNamed(context, PageRoutes.doctorChat);
                      },
                      child: Container(
                        height: 60,
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.message,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Chat',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
  methodRepo(bool responseCheck, Map<String, dynamic> response, BuildContext context){
    if(response['success'].toString() == '1'){
      Get.to(JoinChannelVideo());
    }
  }
}
