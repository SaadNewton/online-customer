class GetAllOrdersModel {
  GetOrdersData? _data;
  bool? _status;
  int? _success;
  String? _message;

  GetOrdersData? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetAllOrdersModel({
    GetOrdersData? data,
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetAllOrdersModel.fromJson(dynamic json) {
    _data = json['data'] != null ? GetOrdersData.fromJson(json['data']) : null;
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

class GetOrdersData {
  int? _currentPage;
  List<SingleOrderDetail>? _data;
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
  List<SingleOrderDetail>? get data => _data;
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

  GetOrdersData({
      int? currentPage, 
      List<SingleOrderDetail>? data,
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      dynamic? nextPageUrl, 
      String? path, 
      int? perPage, 
      dynamic? prevPageUrl, 
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

  GetOrdersData.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SingleOrderDetail.fromJson(v));
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

class SingleOrderDetail {
  int? _id;
  int? _customerId;
  dynamic? _sessionId;
  dynamic? _customerName;
  dynamic? _shippingMethod;
  String? _paymentMethod;
  String? _subTotal;
  String? _totalPrice;
  String? _shippingPrice;
  String? _tax;
  dynamic? _discount;
  dynamic? _status;
  dynamic? _labId;
  dynamic? _pharmacyId;
  int? _isPrescription;
  int? _isOrderApproved;
  dynamic? _imagePath1;
  dynamic? _imagePath2;
  String? _createdAt;
  String? _updatedAt;
  List<Order_product>? _orderProduct;
  Order_shipping? _orderShipping;
  Customer? _customer;

  int? get id => _id;
  int? get customerId => _customerId;
  dynamic? get sessionId => _sessionId;
  dynamic? get customerName => _customerName;
  dynamic? get shippingMethod => _shippingMethod;
  String? get paymentMethod => _paymentMethod;
  String? get subTotal => _subTotal;
  String? get totalPrice => _totalPrice;
  String? get shippingPrice => _shippingPrice;
  String? get tax => _tax;
  dynamic? get discount => _discount;
  dynamic? get status => _status;
  dynamic? get labId => _labId;
  dynamic? get pharmacyId => _pharmacyId;
  int? get isPrescription => _isPrescription;
  int? get isOrderApproved => _isOrderApproved;
  dynamic? get imagePath1 => _imagePath1;
  dynamic? get imagePath2 => _imagePath2;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Order_product>? get orderProduct => _orderProduct;
  Order_shipping? get orderShipping => _orderShipping;
  Customer? get customer => _customer;

  SingleOrderDetail({
      int? id, 
      int? customerId, 
      dynamic? sessionId, 
      dynamic? customerName, 
      dynamic? shippingMethod, 
      String? paymentMethod, 
      String? subTotal, 
      String? totalPrice, 
      String? shippingPrice, 
      String? tax, 
      dynamic? discount, 
      dynamic? status, 
      dynamic? labId, 
      dynamic? pharmacyId, 
      int? isPrescription, 
      int? isOrderApproved, 
      dynamic? imagePath1, 
      dynamic? imagePath2, 
      String? createdAt, 
      String? updatedAt, 
      List<Order_product>? orderProduct, 
      Order_shipping? orderShipping, 
      Customer? customer}){
    _id = id;
    _customerId = customerId;
    _sessionId = sessionId;
    _customerName = customerName;
    _shippingMethod = shippingMethod;
    _paymentMethod = paymentMethod;
    _subTotal = subTotal;
    _totalPrice = totalPrice;
    _shippingPrice = shippingPrice;
    _tax = tax;
    _discount = discount;
    _status = status;
    _labId = labId;
    _pharmacyId = pharmacyId;
    _isPrescription = isPrescription;
    _isOrderApproved = isOrderApproved;
    _imagePath1 = imagePath1;
    _imagePath2 = imagePath2;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _orderProduct = orderProduct;
    _orderShipping = orderShipping;
    _customer = customer;
}

  SingleOrderDetail.fromJson(dynamic json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _sessionId = json['session_id'];
    _customerName = json['customer_name'];
    _shippingMethod = json['shipping_method'];
    _paymentMethod = json['payment_method'];
    _subTotal = json['sub_total'];
    _totalPrice = json['total_price'];
    _shippingPrice = json['shipping_price'];
    _tax = json['tax'];
    _discount = json['discount'];
    _status = json['status'];
    _labId = json['lab_id'];
    _pharmacyId = json['pharmacy_id'];
    _isPrescription = json['is_prescription'];
    _isOrderApproved = json['is_order_approved'];
    _imagePath1 = json['image_path1'];
    _imagePath2 = json['image_path2'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['order_product'] != null) {
      _orderProduct = [];
      json['order_product'].forEach((v) {
        _orderProduct?.add(Order_product.fromJson(v));
      });
    }
    _orderShipping = json['order_shipping'] != null ? Order_shipping.fromJson(json['order_shipping']) : null;
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['customer_id'] = _customerId;
    map['session_id'] = _sessionId;
    map['customer_name'] = _customerName;
    map['shipping_method'] = _shippingMethod;
    map['payment_method'] = _paymentMethod;
    map['sub_total'] = _subTotal;
    map['total_price'] = _totalPrice;
    map['shipping_price'] = _shippingPrice;
    map['tax'] = _tax;
    map['discount'] = _discount;
    map['status'] = _status;
    map['lab_id'] = _labId;
    map['pharmacy_id'] = _pharmacyId;
    map['is_prescription'] = _isPrescription;
    map['is_order_approved'] = _isOrderApproved;
    map['image_path1'] = _imagePath1;
    map['image_path2'] = _imagePath2;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_orderProduct != null) {
      map['order_product'] = _orderProduct?.map((v) => v.toJson()).toList();
    }
    if (_orderShipping != null) {
      map['order_shipping'] = _orderShipping?.toJson();
    }
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    return map;
  }

}

class Customer {
  int? _id;
  String? _name;
  String? _userName;
  String? _email;
  dynamic? _image;
  String? _phone;
  int? _otpIsVerified;
  String? _address;
  dynamic? _country;
  dynamic? _city;
  dynamic? _state;
  dynamic? _postalCode;
  String? _lat;
  String? _long;
  dynamic? _location;
  dynamic? _status;
  dynamic? _isActive;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get email => _email;
  dynamic? get image => _image;
  String? get phone => _phone;
  int? get otpIsVerified => _otpIsVerified;
  String? get address => _address;
  dynamic? get country => _country;
  dynamic? get city => _city;
  dynamic? get state => _state;
  dynamic? get postalCode => _postalCode;
  String? get lat => _lat;
  String? get long => _long;
  dynamic? get location => _location;
  dynamic? get status => _status;
  dynamic? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Customer({
      int? id, 
      String? name, 
      String? userName, 
      String? email, 
      dynamic? image, 
      String? phone, 
      int? otpIsVerified, 
      String? address, 
      dynamic? country, 
      dynamic? city, 
      dynamic? state, 
      dynamic? postalCode, 
      String? lat, 
      String? long, 
      dynamic? location, 
      dynamic? status, 
      dynamic? isActive, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _name = name;
    _userName = userName;
    _email = email;
    _image = image;
    _phone = phone;
    _otpIsVerified = otpIsVerified;
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
}

  Customer.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _userName = json['user_name'];
    _email = json['email'];
    _image = json['image'];
    _phone = json['phone'];
    _otpIsVerified = json['otp_is_verified'];
    _address = json['address'];
    _country = json['country'];
    _city = json['city'];
    _state = json['state'];
    _postalCode = json['postal_code'];
    _lat = json['lat'];
    _long = json['long'];
    _location = json['location'];
    _status = json['status'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['user_name'] = _userName;
    map['email'] = _email;
    map['image'] = _image;
    map['phone'] = _phone;
    map['otp_is_verified'] = _otpIsVerified;
    map['address'] = _address;
    map['country'] = _country;
    map['city'] = _city;
    map['state'] = _state;
    map['postal_code'] = _postalCode;
    map['lat'] = _lat;
    map['long'] = _long;
    map['location'] = _location;
    map['status'] = _status;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Order_shipping {
  int? _id;
  int? _orderId;
  String? _name;
  String? _email;
  String? _companyName;
  String? _phoneNumber;
  String? _address;
  String? _city;
  String? _country;
  String? _state;
  String? _postalCode;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get orderId => _orderId;
  String? get name => _name;
  String? get email => _email;
  String? get companyName => _companyName;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get city => _city;
  String? get country => _country;
  String? get state => _state;
  String? get postalCode => _postalCode;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Order_shipping({
      int? id, 
      int? orderId, 
      String? name, 
      String? email, 
      String? companyName, 
      String? phoneNumber, 
      String? address, 
      String? city, 
      String? country, 
      String? state, 
      String? postalCode, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _orderId = orderId;
    _name = name;
    _email = email;
    _companyName = companyName;
    _phoneNumber = phoneNumber;
    _address = address;
    _city = city;
    _country = country;
    _state = state;
    _postalCode = postalCode;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Order_shipping.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _name = json['name'];
    _email = json['email'];
    _companyName = json['company_name'];
    _phoneNumber = json['phone_number'];
    _address = json['address'];
    _city = json['city'];
    _country = json['country'];
    _state = json['state'];
    _postalCode = json['postal_code'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['name'] = _name;
    map['email'] = _email;
    map['company_name'] = _companyName;
    map['phone_number'] = _phoneNumber;
    map['address'] = _address;
    map['city'] = _city;
    map['country'] = _country;
    map['state'] = _state;
    map['postal_code'] = _postalCode;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Order_product {
  int? _id;
  int? _orderId;
  int? _productId;
  int? _categoryId;
  int? _companyId;
  String? _name;
  String? _saltName;
  String? _imagePath;
  dynamic? _retailPrice;
  String? _salePrice;
  String? _itemTypeName;
  String? _sku;
  String? _qty;
  String? _potency;
  String? _type;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get orderId => _orderId;
  int? get productId => _productId;
  int? get categoryId => _categoryId;
  int? get companyId => _companyId;
  String? get name => _name;
  String? get saltName => _saltName;
  String? get imagePath => _imagePath;
  dynamic? get retailPrice => _retailPrice;
  String? get salePrice => _salePrice;
  String? get itemTypeName => _itemTypeName;
  String? get sku => _sku;
  String? get qty => _qty;
  String? get potency => _potency;
  String? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Order_product({
      int? id, 
      int? orderId, 
      int? productId, 
      int? categoryId, 
      int? companyId, 
      String? name, 
      String? saltName, 
      String? imagePath, 
      dynamic? retailPrice, 
      String? salePrice, 
      String? itemTypeName, 
      String? sku, 
      String? qty, 
      String? potency, 
      String? type, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _orderId = orderId;
    _productId = productId;
    _categoryId = categoryId;
    _companyId = companyId;
    _name = name;
    _saltName = saltName;
    _imagePath = imagePath;
    _retailPrice = retailPrice;
    _salePrice = salePrice;
    _itemTypeName = itemTypeName;
    _sku = sku;
    _qty = qty;
    _potency = potency;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Order_product.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _productId = json['product_id'];
    _categoryId = json['category_id'];
    _companyId = json['company_id'];
    _name = json['name'];
    _saltName = json['salt_name'];
    _imagePath = json['image_path'];
    _retailPrice = json['retail_price'];
    _salePrice = json['sale_price'];
    _itemTypeName = json['item_type_name'];
    _sku = json['sku'];
    _qty = json['qty'];
    _potency = json['potency'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['product_id'] = _productId;
    map['category_id'] = _categoryId;
    map['company_id'] = _companyId;
    map['name'] = _name;
    map['salt_name'] = _saltName;
    map['image_path'] = _imagePath;
    map['retail_price'] = _retailPrice;
    map['sale_price'] = _salePrice;
    map['item_type_name'] = _itemTypeName;
    map['sku'] = _sku;
    map['qty'] = _qty;
    map['potency'] = _potency;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}