/// data : {"customer_id":"1","name":"asdsadasd","email":"adsd@asd.com","location":"0"}
/// status : true
/// success : 1
/// message : "Fetching Record"

class EditProfileModel {
  Data? _data;
  bool? _status;
  int? _success;
  String? _message;

  Data? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  EditProfileModel({
      Data? data, 
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  EditProfileModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _status = json['status'];
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// customer_id : "1"
/// name : "asdsadasd"
/// email : "adsd@asd.com"
/// location : "0"

class Data {
  String? _customerId;
  String? _name;
  String? _email;
  String? _location;

  String? get customerId => _customerId;
  String? get name => _name;
  String? get email => _email;
  String? get location => _location;

  Data({
      String? customerId, 
      String? name, 
      String? email, 
      String? location}){
    _customerId = customerId;
    _name = name;
    _email = email;
    _location = location;
}

  Data.fromJson(dynamic json) {
    _customerId = json['customer_id'].toString();
    _name = json['name'];
    _email = json['email'];
    _location = json['location'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['customer_id'] = _customerId;
    map['name'] = _name;
    map['email'] = _email;
    map['location'] = _location;
    return map;
  }

}