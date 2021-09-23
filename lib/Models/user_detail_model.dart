//@dart=2.10

class UserDetailModel {
  UserDetailData _data;
  bool _status;
  int _success;
  String _message;

  UserDetailData get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  UserDetailModel(
      {UserDetailData data, bool status, int success, String message}) {
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  UserDetailModel.fromJson(dynamic json) {
    _data = json["data"] != null ? UserDetailData.fromJson(json["data"]) : null;
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

class UserDetailData {
  int _id;
  String _name;
  String _userName;
  String _email;
  dynamic _image;
  String _phone;
  String _address;
  dynamic _country;
  dynamic _city;
  dynamic _state;
  dynamic _postalCode;
  String _lat;
  String _long;
  dynamic _location;
  dynamic _status;
  dynamic _isActive;
  String _createdAt;
  String _updatedAt;
  Auth _auth;

  int get id => _id;
  String get name => _name;
  String get userName => _userName;
  String get email => _email;
  dynamic get image => _image;
  String get phone => _phone;
  String get address => _address;
  dynamic get country => _country;
  dynamic get city => _city;
  dynamic get state => _state;
  dynamic get postalCode => _postalCode;
  String get lat => _lat;
  String get long => _long;
  dynamic get location => _location;
  dynamic get status => _status;
  dynamic get isActive => _isActive;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  Auth get auth => _auth;

  UserDetailData(
      {int id,
      String name,
      String userName,
      String email,
      dynamic image,
      String phone,
      String address,
      dynamic country,
      dynamic city,
      dynamic state,
      dynamic postalCode,
      String lat,
      String long,
      dynamic location,
      dynamic status,
      dynamic isActive,
      String createdAt,
      String updatedAt,
      Auth auth}) {
    _id = id;
    _name = name;
    _userName = userName;
    _email = email;
    _image = image;
    _phone = phone;
    _address = address;
    _country = country;
    _city = city;
    _state = state;
    _postalCode = postalCode;
    _lat = lat;
    _long = long;
    _location = location;
    _status = status;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _auth = auth;
  }

  UserDetailData.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _userName = json["user_name"];
    _email = json["email"];
    _image = json["image"];
    _phone = json["phone"];
    _address = json["address"];
    _country = json["country"];
    _city = json["city"];
    _state = json["state"];
    _postalCode = json["postal_code"];
    _lat = json["lat"];
    _long = json["long"];
    _location = json["location"];
    _status = json["status"];
    _isActive = json["is_active"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _auth = json["auth"] != null ? Auth.fromJson(json["auth"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["user_name"] = _userName;
    map["email"] = _email;
    map["image"] = _image;
    map["phone"] = _phone;
    map["address"] = _address;
    map["country"] = _country;
    map["city"] = _city;
    map["state"] = _state;
    map["postal_code"] = _postalCode;
    map["lat"] = _lat;
    map["long"] = _long;
    map["location"] = _location;
    map["status"] = _status;
    map["is_active"] = _isActive;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_auth != null) {
      map["auth"] = _auth.toJson();
    }
    return map;
  }
}

class Auth {
  int _id;
  int _userId;
  String _role;
  String _token;
  dynamic _createdAt;
  dynamic _updatedAt;

  int get id => _id;
  int get userId => _userId;
  String get role => _role;
  String get token => _token;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Auth(
      {int id,
      int userId,
      String role,
      String token,
      dynamic createdAt,
      dynamic updatedAt}) {
    _id = id;
    _userId = userId;
    _role = role;
    _token = token;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Auth.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _role = json["role"];
    _token = json["token"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["role"] = _role;
    map["token"] = _token;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
