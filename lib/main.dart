// @dart=2.10
import 'dart:async';

import 'package:doctoworld_user/BottomNavigation/appointments_page.dart';
import 'package:doctoworld_user/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_user/Pages/appointment_detail.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/call/join_channel_video.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/controllers/screen_controller.dart';
import 'package:doctoworld_user/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/local_notification_service.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'Locale/locale.dart';
import 'Routes/routes.dart';
import 'Theme/style.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title.toString());
  String route,channelName;


  if(message.data['channelApp']!=null){
    channelName=message.data['channelApp'];
  }
  if(message.data['routeApp']!=null){
    route=message.data['routeApp'];
    Get.toNamed(route);

  }
  // if (message.data['channel'] != null) {
  //   channelName = message.data['channel'];
  //
  //   // Get.toNamed(route,
  //   //     arguments: JoinChannelVideo(
  //   //       channelId: channelName,
  //   //     ));
  //
  // } else {
  //   Get.toNamed(route);
  // }
  LocalNotificationService.display(message);
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LoaderController c = Get.put(LoaderController());
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(Phoenix(child: Docto()));
}

class Docto extends StatefulWidget {
  @override
  _DoctoState createState() => _DoctoState();
}

class _DoctoState extends State<Docto> {
  @override
  void initState() {
    LocalNotificationService.initialize(context);
    // TODO: implement initState
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      String route,channelName;
      if(message.data['channelApp']!=null){
        channelName=message.data['channelApp'];
      }
      if(message.data['routeApp']!=null){
        route=message.data['routeApp'];
        Get.toNamed(route);

      }

      // if (message.data['channel'] != null) {
      //   channelName = message.data['channel'];
      //
      //   // Get.toNamed(route,
      //   //     arguments: JoinChannelVideo(
      //   //       channelId: channelName,
      //   //     ));
      // } else {
      //   Get.toNamed(route);
      // }
    });


    ///forground messages
    FirebaseMessaging.onMessage.listen((message) {
      print('foreground messages----->>');
      print(message.notification.toString());

      if (message.notification != null) {
        print(message.notification.body.toString());
        print(message.notification.title);
      }
      String route,channelName;


      if(message.data['channelApp']!=null){
        channelName=message.data['channelApp'];
      }
      if(message.data['routeApp']!=null){
        route=message.data['routeApp'];
        Get.toNamed(route);

      }
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      String route,channelName;


      if(message.data['channelApp']!=null){
        channelName=message.data['channelApp'];
      }
      if(message.data['routeApp']!=null){
        route=message.data['routeApp'];
        Get.toNamed(route);

      }

      // if (message.data['channel'] != null) {
      //   channelName = message.data['channel'];
      //   // Get.toNamed(route,
      //   // );
      // } else {
      //   // Get.toNamed(route);
      // }
      LocalNotificationService.display(message);
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
        const Locale('pt'),
        const Locale('fr'),
        const Locale('id'),
        const Locale('es'),
        const Locale('it'),
        const Locale('tr'),
        const Locale('sw'),
      ],
      theme: appTheme,
      home: SplashScreen(),
      routes: {
        '/allAppointments':(context)=>AppointmentPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  delayScreen() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ScreenController()));
  }

  @override
  void initState() {
    // TODO: implement initState
    delayScreen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///background image
        Image.asset(
          'assets/splash-background.png',
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),

        ///Gradient container
        Container(

            decoration: BoxDecoration(

                gradient: LinearGradient(colors: [
              customGradientLightBlue.withOpacity(0.3),
              Theme.of(context).primaryColor
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Center(
              child: Image.asset('assets/splash-logo.png'),
            )),
      ],
    );
  }
}
