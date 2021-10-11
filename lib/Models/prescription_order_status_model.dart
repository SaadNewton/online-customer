/// status : true
/// success : 1
/// message : "Status change successfully"

class PrescriptionOrderStatusModel {
  bool? _status;
  int? _success;
  String? _message;

  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  PrescriptionOrderStatusModel({
      bool? status, 
      int? success, 
      String? message}){
    _status = status;
    _success = success;
    _message = message;
}

  PrescriptionOrderStatusModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}