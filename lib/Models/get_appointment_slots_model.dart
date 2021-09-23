class GetAppointmentSlotsModel {
  List<Data>? _data;
  bool? _status;
  int? _success;
  String? _message;

  List<Data>? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetAppointmentSlotsModel({
      List<Data>? data, 
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetAppointmentSlotsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _status = json['status'];
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

class Data {
  String? _slot;
  bool? _status;

  String? get slot => _slot;
  bool? get status => _status;

  Data({
      String? slot, 
      bool? status}){
    _slot = slot;
    _status = status;
}

  Data.fromJson(dynamic json) {
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