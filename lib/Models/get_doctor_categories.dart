class GetDoctorCategories {
  Data? _data;
  bool? _status;
  int? _success;
  String? _message;

  Data? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetDoctorCategories(
      {Data? data, bool? status, int? success, String? message}) {
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  GetDoctorCategories.fromJson(dynamic json) {
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _status = json["status"];
    _success = json["success"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data?.toJson();
    }
    map["status"] = _status;
    map["success"] = _success;
    map["message"] = _message;
    return map;
  }
}

class Data {
  int? _currentPage;
  List<SingleDoctorCategoryData>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  dynamic? _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic? _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  List<SingleDoctorCategoryData>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  dynamic? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic? get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Data(
      {int? currentPage,
      List<SingleDoctorCategoryData>? data,
      String? firstPageUrl,
      int? from,
      int? lastPage,
      String? lastPageUrl,
      dynamic? nextPageUrl,
      String? path,
      int? perPage,
      dynamic? prevPageUrl,
      int? to,
      int? total}) {
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
  }

  Data.fromJson(dynamic json) {
    _currentPage = json["current_page"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(SingleDoctorCategoryData.fromJson(v));
      });
    }
    _firstPageUrl = json["first_page_url"];
    _from = json["from"];
    _lastPage = json["last_page"];
    _lastPageUrl = json["last_page_url"];
    _nextPageUrl = json["next_page_url"];
    _path = json["path"];
    _perPage = json["per_page"];
    _prevPageUrl = json["prev_page_url"];
    _to = json["to"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = _currentPage;
    if (_data != null) {
      map["data"] = _data?.map((v) => v.toJson()).toList();
    }
    map["first_page_url"] = _firstPageUrl;
    map["from"] = _from;
    map["last_page"] = _lastPage;
    map["last_page_url"] = _lastPageUrl;
    map["next_page_url"] = _nextPageUrl;
    map["path"] = _path;
    map["per_page"] = _perPage;
    map["prev_page_url"] = _prevPageUrl;
    map["to"] = _to;
    map["total"] = _total;
    return map;
  }
}

class SingleDoctorCategoryData {
  int? _id;
  String? _name;
  String? _details;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get details => _details;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  SingleDoctorCategoryData(
      {int? id,
      String? name,
      String? details,
      String? image,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _name = name;
    _details = details;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  SingleDoctorCategoryData.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _details = json["details"];
    _image = json["image"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["details"] = _details;
    map["image"] = _image;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
