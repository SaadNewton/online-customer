class GetAllDoctorsModel {
  DoctorData? _data;
  bool? _status;
  int? _success;
  String? _message;

  DoctorData? get data => _data;
  bool? get status => _status;
  int? get success => _success;
  String? get message => _message;

  GetAllDoctorsModel({
    DoctorData? data,
      bool? status, 
      int? success, 
      String? message}){
    _data = data;
    _status = status;
    _success = success;
    _message = message;
}

  GetAllDoctorsModel.fromJson(dynamic json) {
    _data = json['data'] != null ? DoctorData.fromJson(json['data']) : null;
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

class DoctorData {
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

  DoctorData({
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

  DoctorData.fromJson(dynamic json) {
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
class DoctorDetailData {
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
  List<Serial_day_app>? _serialDayApp;
  int? _maxSerial;
  int? _duration;
  List<String>? _serialOrSlot;
  String? _about;
  int? _featured;
  List<String>? _speciality;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;
  List<Appointments>? _appointments;
  List<Education_details>? _educationDetails;
  List<Experience_details>? _experienceDetails;

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
  List<Serial_day_app>? get serialDayApp => _serialDayApp;
  int? get maxSerial => _maxSerial;
  int? get duration => _duration;
  List<String>? get serialOrSlot => _serialOrSlot;
  String? get about => _about;
  int? get featured => _featured;
  List<String>? get speciality => _speciality;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imagePath => _imagePath;
  List<Appointments>? get appointments => _appointments;
  List<Education_details>? get educationDetails => _educationDetails;
  List<Experience_details>? get experienceDetails => _experienceDetails;

  DoctorDetailData({
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
      List<Serial_day_app>? serialDayApp,
      int? maxSerial,
      int? duration, 
      List<String>? serialOrSlot, 
      String? about, 
      int? featured, 
      List<String>? speciality, 
      String? createdAt, 
      String? updatedAt, 
      String? imagePath, 
      List<Appointments>? appointments, 
      List<Education_details>? educationDetails, 
      List<Experience_details>? experienceDetails}){
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
    _imagePath = imagePath;
    _appointments = appointments;
    _educationDetails = educationDetails;
    _experienceDetails = experienceDetails;
}

  DoctorDetailData.fromJson(dynamic json) {
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
    if (json['serial_day_app'] != null) {
      _serialDayApp = [];
      json['serial_day_app'].forEach((v) {
        _serialDayApp?.add(Serial_day_app.fromJson(v));
      });
    }
    _maxSerial = json['max_serial'];
    _duration = json['duration'];
    _serialOrSlot = json['serial_or_slot'] != null ? json['serial_or_slot'].cast<String>() : [];
    _about = json['about'];
    _featured = json['featured'];
    _speciality = json['speciality'] != null ? json['speciality'].cast<String>() : [];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['image_path'];
    if (json['appointments'] != null) {
      _appointments = [];
      json['appointments'].forEach((v) {
        _appointments?.add(Appointments.fromJson(v));
      });
    }
    if (json['education_details'] != null) {
      _educationDetails = [];
      json['education_details'].forEach((v) {
        _educationDetails?.add(Education_details.fromJson(v));
      });
    }
    if (json['experience_details'] != null) {
      _experienceDetails = [];
      json['experience_details'].forEach((v) {
        _experienceDetails?.add(Experience_details.fromJson(v));
      });
    }
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
    if (_serialDayApp != null) {
      map['serial_day_app'] = _serialDayApp?.map((v) => v.toJson()).toList();
    }
    map['max_serial'] = _maxSerial;
    map['duration'] = _duration;
    map['serial_or_slot'] = _serialOrSlot;
    map['about'] = _about;
    map['featured'] = _featured;
    map['speciality'] = _speciality;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image_path'] = _imagePath;
    if (_appointments != null) {
      map['appointments'] = _appointments?.map((v) => v.toJson()).toList();
    }
    if (_educationDetails != null) {
      map['education_details'] = _educationDetails?.map((v) => v.toJson()).toList();
    }
    if (_experienceDetails != null) {
      map['experience_details'] = _experienceDetails?.map((v) => v.toJson()).toList();
    }
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

class Serial_day_app {
  List<String>? _days;
  List<String>? _slots;
  String? _duration;
  String? _endTime;
  String? _startTime;
  dynamic? _clinicName;
  String? _scheduleType;
  dynamic? _clinicAddress;

  List<String>? get days => _days;
  List<String>? get slots => _slots;
  String? get duration => _duration;
  String? get endTime => _endTime;
  String? get startTime => _startTime;
  dynamic? get clinicName => _clinicName;
  String? get scheduleType => _scheduleType;
  dynamic? get clinicAddress => _clinicAddress;

  Serial_day_app({
      List<String>? days, 
      List<String>? slots, 
      String? duration, 
      String? endTime, 
      String? startTime, 
      dynamic? clinicName, 
      String? scheduleType, 
      dynamic? clinicAddress}){
    _days = days;
    _slots = slots;
    _duration = duration;
    _endTime = endTime;
    _startTime = startTime;
    _clinicName = clinicName;
    _scheduleType = scheduleType;
    _clinicAddress = clinicAddress;
}

  Serial_day_app.fromJson(dynamic json) {
    _days = json['days'] != null ? json['days'].cast<String>() : [];
    _slots = json['slots'] != null ? json['slots'].cast<String>() : [];
    _duration = json['duration'];
    _endTime = json['end_time'];
    _startTime = json['start_time'];
    _clinicName = json['clinic_name'];
    _scheduleType = json['schedule_type'];
    _clinicAddress = json['clinic_address'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['days'] = _days;
    map['slots'] = _slots;
    map['duration'] = _duration;
    map['end_time'] = _endTime;
    map['start_time'] = _startTime;
    map['clinic_name'] = _clinicName;
    map['schedule_type'] = _scheduleType;
    map['clinic_address'] = _clinicAddress;
    return map;
  }

}