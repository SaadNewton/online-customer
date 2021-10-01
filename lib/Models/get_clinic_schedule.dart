//@dart=2.9

class GetClinicSchedule {
  GetClinicScheduleData _data;
  bool _status;
  int _success;
  String _message;

  GetClinicScheduleData get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  GetClinicSchedule({
    GetClinicScheduleData data,
    bool status,
    int success,
    String message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  GetClinicSchedule.fromJson(dynamic json) {
    _data = json["data"] != null ? GetClinicScheduleData.fromJson(json["data"]) : null;
    _status = json["status"];
    _success = json["success"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["status"] = _status;
    map["success"] = _success;
    map["message"] = _message;
    return map;
  }

}
class GetClinicScheduleData {
  List<Available_slots> _availableSlots;

  List<Available_slots> get availableSlots => _availableSlots;

  GetClinicScheduleData({
    List<Available_slots> availableSlots}){
    _availableSlots = availableSlots;
  }

  GetClinicScheduleData.fromJson(dynamic json) {
    if (json["available_slots"] != null) {
      _availableSlots = [];
      json["available_slots"].forEach((v) {
        _availableSlots.add(Available_slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_availableSlots != null) {
      map["available_slots"] = _availableSlots.map((v) => v.toJson()).toList();
    }
    return map;
  }

}




class Available_slots {
  Date _date;

  Date get date => _date;

  Available_slots({
    Date date}){
    _date = date;
  }

  Available_slots.fromJson(dynamic json) {
    _date = json["date"] != null ? Date.fromJson(json["date"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_date != null) {
      map["date"] = _date.toJson();
    }
    return map;
  }

}

class Date {
  String _date;
  List<String> _slots;

  String get date => _date;
  List<String> get slots => _slots;

  Date({
    String date,
    List<String> slots}){
    _date = date;
    _slots = slots;
  }

  Date.fromJson(dynamic json) {
    _date = json["0"];
    _slots = json["slots"] != null ? json["slots"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["0"] = _date;
    map["slots"] = _slots;
    return map;
  }

}