// @dart=2.10
import 'dart:async';

import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/controllers/screen_controller.dart';
import 'package:firebase_core/firebase_core.dart';
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

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LoaderController c = Get.put(LoaderController());
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(Phoenix(child: Docto()));
}

class Docto extends StatelessWidget {
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
      routes: PageRoutes().routes(),
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
