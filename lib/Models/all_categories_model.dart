// @dart=2.10

class AllCategoriesModel {
  AllCategoriesData _data;
  bool _status;
  int _success;
  String _message;

  AllCategoriesData get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  AllCategoriesModel(
      {AllCategoriesData data, bool status, int success, String message}) {
    _data = data;
    _status = status;
    _success = success;
    _message = message;
  }

  AllCategoriesModel.fromJson(dynamic json) {
    _data =
        json["data"] != null ? AllCategoriesData.fromJson(json["data"]) : null;
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

class AllCategoriesData {
  int _currentPage;
  List<SingleCategoryData> _data;
  String _firstPageUrl;
  int _from;
  int _lastPage;
  String _lastPageUrl;
  dynamic _nextPageUrl;
  String _path;
  int _perPage;
  dynamic _prevPageUrl;
  int _to;
  int _total;

  int get currentPage => _currentPage;
  List<SingleCategoryData> get data => _data;
  String get firstPageUrl => _firstPageUrl;
  int get from => _from;
  int get lastPage => _lastPage;
  String get lastPageUrl => _lastPageUrl;
  dynamic get nextPageUrl => _nextPageUrl;
  String get path => _path;
  int get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int get to => _to;
  int get total => _total;

  AllCategoriesData(
      {int currentPage,
      List<SingleCategoryData> data,
      String firstPageUrl,
      int from,
      int lastPage,
      String lastPageUrl,
      dynamic nextPageUrl,
      String path,
      int perPage,
      dynamic prevPageUrl,
      int to,
      int total}) {
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

  AllCategoriesData.fromJson(dynamic json) {
    _currentPage = json["current_page"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(SingleCategoryData.fromJson(v));
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
      map["data"] = _data.map((v) => v.toJson()).toList();
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

class SingleCategoryData {
  int _id;
  dynamic _parentId;
  String _name;
  String _slug;
  String _imagePath;
  String _description;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  dynamic get parentId => _parentId;
  String get name => _name;
  String get slug => _slug;
  String get imagePath => _imagePath;
  String get description => _description;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  SingleCategoryData(
      {int id,
      dynamic parentId,
      String name,
      String slug,
      String imagePath,
      String description,
      String createdAt,
      String updatedAt}) {
    _id = id;
    _parentId = parentId;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  SingleCategoryData.fromJson(dynamic json) {
    _id = json["id"];
    _parentId = json["parent_id"];
    _name = json["name"];
    _slug = json["slug"];
    _imagePath = json["image_path"];
    _description = json["description"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["parent_id"] = _parentId;
    map["name"] = _name;
    map["slug"] = _slug;
    map["image_path"] = _imagePath;
    map["description"] = _description;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
