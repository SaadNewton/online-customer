class GetProductByCategoryModel {
  GetProductByCategory? _data;
  bool? _status;
  int? _success;
  String? _message;

  GetProductByCategory? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetProductByCategoryModel({
    GetProductByCategory? data,
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetProductByCategoryModel.fromJson(dynamic json) {
    _data = json['data'] != null ? GetProductByCategory.fromJson(json['data']) : null;
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

class GetProductByCategory {
  int? _currentPage;
  List<ProductDetailData>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  dynamic? _nextPageUrl;
  String? _path;
  int? _perPage;
  String? _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  List<ProductDetailData>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  dynamic? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  String? get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  GetProductByCategory({
      int? currentPage, 
      List<ProductDetailData>? data,
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      dynamic? nextPageUrl, 
      String? path, 
      int? perPage, 
      String? prevPageUrl, 
      int? to, 
      int? total}){
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

  GetProductByCategory.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProductDetailData.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class ProductDetailData {
  int? _id;
  int? _productCategoryId;
  int? _companyId;
  String? _name;
  String? _saltName;
  String? _slug;
  String? _potency;
  String? _imagePath;
  String? _retailPrice;
  String? _salePrice;
  String? _onSale;
  String? _isFeature;
  String? _isItemType;
  dynamic? _itemTypePrice;
  String? _sku;
  dynamic? _status;
  dynamic? _isActive;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  dynamic? _itemPrice;
  Company? _company;
  Category? _category;

  int? get id => _id;
  int? get productCategoryId => _productCategoryId;
  int? get companyId => _companyId;
  String? get name => _name;
  String? get saltName => _saltName;
  String? get slug => _slug;
  String? get potency => _potency;
  String? get imagePath => _imagePath;
  String? get retailPrice => _retailPrice;
  String? get salePrice => _salePrice;
  String? get onSale => _onSale;
  String? get isFeature => _isFeature;
  String? get isItemType => _isItemType;
  dynamic? get itemTypePrice => _itemTypePrice;
  String? get sku => _sku;
  dynamic? get status => _status;
  dynamic? get isActive => _isActive;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic? get itemPrice => _itemPrice;
  Company? get company => _company;
  Category? get category => _category;

  ProductDetailData({
      int? id, 
      int? productCategoryId, 
      int? companyId, 
      String? name, 
      String? saltName, 
      String? slug, 
      String? potency, 
      String? imagePath, 
      String? retailPrice, 
      String? salePrice, 
      String? onSale, 
      String? isFeature, 
      String? isItemType, 
      dynamic? itemTypePrice, 
      String? sku, 
      dynamic? status, 
      dynamic? isActive, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      dynamic? itemPrice, 
      Company? company, 
      Category? category}){
    _id = id;
    _productCategoryId = productCategoryId;
    _companyId = companyId;
    _name = name;
    _saltName = saltName;
    _slug = slug;
    _potency = potency;
    _imagePath = imagePath;
    _retailPrice = retailPrice;
    _salePrice = salePrice;
    _onSale = onSale;
    _isFeature = isFeature;
    _isItemType = isItemType;
    _itemTypePrice = itemTypePrice;
    _sku = sku;
    _status = status;
    _isActive = isActive;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _itemPrice = itemPrice;
    _company = company;
    _category = category;
}

  ProductDetailData.fromJson(dynamic json) {
    _id = json['id'];
    _productCategoryId = json['product_category_id'];
    _companyId = json['company_id'];
    _name = json['name'];
    _saltName = json['salt_name'];
    _slug = json['slug'];
    _potency = json['potency'];
    _imagePath = json['image_path'];
    _retailPrice = json['retail_price'];
    _salePrice = json['sale_price'];
    _onSale = json['on_sale'];
    _isFeature = json['is_feature'];
    _isItemType = json['is_item_type'];
    _itemTypePrice = json['item_type_price'];
    _sku = json['sku'];
    _status = json['status'];
    _isActive = json['is_active'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _itemPrice = json['item_price'];
    _company = json['company'] != null ? Company.fromJson(json['company']) : null;
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['product_category_id'] = _productCategoryId;
    map['company_id'] = _companyId;
    map['name'] = _name;
    map['salt_name'] = _saltName;
    map['slug'] = _slug;
    map['potency'] = _potency;
    map['image_path'] = _imagePath;
    map['retail_price'] = _retailPrice;
    map['sale_price'] = _salePrice;
    map['on_sale'] = _onSale;
    map['is_feature'] = _isFeature;
    map['is_item_type'] = _isItemType;
    map['item_type_price'] = _itemTypePrice;
    map['sku'] = _sku;
    map['status'] = _status;
    map['is_active'] = _isActive;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['item_price'] = _itemPrice;
    if (_company != null) {
      map['company'] = _company?.toJson();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }

}

class Category {
  int? _id;
  String? _name;
  String? _imagePath;

  int? get id => _id;
  String? get name => _name;
  String? get imagePath => _imagePath;

  Category({
      int? id, 
      String? name, 
      String? imagePath}){
    _id = id;
    _name = name;
    _imagePath = imagePath;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image_path'] = _imagePath;
    return map;
  }

}

class Company {
  int? _id;
  String? _name;
  String? _imagePath;

  int? get id => _id;
  String? get name => _name;
  String? get imagePath => _imagePath;

  Company({
      int? id, 
      String? name, 
      String? imagePath}){
    _id = id;
    _name = name;
    _imagePath = imagePath;
}

  Company.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image_path'] = _imagePath;
    return map;
  }

}