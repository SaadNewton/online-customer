// @dart=2.9

import 'package:doctoworld_user/Models/all_categories_model.dart';
import 'package:doctoworld_user/Models/check_status_model.dart';
import 'package:doctoworld_user/Models/get_all_appointments_model.dart';
import 'package:doctoworld_user/Models/get_all_doctors_model.dart';
import 'package:doctoworld_user/Models/get_all_labs_model.dart';
import 'package:doctoworld_user/Models/get_all_orders_model.dart';
import 'package:doctoworld_user/Models/get_all_tests_by_category.dart';
import 'package:doctoworld_user/Models/get_alllab_departments_model.dart';
import 'package:doctoworld_user/Models/get_appointment_slots_model.dart';
import 'package:doctoworld_user/Models/get_cart_items_model.dart';
import 'package:doctoworld_user/Models/get_doctor_categories.dart';
import 'package:doctoworld_user/Models/get_doctors_by_category_model.dart';
import 'package:doctoworld_user/Models/get_payment_method_model.dart';
import 'package:doctoworld_user/Models/get_product_by_category_model.dart';
import 'package:doctoworld_user/Models/user_detail_model.dart';
import 'package:flutter/material.dart';

/// user model object
///
UserDetailModel userDetailModel;

/// all categories model object
///
AllCategoriesModel allCategoriesModel;

/// products by category model object
///
GetProductByCategoryModel getProductsByCategoryModel;

/// get all labs model object
///
GetAllLabsModel getAllLabsModel = GetAllLabsModel();

/// get all doctors model object
///
GetAllDoctorsModel allDoctorsModel = GetAllDoctorsModel();

/// get all lab departments model object
///
GetAllLabDepartmentsModel getAllLabDepartmentsModel =
    GetAllLabDepartmentsModel();

/// get all tests by category model object
///
GetAllTestsByCategory getAllTestsByCategory = GetAllTestsByCategory();

/// get-doctor-category model object
///
GetDoctorCategories getDoctorCategories = GetDoctorCategories();

///  get-doctor-by-category model object
///
GetDoctorsByCategoryModel getDoctorsByCategoryModel =
    GetDoctorsByCategoryModel();

/// GetCartItemsModel model object
///
GetCartItemsModel getCartItemsModel=GetCartItemsModel();

///   GetPaymentMethodModel model object
///
GetPaymentMethodModel getPaymentMethodModel=GetPaymentMethodModel();

/// GetAppointmentSlotsModel model object
///
GetAppointmentSlotsModel getAppointmentSlotsModel=GetAppointmentSlotsModel();

/// GetAllOrdersModel model object
///
GetAllOrdersModel getAllOrdersModel=GetAllOrdersModel();

/// GetAllAppointmentsModel model object
///
GetAllAppointmentsModel getAllAppointmentsModel=GetAllAppointmentsModel();


CheckStatusModel checkStatusModel = CheckStatusModel();
final TextEditingController nameController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController confirmPassController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController locationController = TextEditingController();
final TextEditingController numberController = TextEditingController();



final TextEditingController addressController = TextEditingController();

var longitude;
var latitude;
var currentAddress;


bool isCartPage;

String productPrice;