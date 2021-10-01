//@dart=2.9

import 'package:doctoworld_user/Models/get_all_labs_model.dart';

class GetLabFromSearch {
  List<SingleLabData> _data;
  bool _status;
  int _success;
  String _message;

  List<SingleLabData> get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  GetLabFromSearch({
      List<SingleLabData> data,
      bool status, 
      int success, 
      String message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetLabFromSearch.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(SingleLabData.fromJson(v));
      });
    }
    _status = json["status"];
    _success = json["success"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    map["success"] = _success;
    map["message"] = _message;
    return map;
  }

}

/// id : 6
/// name : "Alnoor Diagnostic Centre"
/// user_name : null
/// email : "alnoor456@gmail.com"
/// owner_image : null
/// slug : "alnoor-diagnostic-centre"
/// owner_name : "Alnoor Diagnostic Centre"
/// owner_phone : "0333558585"
/// contact_name : "Alnoor Diagnostic Centre"
/// contact_phone : "033266161112"
/// otp_is_verified : 0
/// image_path : "assets/admin/lab/1628774690_download (1).jpg"
/// country : "Pakistan"
/// city : "Faisalabad"
/// address : "no 1 People's Colony, Block C People's Colony No 1, Faisalabad, Pakistan"
/// lat : "31.41072359999999"
/// long : "73.10840519999999"
/// status : null
/// is_active : "1"
/// is_verified : 1
/// created_at : "2021-08-12T16:24:50.000000Z"
/// updated_at : "2021-08-13T13:35:11.000000Z"

