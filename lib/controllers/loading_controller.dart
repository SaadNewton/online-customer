
import 'dart:io';

import 'package:doctoworld_user/Models/agora_model.dart';
import 'package:doctoworld_user/Models/fetch_chat_model.dart';
import 'package:doctoworld_user/Models/get_all_doctors_model.dart';
import 'package:doctoworld_user/Models/get_all_orders_model.dart';
import 'package:doctoworld_user/Models/get_clinic_schedule.dart';
import 'package:doctoworld_user/Models/get_clinics_model.dart';
import 'package:doctoworld_user/Models/get_doctor_from_search_model.dart';
import 'package:doctoworld_user/Models/get_lab_from_search.dart';
import 'package:doctoworld_user/Models/get_medicine_from_search_model.dart';
import 'package:doctoworld_user/Models/get_online_schedule.dart';
import 'package:doctoworld_user/Models/get_product_by_category_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
class LoaderController extends GetxController {
  bool formLoader = false;
  updateFormController(bool value) {
    formLoader = value;
    update();
  }

  bool dataLoader = true;
  updateDataController(bool value) {
    dataLoader = value;
    update();
  }
  List<ChatData> messageList = [];
  updateMessageList(ChatData chatData){
    messageList.add(chatData);
    update();
  }
  emptyMessageList(){
    messageList = [];
    update();
  }
/// cart Loader
  bool cartLoader = true;
  updateCartDataController(bool value) {
    cartLoader = value;
    update();
  }

  bool timeOutLoader = true;
  updateTimeOutController(bool value) {
    timeOutLoader = value;
    update();
  }

  bool innerLoader = false;
  updateInnerDataLoader(bool value) {
    innerLoader = value;
    update();
  }

  ///-------------------------------doctor categories loader
  bool doctorCategoryLoader = true;
  doctorCategoryCheck(bool value) {
    doctorCategoryLoader = value;
    update();
  }


  int currentIndex = 0;
  changeCurrentIndexCheck(int value) {
    currentIndex = value;
    update();
  }



  GetClinicsModel getOnSiteClinicsModel = GetClinicsModel();
  GetClinicSchedule getOnSiteClinicScheduleModel = GetClinicSchedule();
  GetClinicSchedule getOnlineSchedule = GetClinicSchedule();

  List<String> getClinicsList = [];
  updateGetClinicsList(String clinic){
    getClinicsList.add(
      clinic
    );
    update();
  }

  List<String> getOnSiteScheduleDateList = [];
  int? onSiteScheduleDateIndex;
  updateOnSiteScheduleDateList(String date){
    getOnSiteScheduleDateList.add(
        date
    );
    update();
  }

  List<String> getOnlineScheduleDateList = [];
  int? onlineScheduleDateIndex;
  updateOnlineScheduleDateList(String date){
    getOnlineScheduleDateList.add(
        date
    );
    update();
  }



  String? currentCity;
  var currentPosition;
  var longitude;
  var latitude;
  var currentAddress;
  getCurrentLocation(BuildContext context) {
    print('LocationPicker');
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      currentPosition = position;
      longitude = currentPosition!.longitude;
      latitude = currentPosition!.latitude;

      print("longitude : $longitude");
      print("latitude : $latitude");
      print("address : $currentPosition");

      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      // var currentPosition;
      List<Placemark> p = await GeocodingPlatform.instance
          .placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
      Placemark place = p[0];
      currentAddress =
      '${place.name}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
      // var signUpAddressController;
      // if (signUpAddressController.text.isEmpty) {
      //   signUpAddressController.text = currentAddress;
      // }
      print(currentAddress + ' yes');
      print(place.administrativeArea.toString());
      print(place.subAdministrativeArea.toString());
      print(place.thoroughfare.toString());
      print(place.toJson().toString());
      // FocusScope.of(context).unfocus();
      currentCity = place.subAdministrativeArea.toString();
    } catch (e) {
      print(e);
    }
  }


  GetMedicineFromSearchModel getMedicineFromSearchModel = GetMedicineFromSearchModel();
  GetDoctorFromSearchModel getDoctorFromSearchModel = GetDoctorFromSearchModel();
  GetLabFromSearch getLabFromSearch = GetLabFromSearch();

  AgoraModel agoraModel = AgoraModel();
  AgoraModel agoraModelDefault = AgoraModel();

  updateAgoraModel(AgoraModel newAgoraModel){
    agoraModel = newAgoraModel;
    update();
  }
  updateAgoraModelDefault(AgoraModel newAgoraModel){
    agoraModelDefault = newAgoraModel;
    update();
  }

  String? otherRoleToken;
  updateOtherRoleToken(String newToken){
    newToken = otherRoleToken!;
    update();
  }
  int callerType = 2;
  updateCallerType(int i){
    callerType = i;
    update();
  }

  int doctorPage = 1;
  List<DoctorDetailData> doctorsList = [];

  int medicinePage = 1;
  List<ProductDetailData> medicineList = [];

  int categoryMedicinePage = 1;
  List<ProductDetailData> categoryMedicineList = [];

  int recentOrderPage = 1;
  List<SingleOrderDetail> recentOrderList = [];

}
