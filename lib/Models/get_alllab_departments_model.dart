class GetAllLabDepartmentsModel {
  List<Data>? _data;
  bool? _status;
  int? _success;
  String? _message;

  List<Data>? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetAllLabDepartmentsModel(
      {List<Data>? data, bool? status, int? success, String? message}) {
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  GetAllLabDepartmentsModel.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _status = json["status"];
    _success = json["success"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data?.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    map["success"] = _success;
    map["message"] = _message;
    return map;
  }
}

class Data {
  int? _id;
  int? _labId;
  String? _name;
  String? _slug;
  String? _imagePath;
  String? _discription;
  dynamic? _isActive;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get labId => _labId;
  String? get name => _name;
  String? get slug => _slug;
  String? get imagePath => _imagePath;
  String? get discription => _discription;
  dynamic? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Data(
      {int? id,
      int? labId,
      String? name,
      String? slug,
      String? imagePath,
      String? discription,
      dynamic? isActive,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _labId = labId;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _discription = discription;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _labId = json["lab_id"];
    _name = json["name"];
    _slug = json["slug"];
    _imagePath = json["image_path"];
    _discription = json["discription"];
    _isActive = json["is_active"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["lab_id"] = _labId;
    map["name"] = _name;
    map["slug"] = _slug;
    map["image_path"] = _imagePath;
    map["discription"] = _discription;
    map["is_active"] = _isActive;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
