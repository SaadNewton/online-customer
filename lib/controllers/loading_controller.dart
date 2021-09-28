import 'package:doctoworld_user/Models/get_clinic_schedule.dart';
import 'package:doctoworld_user/Models/get_clinics_model.dart';
import 'package:doctoworld_user/Models/get_online_schedule.dart';
import 'package:get/get.dart';

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
  GetOnlineSchedule getOnlineSchedule = GetOnlineSchedule();

  List<String> getClinicsList = [];
  updateGetClinicsList(String clinic){
    getClinicsList.add(
      clinic
    );
    update();
  }


  DateTime? createdDate;
  DateTime? endDate;
}
