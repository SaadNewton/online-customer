class GetCartItemsModel {
  List<Data>? _data;
  bool? _status;
  int? _success;
  String? _message;

  List<Data>? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetCartItemsModel({
      List<Data>? data, 
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetCartItemsModel.fromJson(dynamic json) {
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
  int? _id;
  dynamic? _sessionId;
  int? _customerId;
  int? _productId;
  String? _qty;
  String? _price;
  dynamic? _discount;
  String? _type;
  dynamic? _labId;
  dynamic? _pharmacyId;
  String? _createdAt;
  String? _updatedAt;
  Medicine? _medicine;
  Test? _test;

  int? get id => _id;
  dynamic? get sessionId => _sessionId;
  int? get customerId => _customerId;
  int? get productId => _productId;
  String? get qty => _qty;
  String? get price => _price;
  dynamic? get discount => _discount;
  String? get type => _type;
  dynamic? get labId => _labId;
  dynamic? get pharmacyId => _pharmacyId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Medicine? get medicine => _medicine;
  Test? get test => _test;

  Data({
      int? id, 
      dynamic? sessionId, 
      int? customerId, 
      int? productId, 
      String? qty, 
      String? price, 
      dynamic? discount, 
      String? type, 
      dynamic? labId, 
      dynamic? pharmacyId, 
      String? createdAt, 
      String? updatedAt, 
      Medicine? medicine, 
      Test? test}){
    _id = id;
    _sessionId = sessionId;
    _customerId = customerId;
    _productId = productId;
    _qty = qty;
    _price = price;
    _discount = discount;
    _type = type;
    _labId = labId;
    _pharmacyId = pharmacyId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _medicine = medicine;
    _test = test;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _sessionId = json['session_id'];
    _customerId = json['customer_id'];
    _productId = json['product_id'];
    _qty = json['qty'];
    _price = json['price'];
    _discount = json['discount'];
    _type = json['type'];
    _labId = json['lab_id'];
    _pharmacyId = json['pharmacy_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _medicine = json['medicine'] != null ? Medicine.fromJson(json['medicine']) : null;
    _test = json['test'] != null ? Test.fromJson(json['test']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['session_id'] = _sessionId;
    map['customer_id'] = _customerId;
    map['product_id'] = _productId;
    map['qty'] = _qty;
    map['price'] = _price;
    map['discount'] = _discount;
    map['type'] = _type;
    map['lab_id'] = _labId;
    map['pharmacy_id'] = _pharmacyId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_medicine != null) {
      map['medicine'] = _medicine?.toJson();
    }
    if (_test != null) {
      map['test'] = _test?.toJson();
    }
    return map;
  }

}

class Test {
  int? _id;
  int? _labId;
  int? _testCategoryId;
  String? _name;
  String? _slug;
  String? _imagePath;
  String? _price;
  String? _estTime;
  int? _isAvailableForHome;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  String? _salePrice;

  int? get id => _id;
  int? get labId => _labId;
  int? get testCategoryId => _testCategoryId;
  String? get name => _name;
  String? get slug => _slug;
  String? get imagePath => _imagePath;
  String? get price => _price;
  String? get estTime => _estTime;
  int? get isAvailableForHome => _isAvailableForHome;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get salePrice => _salePrice;

  Test({
      int? id, 
      int? labId, 
      int? testCategoryId, 
      String? name, 
      String? slug, 
      String? imagePath, 
      String? price, 
      String? estTime, 
      int? isAvailableForHome, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      String? salePrice}){
    _id = id;
    _labId = labId;
    _testCategoryId = testCategoryId;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _price = price;
    _estTime = estTime;
    _isAvailableForHome = isAvailableForHome;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _salePrice = salePrice;
}

  Test.fromJson(dynamic json) {
    _id = json['id'];
    _labId = json['lab_id'];
    _testCategoryId = json['test_category_id'];
    _name = json['name'];
    _slug = json['slug'];
    _imagePath = json['image_path'];
    _price = json['price'];
    _estTime = json['est_time'];
    _isAvailableForHome = json['is_available_for_home'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['lab_id'] = _labId;
    map['test_category_id'] = _testCategoryId;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image_path'] = _imagePath;
    map['price'] = _price;
    map['est_time'] = _estTime;
    map['is_available_for_home'] = _isAvailableForHome;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['sale_price'] = _salePrice;
    return map;
  }

}

class Medicine {
  int? _id;
  int? _productCategoryId;
  int? _companyId;
  String? _name;
  String? _saltName;
  String? _slug;
  String? _potency;
  dynamic? _imagePath;
  String? _retailPrice;
  String? _salePrice;
  String? _onSale;
  String? _isFeature;
  String? _isItemType;
  dynamic? _itemTypePrice;
  String? _sku;
  String? _status;
  String? _isActive;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get productCategoryId => _productCategoryId;
  int? get companyId => _companyId;
  String? get name => _name;
  String? get saltName => _saltName;
  String? get slug => _slug;
  String? get potency => _potency;
  dynamic? get imagePath => _imagePath;
  String? get retailPrice => _retailPrice;
  String? get salePrice => _salePrice;
  String? get onSale => _onSale;
  String? get isFeature => _isFeature;
  String? get isItemType => _isItemType;
  dynamic? get itemTypePrice => _itemTypePrice;
  String? get sku => _sku;
  String? get status => _status;
  String? get isActive => _isActive;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Medicine({
      int? id, 
      int? productCategoryId, 
      int? companyId, 
      String? name, 
      String? saltName, 
      String? slug, 
      String? potency, 
      dynamic? imagePath, 
      String? retailPrice, 
      String? salePrice, 
      String? onSale, 
      String? isFeature, 
      String? isItemType, 
      dynamic? itemTypePrice, 
      String? sku, 
      String? status, 
      String? isActive, 
      String? description, 
      String? createdAt, 
      String? updatedAt}){
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
}

  Medicine.fromJson(dynamic json) {
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
    return map;
  }

}