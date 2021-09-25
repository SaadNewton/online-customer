import 'package:doctoworld_user/Models/get_all_doctors_model.dart';

class GetDoctorsByCategoryModel {
  DoctorDataByCategory? _data;
  bool? _status;
  int? _success;
  String? _message;

  DoctorDataByCategory? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetDoctorsByCategoryModel({
    DoctorDataByCategory? data,
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetDoctorsByCategoryModel.fromJson(dynamic json) {
    _data = json['data'] != null ? DoctorDataByCategory.fromJson(json['data']) : null;
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

class DoctorDataByCategory {
  int? _currentPage;
  List<DoctorDetailData>? _data;
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
  List<DoctorDetailData>? get data => _data;
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

  DoctorDataByCategory({
      int? currentPage, 
      List<DoctorDetailData>? data,
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

  DoctorDataByCategory.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DoctorDetailData.fromJson(v));
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



class Experience_details {
  int? _id;
  int? _doctorId;
  String? _imagePath;
  String? _institution;
  String? _discipline;
  String? _period;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get doctorId => _doctorId;
  String? get imagePath => _imagePath;
  String? get institution => _institution;
  String? get discipline => _discipline;
  String? get period => _period;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Experience_details({
      int? id,
      int? doctorId,
      String? imagePath,
      String? institution,
      String? discipline,
      String? period,
      String? createdAt,
      String? updatedAt}){
    _id = id;
    _doctorId = doctorId;
    _imagePath = imagePath;
    _institution = institution;
    _discipline = discipline;
    _period = period;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Experience_details.fromJson(dynamic json) {
    _id = json['id'];
    _doctorId = json['doctor_id'];
    _imagePath = json['image_path'];
    _institution = json['institution'];
    _discipline = json['discipline'];
    _period = json['period'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['doctor_id'] = _doctorId;
    map['image_path'] = _imagePath;
    map['institution'] = _institution;
    map['discipline'] = _discipline;
    map['period'] = _period;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Education_details {
  int? _id;
  int? _doctorId;
  String? _imagePath;
  String? _institution;
  String? _discipline;
  String? _period;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get doctorId => _doctorId;
  String? get imagePath => _imagePath;
  String? get institution => _institution;
  String? get discipline => _discipline;
  String? get period => _period;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Education_details({
      int? id,
      int? doctorId,
      String? imagePath,
      String? institution,
      String? discipline,
      String? period,
      String? createdAt,
      String? updatedAt}){
    _id = id;
    _doctorId = doctorId;
    _imagePath = imagePath;
    _institution = institution;
    _discipline = discipline;
    _period = period;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Education_details.fromJson(dynamic json) {
    _id = json['id'];
    _doctorId = json['doctor_id'];
    _imagePath = json['image_path'];
    _institution = json['institution'];
    _discipline = json['discipline'];
    _period = json['period'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['doctor_id'] = _doctorId;
    map['image_path'] = _imagePath;
    map['institution'] = _institution;
    map['discipline'] = _discipline;
    map['period'] = _period;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Appointments {
  int? _id;
  int? _doctorId;
  int? _customerId;
  dynamic? _entryDoctor;
  dynamic? _assistant;
  dynamic? _staff;
  int? _admin;
  int? _site;
  String? _name;
  String? _email;
  String? _mobile;
  int? _age;
  String? _disease;
  String? _bookingDate;
  String? _timeSerial;
  int? _pStatus;
  dynamic? _trx;
  int? _try;
  int? _isComplete;
  int? _dStatus;
  dynamic? _dDoctor;
  dynamic? _dAssistant;
  dynamic? _dStaff;
  int? _dAdmin;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get doctorId => _doctorId;
  int? get customerId => _customerId;
  dynamic? get entryDoctor => _entryDoctor;
  dynamic? get assistant => _assistant;
  dynamic? get staff => _staff;
  int? get admin => _admin;
  int? get site => _site;
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  int? get age => _age;
  String? get disease => _disease;
  String? get bookingDate => _bookingDate;
  String? get timeSerial => _timeSerial;
  int? get pStatus => _pStatus;
  dynamic? get trx => _trx;

  int? get isComplete => _isComplete;
  int? get dStatus => _dStatus;
  dynamic? get dDoctor => _dDoctor;
  dynamic? get dAssistant => _dAssistant;
  dynamic? get dStaff => _dStaff;
  int? get dAdmin => _dAdmin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Appointments({
      int? id,
      int? doctorId,
      int? customerId,
      dynamic? entryDoctor,
      dynamic? assistant,
      dynamic? staff,
      int? admin,
      int? site,
      String? name,
      String? email,
      String? mobile,
      int? age,
      String? disease,
      String? bookingDate,
      String? timeSerial,
      int? pStatus,
      dynamic? trx,

      int? isComplete,
      int? dStatus,
      dynamic? dDoctor,
      dynamic? dAssistant,
      dynamic? dStaff,
      int? dAdmin,
      String? createdAt,
      String? updatedAt}){
    _id = id;
    _doctorId = doctorId;
    _customerId = customerId;
    _entryDoctor = entryDoctor;
    _assistant = assistant;
    _staff = staff;
    _admin = admin;
    _site = site;
    _name = name;
    _email = email;
    _mobile = mobile;
    _age = age;
    _disease = disease;
    _bookingDate = bookingDate;
    _timeSerial = timeSerial;
    _pStatus = pStatus;
    _trx = trx;

    _isComplete = isComplete;
    _dStatus = dStatus;
    _dDoctor = dDoctor;
    _dAssistant = dAssistant;
    _dStaff = dStaff;
    _dAdmin = dAdmin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Appointments.fromJson(dynamic json) {
    _id = json['id'];
    _doctorId = json['doctor_id'];
    _customerId = json['customer_id'];
    _entryDoctor = json['entry_doctor'];
    _assistant = json['assistant'];
    _staff = json['staff'];
    _admin = json['admin'];
    _site = json['site'];
    _name = json['name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _age = json['age'];
    _disease = json['disease'];
    _bookingDate = json['booking_date'];
    _timeSerial = json['time_serial'];
    _pStatus = json['p_status'];
    _trx = json['trx'];
    _try = json['try'];
    _isComplete = json['is_complete'];
    _dStatus = json['d_status'];
    _dDoctor = json['d_doctor'];
    _dAssistant = json['d_assistant'];
    _dStaff = json['d_staff'];
    _dAdmin = json['d_admin'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['doctor_id'] = _doctorId;
    map['customer_id'] = _customerId;
    map['entry_doctor'] = _entryDoctor;
    map['assistant'] = _assistant;
    map['staff'] = _staff;
    map['admin'] = _admin;
    map['site'] = _site;
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['age'] = _age;
    map['disease'] = _disease;
    map['booking_date'] = _bookingDate;
    map['time_serial'] = _timeSerial;
    map['p_status'] = _pStatus;
    map['trx'] = _trx;
    map['try'] = _try;
    map['is_complete'] = _isComplete;
    map['d_status'] = _dStatus;
    map['d_doctor'] = _dDoctor;
    map['d_assistant'] = _dAssistant;
    map['d_staff'] = _dStaff;
    map['d_admin'] = _dAdmin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}