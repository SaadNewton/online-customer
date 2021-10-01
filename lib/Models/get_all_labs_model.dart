/// data : {"current_page":1,"data":[{"id":4,"name":"Islamabad Diagnostic Centre (IDC)","user_name":null,"email":"IDC123@gmail.com","owner_image":null,"password":"$2y$10$yxLps3lv0mrKusZOv1m.SuVfNuZVAUK5Gzd0jV8WO7WvMXgOc2gtS","slug":"islamabad-diagnostic-centre-idc","owner_name":"John Smith","owner_phone":"03045I778","contact_name":"John Smith","contact_phone":"03045I7575","image_path":"assets/admin/lab/1628774360_download.png","country":"Pakistan","city":"Faisalabad","address":"People's Colony No 1, Faisalabad, Pakistan","lat":"31.41072359999999","long":"73.10840519999999","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:19:20","updated_at":"2021-08-13 10:31:14","distance":46.819656338321948396696825511753559112548828125},{"id":5,"name":"Excel Labs","user_name":null,"email":"excellab123@gmail.com","owner_image":null,"password":"$2y$10$xeC2nFFpxhp5fhB1GmkqgO9GrGh1mt/CJssQmi0u6TaH29OatCeXK","slug":"excel-labs","owner_name":"Bilal Hassan","owner_phone":"03045I88788","contact_name":"Kery John","contact_phone":"03045I57788","image_path":"assets/admin/lab/1628774549_download (1).png","country":"Pakistan","city":"Faisalabad","address":"People's Colony No 1, Faisalabad, Pakistan","lat":"31.41072359999999","long":"73.10840519999999","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:22:29","updated_at":"2021-08-13 10:32:48","distance":46.819656338321948396696825511753559112548828125},{"id":6,"name":"Alnoor Diagnostic Centre","user_name":null,"email":"alnoor456@gmail.com","owner_image":null,"password":"$2y$10$K2aRHDIXFWeo1U4XJ1j4Keu/y4SjYoyD/.1wYrHpJ1U2dk0EXCovG","slug":"alnoor-diagnostic-centre","owner_name":"Alnoor Diagnostic Centre","owner_phone":"0333558585","contact_name":"Alnoor Diagnostic Centre","contact_phone":"033266161112","image_path":"assets/admin/lab/1628774690_download (1).jpg","country":"Pakistan","city":"Faisalabad","address":"no 1 People's Colony, Block C People's Colony No 1, Faisalabad, Pakistan","lat":"31.41072359999999","long":"73.10840519999999","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:24:50","updated_at":"2021-08-13 10:35:11","distance":46.819656338321948396696825511753559112548828125},{"id":7,"name":"AL-Nasar Lab","user_name":null,"email":"alnasar789@gmail.com","owner_image":null,"password":"$2y$10$c5/OBf5repb3SrvrbcOl.OLk1w6u6Cr34uZAqmAEEJP11MVEnNv5e","slug":"al-nasar-lab","owner_name":"AL-Nasar Lab","owner_phone":"0225454545","contact_name":"AL-Nasar Lab","contact_phone":"0333555554","image_path":"assets/admin/lab/1628774921_images.jpg","country":"Pakistan","city":"Faisalabad","address":"no 1 People's Colony, Block C People's Colony No 1, Faisalabad, Pakistan","lat":"31.41072359999999","long":"73.10840519999999","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:28:41","updated_at":"2021-08-13 10:35:50","distance":46.819656338321948396696825511753559112548828125},{"id":3,"name":"Chughtai Lab, Lahore","user_name":null,"email":"Chughtai123@gmail.com","owner_image":null,"password":"$2y$10$sCQAbN26Q6.LbeiVAOLTZec8dxlieaNXqnKnxNmCfQgcPgj6zZVme","slug":"chughtai-lab-lahore","owner_name":"Chughtai Lab","owner_phone":"03030005555","contact_name":"Whit Smith","contact_phone":"03030002252","image_path":"assets/admin/lab/1628774027_download.jpg","country":"Pakistan","city":"Faisalabad","address":"102-C People colony#1 jaranwala road,faisalabad","lat":"31.4133163","long":"73.1131872","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:13:47","updated_at":"2021-08-13 10:31:54","distance":47.20252157964231543019195669330656528472900390625}],"first_page_url":"https://onlinedoctor.softwaresbranding.com/api/get-all-lab?page=1","from":1,"last_page":1,"last_page_url":"https://onlinedoctor.softwaresbranding.com/api/get-all-lab?page=1","next_page_url":null,"path":"https://onlinedoctor.softwaresbranding.com/api/get-all-lab","per_page":20,"prev_page_url":null,"to":5,"total":5}
/// status : true
/// success : 1
/// message : "Fetching record"

class GetAllLabsModel {
  GetAllLabsData? _data;
  bool? _status;
  int? _success;
  String? _message;

