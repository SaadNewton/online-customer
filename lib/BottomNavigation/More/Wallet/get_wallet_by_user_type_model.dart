/// data : [{"id":1,"user_type":"customer","reference_id":1,"amount":3000,"last_transaction_amount":"2000","current_amount":"0","transaction_type":null,"description":null,"is_active":"1","created_at":"2021-09-29T11:16:44.000000Z","updated_at":"2021-09-29T11:19:47.000000Z","transactions":[{"id":1,"wallet_id":1,"reference_id":1,"user_type":"customer","amount":"1000","amount_type":"credit","description":null,"created_at":"2021-09-29T11:16:44.000000Z","updated_at":"2021-09-29T11:16:44.000000Z"},{"id":2,"wallet_id":1,"reference_id":1,"user_type":"customer","amount":"2000","amount_type":"credit","description":null,"created_at":"2021-09-29T11:19:47.000000Z","updated_at":"2021-09-29T11:19:47.000000Z"}]}]
/// status : true
/// success : 1
/// message : "Fetching record"

class GetWalletByUserTypeModel {
  List<Data>? _data;
  bool? _status;
  int? _success;
  String? _message;

  List<Data>? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetWalletByUserTypeModel({
      List<Data>? data, 
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetWalletByUserTypeModel.fromJson(dynamic json) {
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

/// id : 1
/// user_type : "customer"
/// reference_id : 1
/// amount : 3000
/// last_transaction_amount : "2000"
/// current_amount : "0"
/// transaction_type : null
/// description : null
/// is_active : "1"
/// created_at : "2021-09-29T11:16:44.000000Z"
/// updated_at : "2021-09-29T11:19:47.000000Z"
/// transactions : [{"id":1,"wallet_id":1,"reference_id":1,"user_type":"customer","amount":"1000","amount_type":"credit","description":null,"created_at":"2021-09-29T11:16:44.000000Z","updated_at":"2021-09-29T11:16:44.000000Z"},{"id":2,"wallet_id":1,"reference_id":1,"user_type":"customer","amount":"2000","amount_type":"credit","description":null,"created_at":"2021-09-29T11:19:47.000000Z","updated_at":"2021-09-29T11:19:47.000000Z"}]

class Data {
  int? _id;
  String? _userType;
  int? _referenceId;
  int? _amount;
  String? _lastTransactionAmount;
  String? _currentAmount;
  dynamic? _transactionType;
  dynamic? _description;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  List<Transactions>? _transactions;

  int? get id => _id;
  String? get userType => _userType;
  int? get referenceId => _referenceId;
  int? get amount => _amount;
  String? get lastTransactionAmount => _lastTransactionAmount;
  String? get currentAmount => _currentAmount;
  dynamic? get transactionType => _transactionType;
  dynamic? get description => _description;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Transactions>? get transactions => _transactions;

  Data({
      int? id, 
      String? userType, 
      int? referenceId, 
      int? amount, 
      String? lastTransactionAmount, 
      String? currentAmount, 
      dynamic? transactionType, 
      dynamic? description, 
      String? isActive, 
      String? createdAt, 
      String? updatedAt, 
      List<Transactions>? transactions}){
    _id = id;
    _userType = userType;
    _referenceId = referenceId;
    _amount = amount;
    _lastTransactionAmount = lastTransactionAmount;
    _currentAmount = currentAmount;
    _transactionType = transactionType;
    _description = description;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _transactions = transactions;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userType = json['user_type'];
    _referenceId = json['reference_id'];
    _amount = json['amount'];
    _lastTransactionAmount = json['last_transaction_amount'];
    _currentAmount = json['current_amount'];
    _transactionType = json['transaction_type'];
    _description = json['description'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['transactions'] != null) {
      _transactions = [];
      json['transactions'].forEach((v) {
        _transactions?.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['user_type'] = _userType;
    map['reference_id'] = _referenceId;
    map['amount'] = _amount;
    map['last_transaction_amount'] = _lastTransactionAmount;
    map['current_amount'] = _currentAmount;
    map['transaction_type'] = _transactionType;
    map['description'] = _description;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_transactions != null) {
      map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// wallet_id : 1
/// reference_id : 1
/// user_type : "customer"
/// amount : "1000"
/// amount_type : "credit"
/// description : null
/// created_at : "2021-09-29T11:16:44.000000Z"
/// updated_at : "2021-09-29T11:16:44.000000Z"

class Transactions {
  int? _id;
  int? _walletId;
  int? _referenceId;
  String? _userType;
  String? _amount;
  String? _amountType;
  dynamic? _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get walletId => _walletId;
  int? get referenceId => _referenceId;
  String? get userType => _userType;
  String? get amount => _amount;
  String? get amountType => _amountType;
  dynamic? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Transactions({
      int? id, 
      int? walletId, 
      int? referenceId, 
      String? userType, 
      String? amount, 
      String? amountType, 
      dynamic? description, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _walletId = walletId;
    _referenceId = referenceId;
    _userType = userType;
    _amount = amount;
    _amountType = amountType;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Transactions.fromJson(dynamic json) {
    _id = json['id'];
    _walletId = json['wallet_id'];
    _referenceId = json['reference_id'];
    _userType = json['user_type'];
    _amount = json['amount'];
    _amountType = json['amount_type'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['wallet_id'] = _walletId;
    map['reference_id'] = _referenceId;
    map['user_type'] = _userType;
    map['amount'] = _amount;
    map['amount_type'] = _amountType;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}