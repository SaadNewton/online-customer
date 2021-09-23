import 'package:doctoworld_user/repositories/get_all_labs_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  ///----------LOCATION START

  Position? currentPosition;
  double? latitude;
  double? longitude;
  String? currentAddress;
  String? currentArea;
  getCurrentLocation(BuildContext context) {
    var longitude;
    var latitude;

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      currentPosition = position;
      longitude = currentPosition!.longitude;
      latitude = currentPosition!.latitude;

      print("longitude : $longitude");
      print("latitude : $latitude");
      print("address : $currentPosition");
      update();
      getMethod(context, getAllLabsService,
          {'latitude': latitude, 'longitude': longitude,
            'page':labPage
          }, true, getAllLabsRepo);
    }).catchError((e) {
      print(e);
    });
  }
}
int labPage=1;