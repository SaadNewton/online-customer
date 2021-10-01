//@dart=2.9

import 'package:doctoworld_user/Models/get_product_by_category_model.dart';

class GetMedicineFromSearchModel {
  List<ProductDetailData> _data;
  bool _status;
  int _success;
  String _message;

  List<ProductDetailData> get data => _data;
  bool get status => _status;
  int get success => _success;
  String get message => _message;

  GetMedicineFromSearchModel({
      List<ProductDetailData> data,
      bool status, 
      int success, 
      String message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetMedicineFromSearchModel.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(ProductDetailData.fromJson(v));
      });
    }
    _status = json["status"];
    _success = json["success"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    map["success"] = _success;
    map["message"] = _message;
    return map;
  }

}

/// id : 1
/// product_category_id : 1
/// company_id : 2
/// name : "Arinac"
/// salt_name : "Arinac"
/// slug : "arinac"
/// potency : "20mg"
/// image_path : null
/// retail_price : "4"
/// sale_price : "4"
/// on_sale : "yes"
/// is_feature : "no"
/// is_item_type : "0"
/// item_type_price : null
/// sku : "1986"
/// status : ""
/// is_active : "yes"
/// description : "Get Your Medicine"
/// created_at : "2021-08-26 10:55:02"
/// updated_at : "2021-08-26 06:54:07"

