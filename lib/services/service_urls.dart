import 'package:flutter/rendering.dart';

/// base url
///
String baseUrl = 'http://192.168.88.44:8000/api/';
// String baseUrl = 'https://onlinedoctor.pk/api/';
// String baseUrl = 'https://onlinedoctor.softwaresbranding.com/api/';



/// image base url
///
String imageBaseUrl = 'http://192.168.88.44:8000/';
// String imageBaseUrl = 'https://onlinedoctor.pk/';
// String imageBaseUrl = 'https://onlinedoctor.softwaresbranding.com/';

String getDoctorProfileService = baseUrl + 'get-doctor-profile';


///schedule
///
String getScheduleBySiteService = baseUrl + 'get-schedules-by-site';
String getScheduleByClinicService = baseUrl + 'get-schedule-by-clinic';


///medicine search
String medicineSearchService = baseUrl + 'medicine-filter';
String searchService = baseUrl + 'get-filtered-data';


///articles
///
String allArticlesService = baseUrl + 'get-all-articles';

///customer signUp
///
String customerSignUpService = baseUrl + 'user-signup';

///login
///
String loginService = baseUrl + 'login';

/// all categories
///
String getAllCategoriesService = baseUrl + 'get-all-category';

/// get product by category
///
String getProductByCategoryService = baseUrl + 'get-product-by-category';

/// get-all-pharmacy
///
String getAllPharmaciesService = baseUrl + 'get-all-pharmacy';

///get-all-lab
///
String getAllLabsService = baseUrl + 'get-all-lab';

///get-test-category-by-lab
///
String getTestCategoriesService = baseUrl + 'get-test-category-by-lab';

///get-all-doctor
///
String getAllDoctorsService = baseUrl + 'get-all-doctor';

///get-test-by-test-category
///
String getAllTestsByCategoryService = baseUrl + 'get-test-by-test-category';

/// get-doctor-category
///
String getDoctorCategoriesService = baseUrl + 'get-doctor-category';

/// get-doctor-by-category
///
String getDoctorsByCategoryService = baseUrl + 'get-doctor-by-category';

/// add-to-cart
///
String addToCartService = baseUrl + 'add-to-cart';

/// get-cart-details
///
String getCartProductsService=baseUrl+'get-cart-details';

///order-place
///
String orderPlaceService=baseUrl+'order-place';

/// get-payment-method
///
String getPaymentMethodsService=baseUrl+'get-payment-method';

/// check-phone-status
///
String phoneEmailCheckService = baseUrl + 'check-phone-status';

/// get-apointment-slot
///
String getAppointmentSlotsService=baseUrl+'get-apointment-slot';

/// book-appointment
///
String bookAppointmentService=baseUrl+'book-appointment';

/// get-all-order
///
String getAllOrdersService=baseUrl+'get-all-order';

/// update-cart-single
///
 String updateCartItem=baseUrl+'updat-cart-single';

 /// get-all-appointments
///
 String getAllAppointmentsService=baseUrl+'get-all-appointments';

 /// change password

String changePasswordService =baseUrl +'change-password';

/// forgot password email

String passwordEmailService =baseUrl +'forgot-password-email';

/// for got password email verify

String passwordEmailVerifyService = baseUrl + 'forgot-password-email-verify';

/// forgot password

String resetPasswordService = baseUrl + 'reset-password';

/// contact us

String contactUsService = baseUrl + 'contact-us';

///  String order prescription

String orderPrescriptionService = baseUrl + 'order-with-prescription';

/// customer-login-with-phone
///
String loginWithPhone=baseUrl+'customer-login-with-phone';

/// get-notify-token-by-user
///
String getNotifyTokenService=baseUrl+'get-notify-token-by-user';

/// create-notify-user
///
String createNotifyUserService=baseUrl+'create-notify-user';

/// CUSTOMER EDIT Profile
///
String editProfileService = baseUrl + 'update-customer-profile';

/// Rating Doctor

String ratingService = baseUrl + 'rate-doctor';

/// fcm service
///
String fcmService = 'https://fcm.googleapis.com/fcm/send';

String walletHistoryService = baseUrl + 'get-wallet-by-user-type';
String addMoneyService = baseUrl + 'store-wallet';

String agoraService = baseUrl + 'agora-token';


/// prescription order Status change


String orderStatusService = baseUrl + 'order-change-status';

String sendMessageService = baseUrl + 'send-message';

String fetchChatService=baseUrl+'fetch-messages';

///  Prescription download url

String prescriptionUrlService = baseUrl + 'prescription-url';

///  Prescription download url

String labsTestsSearchService = baseUrl + 'lab-test-search';