  GetAllLabsData? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetAllLabsModel(
      {GetAllLabsData? data, bool? status, int? success, String? message}) {
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  GetAllLabsModel.fromJson(dynamic json) {
    _data = json["data"] != null ? GetAllLabsData.fromJson(json["data"]) : null;
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

/// current_page : 1
/// data : [{"id":4,"name":"Islamabad Diagnostic Centre (IDC)","user_name":null,"email":"IDC123@gmail.com","owner_image":null,"password":"$2y$10$yxLps3lv0mrKusZOv1m.SuVfNuZVAUK5Gzd0jV8WO7WvMXgOc2gtS","slug":"islamabad-diagnostic-centre-idc","owner_name":"John Smith","owner_phone":"03045I778","contact_name":"John Smith","contact_phone":"03045I7575","image_path":"assets/admin/lab/1628774360_download.png","country":"Pakistan","city":"Faisalabad","address":"People's Colony No 1, Faisalabad, Pakistan","lat":"31.41072359999999","long":"73.10840519999999","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:19:20","updated_at":"2021-08-13 10:31:14","distance":46.819656338321948396696825511753559112548828125},{"id":5,"name":"Excel Labs","user_name":null,"email":"excellab123@gmail.com","owner_image":null,"password":"$2y$10$xeC2nFFpxhp5fhB1GmkqgO9GrGh1mt/CJssQmi0u6TaH29OatCeXK","slug":"excel-labs","owner_name":"Bilal Hassan","owner_phone":"03045I88788","contact_name":"Kery John","contact_phone":"03045I57788","image_path":"assets/admin/lab/1628774549_download (1).png","country":"Pakistan","city":"Faisalabad","address":"People's Colony No 1, Faisalabad, Pakistan","lat":"31.41072359999999","long":"73.10840519999999","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:22:29","updated_at":"2021-08-13 10:32:48","distance":46.819656338321948396696825511753559112548828125},{"id":6,"name":"Alnoor Diagnostic Centre","user_name":null,"email":"alnoor456@gmail.com","owner_image":null,"password":"$2y$10$K2aRHDIXFWeo1U4XJ1j4Keu/y4SjYoyD/.1wYrHpJ1U2dk0EXCovG","slug":"alnoor-diagnostic-centre","owner_name":"Alnoor Diagnostic Centre","owner_phone":"0333558585","contact_name":"Alnoor Diagnostic Centre","contact_phone":"033266161112","image_path":"assets/admin/lab/1628774690_download (1).jpg","country":"Pakistan","city":"Faisalabad","address":"no 1 People's Colony, Block C People's Colony No 1, Faisalabad, Pakistan","lat":"31.41072359999999","long":"73.10840519999999","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:24:50","updated_at":"2021-08-13 10:35:11","distance":46.819656338321948396696825511753559112548828125},{"id":7,"name":"AL-Nasar Lab","user_name":null,"email":"alnasar789@gmail.com","owner_image":null,"password":"$2y$10$c5/OBf5repb3SrvrbcOl.OLk1w6u6Cr34uZAqmAEEJP11MVEnNv5e","slug":"al-nasar-lab","owner_name":"AL-Nasar Lab","owner_phone":"0225454545","contact_name":"AL-Nasar Lab","contact_phone":"0333555554","image_path":"assets/admin/lab/1628774921_images.jpg","country":"Pakistan","city":"Faisalabad","address":"no 1 People's Colony, Block C People's Colony No 1, Faisalabad, Pakistan","lat":"31.41072359999999","long":"73.10840519999999","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:28:41","updated_at":"2021-08-13 10:35:50","distance":46.819656338321948396696825511753559112548828125},{"id":3,"name":"Chughtai Lab, Lahore","user_name":null,"email":"Chughtai123@gmail.com","owner_image":null,"password":"$2y$10$sCQAbN26Q6.LbeiVAOLTZec8dxlieaNXqnKnxNmCfQgcPgj6zZVme","slug":"chughtai-lab-lahore","owner_name":"Chughtai Lab","owner_phone":"03030005555","contact_name":"Whit Smith","contact_phone":"03030002252","image_path":"assets/admin/lab/1628774027_download.jpg","country":"Pakistan","city":"Faisalabad","address":"102-C People colony#1 jaranwala road,faisalabad","lat":"31.4133163","long":"73.1131872","status":null,"is_active":"1","is_verified":1,"created_at":"2021-08-12 13:13:47","updated_at":"2021-08-13 10:31:54","distance":47.20252157964231543019195669330656528472900390625}]
/// first_page_url : "https://onlinedoctor.softwaresbranding.com/api/get-all-lab?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://onlinedoctor.softwaresbranding.com/api/get-all-lab?page=1"
/// next_page_url : null
/// path : "https://onlinedoctor.softwaresbranding.com/api/get-all-lab"
/// per_page : 20
/// prev_page_url : null
/// to : 5
/// total : 5

class GetAllLabsData {
  int? _currentPage;
  List<SingleLabData>? _data;
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
  List<SingleLabData>? get data => _data;
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

  GetAllLabsData(
      {int? currentPage,
      List<SingleLabData>? data,
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

  GetAllLabsData.fromJson(dynamic json) {
    _currentPage = json["current_page"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(SingleLabData.fromJson(v));
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

/// id : 4
/// name : "Islamabad Diagnostic Centre (IDC)"
/// user_name : null
/// email : "IDC123@gmail.com"
/// owner_image : null
/// password : "$2y$10$yxLps3lv0mrKusZOv1m.SuVfNuZVAUK5Gzd0jV8WO7WvMXgOc2gtS"
/// slug : "islamabad-diagnostic-centre-idc"
/// owner_name : "John Smith"
/// owner_phone : "03045I778"
/// contact_name : "John Smith"
/// contact_phone : "03045I7575"
/// image_path : "assets/admin/lab/1628774360_download.png"
/// country : "Pakistan"
/// city : "Faisalabad"
/// address : "People's Colony No 1, Faisalabad, Pakistan"
/// lat : "31.41072359999999"
/// long : "73.10840519999999"
/// status : null
/// is_active : "1"
/// is_verified : 1
/// created_at : "2021-08-12 13:19:20"
/// updated_at : "2021-08-13 10:31:14"
/// distance : 46.819656338321948396696825511753559112548828125

class SingleLabData {
  int? _id;
  String? _name;
  dynamic? _userName;
  String? _email;
  dynamic? _ownerImage;
  String? _password;
  String? _slug;
  String? _ownerName;
  String? _ownerPhone;
  String? _contactName;
  String? _contactPhone;
  String? _imagePath;
  String? _country;
  String? _city;
  String? _address;
  String? _lat;
  String? _long;
  dynamic? _status;
  String? _isActive;
  int? _isVerified;
  String? _createdAt;
  String? _updatedAt;
  double? _distance;

  int? get id => _id;
  String? get name => _name;
  dynamic? get userName => _userName;
  String? get email => _email;
  dynamic? get ownerImage => _ownerImage;
  String? get password => _password;
  String? get slug => _slug;
  String? get ownerName => _ownerName;
  String? get ownerPhone => _ownerPhone;
  String? get contactName => _contactName;
  String? get contactPhone => _contactPhone;
  String? get imagePath => _imagePath;
  String? get country => _country;
  String? get city => _city;
  String? get address => _address;
  String? get lat => _lat;
  String? get long => _long;
  dynamic? get status => _status;
  String? get isActive => _isActive;
  int? get isVerified => _isVerified;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  double? get distance => _distance;

  SingleLabData(
      {int? id,
      String? name,
      dynamic? userName,
      String? email,
      dynamic? ownerImage,
      String? password,
      String? slug,
      String? ownerName,
      String? ownerPhone,
      String? contactName,
      String? contactPhone,
      String? imagePath,
      String? country,
      String? city,
      String? address,
      String? lat,
      String? long,
      dynamic? status,
      String? isActive,
      int? isVerified,
      String? createdAt,
      String? updatedAt,
      double? distance}) {
    _id = id;
    _name = name;
    _userName = userName;
    _email = email;
    _ownerImage = ownerImage;
    _password = password;
    _slug = slug;
    _ownerName = ownerName;
    _ownerPhone = ownerPhone;
    _contactName = contactName;
    _contactPhone = contactPhone;
    _imagePath = imagePath;
    _country = country;
    _city = city;
    _address = address;
    _lat = lat;
    _long = long;
    _status = status;
    _isActive = isActive;
    _isVerified = isVerified;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _distance = distance;
  }

  SingleLabData.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _userName = json["user_name"];
    _email = json["email"];
    _ownerImage = json["owner_image"];
    _password = json["password"];
    _slug = json["slug"];
    _ownerName = json["owner_name"];
    _ownerPhone = json["owner_phone"];
    _contactName = json["contact_name"];
    _contactPhone = json["contact_phone"];
    _imagePath = json["image_path"];
    _country = json["country"];
    _city = json["city"];
    _address = json["address"];
    _lat = json["lat"];
    _long = json["long"];
    _status = json["status"];
    _isActive = json["is_active"];
    _isVerified = json["is_verified"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _distance = json["distance"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["user_name"] = _userName;
    map["email"] = _email;
    map["owner_image"] = _ownerImage;
    map["password"] = _password;
    map["slug"] = _slug;
    map["owner_name"] = _ownerName;
    map["owner_phone"] = _ownerPhone;
    map["contact_name"] = _contactName;
    map["contact_phone"] = _contactPhone;
    map["image_path"] = _imagePath;
    map["country"] = _country;
    map["city"] = _city;
    map["address"] = _address;
    map["lat"] = _lat;
    map["long"] = _long;
    map["status"] = _status;
    map["is_active"] = _isActive;
    map["is_verified"] = _isVerified;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["distance"] = _distance;
    return map;
  }
}
