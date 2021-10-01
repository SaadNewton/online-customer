class GetAllAppointmentsModel {
  AppointmentsData? _data;
  bool? _status;
  int? _success;
  String? _message;

  AppointmentsData? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetAllAppointmentsModel({
    AppointmentsData? data,
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetAllAppointmentsModel.fromJson(dynamic json) {
    _data = json['data'] != null ? AppointmentsData.fromJson(json['data']) : null;
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

class AppointmentsData {
  int? _currentPage;
  List<SingleAppointmentData>? _data;
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
  List<SingleAppointmentData>? get data => _data;
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

  AppointmentsData({
      int? currentPage, 
      List<SingleAppointmentData>? data,
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

  AppointmentsData.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SingleAppointmentData.fromJson(v));
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

class SingleAppointmentData {
  int? _id;
  int? _doctorId;
  int? _customerId;
  int? _clinicId;
  dynamic _entryDoctor;
  dynamic _assistant;
  dynamic _staff;
  int? _admin;
  int? _site;
  String? _name;
  String? _email;
  String? _mobile;
  int? _age;
  String? _disease;
  String? _bookingDate;
  String? _bookingType;
  String? _timeSerial;
  int? _pStatus;
  dynamic _trx;
  int? _isComplete;
  int? _dStatus;
  dynamic _dDoctor;
  dynamic _dAssistant;
  dynamic _dStaff;
  int? _dAdmin;
  String? _createdAt;
  String? _updatedAt;
  Doctor? _doctor;

  int? get id => _id;
  int? get doctorId => _doctorId;
  int? get customerId => _customerId;
  int? get clinicId => _clinicId;
  dynamic get entryDoctor => _entryDoctor;
  dynamic get assistant => _assistant;
  dynamic get staff => _staff;
  int? get admin => _admin;
  int? get site => _site;
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  int? get age => _age;
  String? get disease => _disease;
  String? get bookingDate => _bookingDate;
  String? get bookingType => _bookingType;
  String? get timeSerial => _timeSerial;
  int? get pStatus => _pStatus;
  dynamic get trx => _trx;
  int? get isComplete => _isComplete;
  int? get dStatus => _dStatus;
  dynamic get dDoctor => _dDoctor;
  dynamic get dAssistant => _dAssistant;
  dynamic get dStaff => _dStaff;
  int? get dAdmin => _dAdmin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Doctor? get doctor => _doctor;

  SingleAppointmentData({
    int? id,
    int? doctorId,
    int? customerId,
    int? clinicId,
    dynamic entryDoctor,
    dynamic assistant,
    dynamic staff,
    int? admin,
    int? site,
    String? name,
    String? email,
    String? mobile,
    int? age,
    String? disease,
    String? bookingDate,
    String? bookingType,
    String? timeSerial,
    int? pStatus,
    dynamic trx,
    int? isComplete,
    int? dStatus,
    dynamic dDoctor,
    dynamic dAssistant,
    dynamic dStaff,
    int? dAdmin,
    String? createdAt,
    String? updatedAt,
    Doctor? doctor}){
    _id = id;
    _doctorId = doctorId;
    _customerId = customerId;
    _clinicId = clinicId;
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
    _bookingType = bookingType;
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
    _doctor = doctor;
  }

  SingleAppointmentData.fromJson(dynamic json) {
    _id = json["id"];
    _doctorId = json["doctor_id"];
    _customerId = json["customer_id"];
    _clinicId = json["clinic_id"];
    _entryDoctor = json["entry_doctor"];
    _assistant = json["assistant"];
    _staff = json["staff"];
    _admin = json["admin"];
    _site = json["site"];
    _name = json["name"];
    _email = json["email"];
    _mobile = json["mobile"];
    _age = json["age"];
    _disease = json["disease"];
    _bookingDate = json["booking_date"];
    _bookingType = json["booking_type"];
    _timeSerial = json["time_serial"];
    _pStatus = json["p_status"];
    _trx = json["trx"];
    _isComplete = json["is_complete"];
    _dStatus = json["d_status"];
    _dDoctor = json["d_doctor"];
    _dAssistant = json["d_assistant"];
    _dStaff = json["d_staff"];
    _dAdmin = json["d_admin"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _doctor = json["doctor"] != null ? Doctor.fromJson(json["doctor"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["doctor_id"] = _doctorId;
    map["customer_id"] = _customerId;
    map["clinic_id"] = _clinicId;
    map["entry_doctor"] = _entryDoctor;
    map["assistant"] = _assistant;
    map["staff"] = _staff;
    map["admin"] = _admin;
    map["site"] = _site;
    map["name"] = _name;
    map["email"] = _email;
    map["mobile"] = _mobile;
    map["age"] = _age;
    map["disease"] = _disease;
    map["booking_date"] = _bookingDate;
    map["booking_type"] = _bookingType;
    map["time_serial"] = _timeSerial;
    map["p_status"] = _pStatus;
    map["trx"] = _trx;
    map["is_complete"] = _isComplete;
    map["d_status"] = _dStatus;
    map["d_doctor"] = _dDoctor;
    map["d_assistant"] = _dAssistant;
    map["d_staff"] = _dStaff;
    map["d_admin"] = _dAdmin;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_doctor != null) {
      map["doctor"] = _doctor!.toJson();
    }
    return map;
  }

}

class Doctor {
  int? _id;
  String? _name;
  String? _username;
  String? _email;
  String? _mobile;
  int? _otpIsVerified;
  dynamic? _refBy;
  String? _balance;
  String? _image;
  String? _address;
  dynamic? _lat;
  dynamic? _long;
  int? _sectorId;
  int? _locationId;
  String? _qualification;
  int? _rating;
  int? _status;
  int? _ev;
  int? _sv;
  dynamic? _verCode;
  dynamic? _verCodeSendAt;
  int? _ts;
  int? _tv;
  dynamic? _tsc;
  int? _fees;
  int? _slotType;
  String? _startTime;
  String? _endTime;
  int? _serialDay;
  dynamic? _serialDayApp;
  int? _maxSerial;
  int? _duration;
  List<String>? _serialOrSlot;
  String? _about;
  int? _featured;
  dynamic? _speciality;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get username => _username;
  String? get email => _email;
  String? get mobile => _mobile;
  int? get otpIsVerified => _otpIsVerified;
  dynamic? get refBy => _refBy;
  String? get balance => _balance;
  String? get image => _image;
  String? get address => _address;
  dynamic? get lat => _lat;
  dynamic? get long => _long;
  int? get sectorId => _sectorId;
  int? get locationId => _locationId;
  String? get qualification => _qualification;
  int? get rating => _rating;
  int? get status => _status;
  int? get ev => _ev;
  int? get sv => _sv;
  dynamic? get verCode => _verCode;
  dynamic? get verCodeSendAt => _verCodeSendAt;
  int? get ts => _ts;
  int? get tv => _tv;
  dynamic? get tsc => _tsc;
  int? get fees => _fees;
  int? get slotType => _slotType;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  int? get serialDay => _serialDay;
  dynamic? get serialDayApp => _serialDayApp;
  int? get maxSerial => _maxSerial;
  int? get duration => _duration;
  List<String>? get serialOrSlot => _serialOrSlot;
  String? get about => _about;
  int? get featured => _featured;
  dynamic? get speciality => _speciality;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Doctor({
      int? id, 
      String? name, 
      String? username, 
      String? email, 
      String? mobile, 
      int? otpIsVerified, 
      dynamic? refBy, 
      String? balance, 
      String? image, 
      String? address, 
      dynamic? lat, 
      dynamic? long, 
      int? sectorId, 
      int? locationId, 
      String? qualification, 
      int? rating, 
      int? status, 
      int? ev, 
      int? sv, 
      dynamic? verCode, 
      dynamic? verCodeSendAt, 
      int? ts, 
      int? tv, 
      dynamic? tsc, 
      int? fees, 
      int? slotType, 
      String? startTime, 
      String? endTime, 
      int? serialDay, 
      dynamic? serialDayApp, 
      int? maxSerial, 
      int? duration, 
      List<String>? serialOrSlot, 
      String? about, 
      int? featured, 
      dynamic? speciality, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _name = name;
    _username = username;
    _email = email;
    _mobile = mobile;
    _otpIsVerified = otpIsVerified;
    _refBy = refBy;
    _balance = balance;
    _image = image;
    _address = address;
    _lat = lat;
    _long = long;
    _sectorId = sectorId;
    _locationId = locationId;
    _qualification = qualification;
    _rating = rating;
    _status = status;
    _ev = ev;
    _sv = sv;
    _verCode = verCode;
    _verCodeSendAt = verCodeSendAt;
    _ts = ts;
    _tv = tv;
    _tsc = tsc;
    _fees = fees;
    _slotType = slotType;
    _startTime = startTime;
    _endTime = endTime;
    _serialDay = serialDay;
    _serialDayApp = serialDayApp;
    _maxSerial = maxSerial;
    _duration = duration;
    _serialOrSlot = serialOrSlot;
    _about = about;
    _featured = featured;
    _speciality = speciality;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Doctor.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _username = json['username'];
    _email = json['email'];
    _mobile = json['mobile'];
    _otpIsVerified = json['otp_is_verified'];
    _refBy = json['ref_by'];
    _balance = json['balance'];
    _image = json['image'];
    _address = json['address'];
    _lat = json['lat'];
    _long = json['long'];
    _sectorId = json['sector_id'];
    _locationId = json['location_id'];
    _qualification = json['qualification'];
    _rating = json['rating'];
    _status = json['status'];
    _ev = json['ev'];
    _sv = json['sv'];
    _verCode = json['ver_code'];
    _verCodeSendAt = json['ver_code_send_at'];
    _ts = json['ts'];
    _tv = json['tv'];
    _tsc = json['tsc'];
    _fees = json['fees'];
    _slotType = json['slot_type'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _serialDay = json['serial_day'];
    _serialDayApp = json['serial_day_app'];
    _maxSerial = json['max_serial'];
    _duration = json['duration'];
    _serialOrSlot = json['serial_or_slot'] != null ? json['serial_or_slot'].cast<String>() : [];
    _about = json['about'];
    _featured = json['featured'];
    _speciality = json['speciality'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['username'] = _username;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['otp_is_verified'] = _otpIsVerified;
    map['ref_by'] = _refBy;
    map['balance'] = _balance;
    map['image'] = _image;
    map['address'] = _address;
    map['lat'] = _lat;
    map['long'] = _long;
    map['sector_id'] = _sectorId;
    map['location_id'] = _locationId;
    map['qualification'] = _qualification;
    map['rating'] = _rating;
    map['status'] = _status;
    map['ev'] = _ev;
    map['sv'] = _sv;
    map['ver_code'] = _verCode;
    map['ver_code_send_at'] = _verCodeSendAt;
    map['ts'] = _ts;
    map['tv'] = _tv;
    map['tsc'] = _tsc;
    map['fees'] = _fees;
    map['slot_type'] = _slotType;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['serial_day'] = _serialDay;
    map['serial_day_app'] = _serialDayApp;
    map['max_serial'] = _maxSerial;
    map['duration'] = _duration;
    map['serial_or_slot'] = _serialOrSlot;
    map['about'] = _about;
    map['featured'] = _featured;
    map['speciality'] = _speciality;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}