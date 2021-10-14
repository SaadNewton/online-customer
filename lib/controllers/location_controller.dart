
import 'package:doctoworld_user/Models/get_all_labs_model.dart';
import 'package:doctoworld_user/repositories/get_all_labs_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  ///----------LOCATION START

  bool loadMore = false;
  List<SingleLabData> labsList = [];

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
      getAddressFromLatLng(context);

    }).catchError((e) {
      print(e);
    });
  }
  getAddressFromLatLng(BuildContext context) async {
    try {
      // var currentPosition;
      List<Placemark> p = await GeocodingPlatform.instance
          .placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
      Placemark place = p[0];
        currentAddress =
        '${place.name}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
      if(Get.find<LocationController>().loadMore){

        getMethod(context, getAllLabsService,
            {'city': place.subAdministrativeArea.toString(),
            'page':labPage
            }, true, getAllLabsRepoMore);
      }else{
        getMethod(context, getAllLabsService,
            {'city': place.subAdministrativeArea.toString(),
              'page':labPage
            }, true, getAllLabsRepo);

      }
        print(currentAddress! + ' yes');
        print(place.administrativeArea.toString());
        print(place.subAdministrativeArea.toString());
        print(place.thoroughfare.toString());
        print(place.toJson().toString());
        // FocusScope.of(context).unfocus();
    } catch (e) {
      print(e);
    }
  }

}
int labPage=1;