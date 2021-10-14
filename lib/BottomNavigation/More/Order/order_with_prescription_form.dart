// @dart=2.9
import 'dart:developer';
import 'dart:io';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:dio/dio.dart' as dio_instance;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PrescriptionOrder extends StatefulWidget {

  @override
  _PrescriptionOrderState createState() => _PrescriptionOrderState();
}

class _PrescriptionOrderState extends State<PrescriptionOrder> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  var currentPosition;
  GlobalKey<FormState> _prescriptionKey = GlobalKey();

  final ImagePicker _picker = ImagePicker();


  File image1;
  File image2;
  File image;

  bool _imageChecker1 = false;
  bool _imageChecker2 = false;

  Future getImage(bool isFront) async {
    final photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (photo != null) {

        image = File(photo.path);
        if(isFront){
          image1 = image;
        }else{
          image2 = image;
        }
      } else {
        print('No image selected.');
      }
    });
  }

  final _scrollController = ScrollController();

  @override
  void dispose() {
    // _nameController.dispose();
    // _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (loaderController) => ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Prescription Order',
            style: TextStyle(color: Colors.black),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
          ),
          resizeToAvoidBottomInset: false,
          body: FadedSlideAnimation(
            Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _prescriptionKey,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            children: [
                              ///............. image.............///
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ///...........Front file............///
                                 Column(
                                   children: [

                                     image1 == null
                                         ? InkWell(
                                       onTap: () {
                                         setState(() {
                                           getImage(true);
                                         });



                                       },
                                       child: Container(
                                         height: 100,
                                         width: 120,
                                         decoration: BoxDecoration(
                                           color: Colors.grey.withOpacity(0.2),
                                           borderRadius: BorderRadius.circular(5),),
                                         child: Padding(
                                           padding: const EdgeInsets.all(4.0),
                                           child: Column(
                                             mainAxisAlignment:
                                             MainAxisAlignment.spaceEvenly,
                                             crossAxisAlignment:
                                             CrossAxisAlignment.center,
                                             children: [
                                               Icon(
                                                 Icons.photo,
                                                 size: 18,
                                               ),
                                               Text(
                                                 'Front File',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     fontSize: 12,
                                                     color: Colors.black),
                                               )
                                             ],
                                           ),
                                         ),
                                       ),
                                     )
                                         :    Container(
                                       decoration: BoxDecoration(
                                         color: Colors.grey.withOpacity(0.2),),
                                       height: 100,
                                       width: 120,
                                       child: Image.file(
                                         image1,
                                       ),
                                     ),
                                     SizedBox(height: 10,),
                                     _imageChecker1 ? Text('Image Required',
                                       style: TextStyle(color: Colors.red),
                                     ) : SizedBox(),

                                   ],
                                 ),

                                    ///...........Back file............///
                                 Column(
                                   children: [
                                     image2 == null
                                         ?  InkWell(
                                       onTap: () {
                                         setState(() {
                                           getImage(false);
                                         });
                                       },
                                       child: Container(
                                         height: 100,
                                         width: 120,
                                         decoration: BoxDecoration(
                                           color: Colors.grey.withOpacity(0.2),
                                           borderRadius: BorderRadius.circular(5),
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.all(4.0),
                                           child: Column(
                                             mainAxisAlignment:
                                             MainAxisAlignment.spaceEvenly,
                                             crossAxisAlignment:
                                             CrossAxisAlignment.center,
                                             children: [
                                               Icon(
                                                 Icons.photo,
                                                 size: 18,
                                               ),
                                               Text(
                                                 'Back File',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     fontSize: 12,
                                                     color: Colors.black),
                                               )
                                             ],
                                           ),
                                         ),
                                       ),
                                     )
                                         : Container(
                                       decoration: BoxDecoration(
                                           color: Colors.grey.withOpacity(0.2)),
                                       height: 100,
                                       width: 120,
                                       child: Image.file(
                                         image2,
                                       ),
                                     ),
                                     SizedBox(height: 10,),
                                     _imageChecker2 ? Text('Image Required',
                                     style: TextStyle(color: Colors.red),
                                     ) : SizedBox(),
                                   ],
                                 ),
                                  ],
                                ),

                              //     : InkWell(
                              //   onTap: () {},
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: Colors.grey.withOpacity(0.2),),
                              //     height: 100,
                              //     width: 120,
                              //     child: Image.file(
                              //       _firstImage,
                              //     ),
                              //   ),
                              // ),
                              // _imageChecker
                              //     ? Text(
                              //   'Image Required',
                              //   style: TextStyle(
                              //       fontSize: 11, color: Colors.red),
                              // )
                              //     : SizedBox(),
                              SizedBox(height: 20),

                              ///...........Name....................///
                              EntryField(
                                textInputFormatter: FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                textInputType: TextInputType.name,
                                controller: _nameController,
                                color: Colors.grey.withOpacity(0.2),
                                hint: 'Name',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),

                              ///..........Phone................///

                              EntryField(
                                textInputFormatter: LengthLimitingTextInputFormatter(11),
                                textInputType: TextInputType.phone,
                                controller: _phoneController,
                                color: Colors.grey.withOpacity(0.2),
                                hint: 'Phone',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),

                              ///.........Address...............///
                              TextFormField(
                                onTap: () {
                                  if(currentCity == null)
                                  getCurrentLocation(context);
                                },
                                controller: _addressController,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    child: Icon(
                                      Icons.add_location,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onTap: () {
                                      getCurrentLocation(context);
                                    },
                                  ),
                                  hintText: 'Address',
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              CustomButton(
                                label: 'Submit',

                               onTap: (){
                                 setState(() {
                                   _imageChecker1 = false;
                                   _imageChecker2 = false;
                                 });
                                 if(_prescriptionKey.currentState.validate() && image1 != null && image2 != null) {

                                    setState(() {
                                      _imageChecker1 = false;
                                      _imageChecker2 = false;
                                    });
                                   Get.find<LoaderController>()
                                       .updateFormController(true);
                                   uploadImage(image1, image2);
                                 }else{
                                   if( image1 == null){
                                     setState(() {
                                       _imageChecker1 = true;

                                     });
                                   }
                                   if( image2 == null){
                                     setState(() {

                                       _imageChecker2 = true;
                                     });
                                   }
                                 }
                               },
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),

        ),
      ),
    );
  }

  String currentCity;
  getCurrentLocation(BuildContext context) {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      longitude=0.0;
      latitude =0.0;
      setState(() {
        currentPosition = position;
        longitude = currentPosition.longitude;
        latitude = currentPosition.latitude;

        print("longitude : $longitude");
        print("latitude : $latitude");
        print("address : $currentPosition");
      });

      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      // var currentPosition;
      List<Placemark> p = await GeocodingPlatform.instance
          .placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        currentAddress =
        '${place.name}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
        setState(() {
          currentCity = place.subAdministrativeArea.toString();
        });
        print(currentAddress + ' yes');
        print(place.administrativeArea.toString());
        print(place.subAdministrativeArea.toString());
        print(place.thoroughfare.toString());
        print(place.toJson().toString());
        // FocusScope.of(context).unfocus();
        _addressController.text = place.name.toString();
      });
    } catch (e) {
      print(e);
    }
  }
