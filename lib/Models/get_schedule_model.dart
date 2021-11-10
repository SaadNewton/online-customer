class GetScheduleModel {
  List<GetScheduleModelData>? _data;
  bool? _status;
  int? _success;

  List<GetScheduleModelData>? get data => _data;
  bool? get status => _status;
  int? get success => _success;

  GetScheduleModel({
      List<GetScheduleModelData>? data,
      bool? status, 
      int? success}){
    _data = data;
    _status = status;
    _success = success;
}

  GetScheduleModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetScheduleModelData.fromJson(v));
      });
    }
    _status = json['status'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['success'] = _success;
    return map;
  }

}

class GetScheduleModelData {
  int? _id;
  int? _doctorId;
  String? _slotType;
  String? _fees;
  String? _startTime;
  String? _endTime;
  dynamic? _serialDay;
  String? _day;
  String? _duration;
  List<String>? _serialOrSlot;
  dynamic? _clinicId;
  String? _type;
  String? _isHoliday;
  String? _createdAt;
  String? _updatedAt;
  List<Slots>? _slots;
  dynamic? _clinic;

  int? get id => _id;
  int? get doctorId => _doctorId;
  String? get slotType => _slotType;
  String? get fees => _fees;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  dynamic? get serialDay => _serialDay;
  String? get day => _day;
  String? get duration => _duration;
  List<String>? get serialOrSlot => _serialOrSlot;
  dynamic? get clinicId => _clinicId;
  String? get type => _type;
  String? get isHoliday => _isHoliday;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Slots>? get slots => _slots;
  dynamic? get clinic => _clinic;

  GetScheduleModelData({
      int? id, 
      int? doctorId, 
      String? slotType, 
      String? fees, 
      String? startTime, 
      String? endTime, 
      dynamic? serialDay, 
      String? day, 
      String? duration, 
      List<String>? serialOrSlot, 
      dynamic? clinicId, 
      String? type, 
      String? isHoliday, 
      String? createdAt, 
      String? updatedAt, 
      List<Slots>? slots, 
      dynamic? clinic}){
    _id = id;
    _doctorId = doctorId;
    _slotType = slotType;
    _fees = fees;
    _startTime = startTime;
    _endTime = endTime;
    _serialDay = serialDay;
    _day = day;
    _duration = duration;
    _serialOrSlot = serialOrSlot;
    _clinicId = clinicId;
    _type = type;
    _isHoliday = isHoliday;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _slots = slots;
    _clinic = clinic;
}

  GetScheduleModelData.fromJson(dynamic json) {
    _id = json['id'];
    _doctorId = json['doctor_id'];
    _slotType = json['slot_type'];
    _fees = json['fees'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _serialDay = json['serial_day'];
    _day = json['day'];
    _duration = json['duration'];
    _serialOrSlot = json['serial_or_slot'] != null ? json['serial_or_slot'].cast<String>() : [];
    _clinicId = json['clinic_id'];
    _type = json['type'];
    _isHoliday = json['is_holiday'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['slots'] != null) {
      _slots = [];
      json['slots'].forEach((v) {
        _slots?.add(Slots.fromJson(v));
      });
    }
    _clinic = json['clinic'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['doctor_id'] = _doctorId;
    map['slot_type'] = _slotType;
    map['fees'] = _fees;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['serial_day'] = _serialDay;
    map['day'] = _day;
    map['duration'] = _duration;
    map['serial_or_slot'] = _serialOrSlot;
    map['clinic_id'] = _clinicId;
    map['type'] = _type;
    map['is_holiday'] = _isHoliday;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_slots != null) {
      map['slots'] = _slots?.map((v) => v.toJson()).toList();
    }
    map['clinic'] = _clinic;
    return map;
  }

}

class Slots {
  String? _slot;
  bool? _status;

  String? get slot => _slot;
  bool? get status => _status;

  Slots({
      String? slot, 
      bool? status}){
    _slot = slot;
    _status = status;
}

  Slots.fromJson(dynamic json) {
    _slot = json['slot'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['slot'] = _slot;
    map['status'] = _status;
    return map;
  }

}