bool dialogShow = false;

  uploadImage(File file1, file2) async {
    String fileName1 = file1.path.split('/').last;
    String fileName2 = file2.path.split('/').last;
    dio_instance.FormData formData =
    dio_instance.FormData.fromMap(<String, dynamic>{
      'customer_id': storageBox.read('customerId'),
      'full_name' : _nameController.text,
      'phone':    _phoneController.text,
      'address':  _addressController.text,
      'lat': latitude,
      'long': longitude,
      'city': currentCity,
      'front_file': await dio_instance.MultipartFile.fromFile(
        file1.path,
       // filename: fileName1,
        contentType: new MediaType('image', 'jpeg'), //important
      ),
      'back_file': await dio_instance.MultipartFile.fromFile(
        file2.path,
       // filename: fileName2,
        contentType: new MediaType('image', 'jpeg'), //important
      )
    });
    dio_instance.Dio dio = dio_instance.Dio();
    // setCustomHeader(dio, 'Authorization', 'Bearer ${storageBox.read('accessToken')}');
    dio_instance.Response<dynamic> response;
    try {
      response = await dio.post(orderPrescriptionService, data: formData);
      log('postStatusCode---->> ${response.statusCode}');
      log('postResponse---->> ${response.data}');
      if (response.data['status']==true) {
        setState(() {
          dialogShow = true;
        });
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: 'Success',
                titleColor: customDialogSuccessColor,
                descriptions: response.data['message'].toString(),
                text: 'Ok',
                functionCall: () {
                  Get.offAll(BottomNavigation());
                },
                img: 'assets/dialog_success.svg',
              );
            });
        Get.find<LoaderController>().updateFormController(false);

      }
    } on dio_instance.DioError catch (e) {
      Get.find<LoaderController>().updateFormController(false);
      log('putResponseError---->> ${e}');
    }
  }

  }


