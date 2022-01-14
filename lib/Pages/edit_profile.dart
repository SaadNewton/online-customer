import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/edit_profile_repo.dart';
import 'package:doctoworld_user/repositories/phone_email_check_repo.dart';

import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _editProfileKey = GlobalKey();
  TextEditingController editNameController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();
  TextEditingController editLocationController = TextEditingController();

  var currentPosition;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<LoaderController>(
        init: LoaderController(),
        builder: (_) => ModalProgressHUD(
          inAsyncCall: _.formLoader,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Edit Profile',
               style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          //  backgroundColor: Color(0xffC4EBF2),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: FadedSlideAnimation(
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Form(
                    key: _editProfileKey,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: [
                            Center(
                                child: Image.asset(
                                  'assets/splash-logo.png',
                                  width: 120,
                                  color: Theme.of(context).primaryColor,
                                )),

                            SizedBox(height: 20),

                            /// name
                            EntryField(
                              color: Colors.grey.withOpacity(0.2),
                              textInputFormatter: FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                              textInputType: TextInputType.name,
                              controller: editNameController,
                              prefixIcon: Icons.person,
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



                            /// Email
                            EntryField(
                              color: Colors.grey.withOpacity(0.2),
                              controller: editEmailController,
                              prefixIcon: Icons.mail,
                              hint: locale.emailAddress,
                              // color: Theme.of(context).scaffoldBackgroundColor,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Field is Required';
                                } else if (GetUtils.isEmail(emailController.text)) {
                                  return 'Please Enter Valid Email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20.0),

                            ///  Location
                            TextFormField(

                              controller: editLocationController,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  child: Icon(
                                    Icons.add_location,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onTap: () {
                                    Get.find<LoaderController>().updateFormController(true);
                                    getCurrentLocation(context);
                                  },
                                ),
                                hintText: 'Location',
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field is Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20.0),

                            CustomButton(
                              label: 'Submit',
                              onTap: () {
                                FocusScopeNode currentFocus =
                                FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (_editProfileKey.currentState!.validate()) {
                                  Get.find<LoaderController>()
                                      .updateFormController(true);
                                  postMethod(
                                      context,
                                      editProfileService,
                                      {
                                        'customer_id': storageBox!.read('customerId'),
                                        'name': editNameController.text,
                                        'email': editEmailController.text,
                                        'location': editLocationController.text
                                      },
                                      true,
                                      editProfileRepo);
                                }

                              },
                            ),
                            SizedBox(height: 10.0),
                            // CustomButton(
                            //     label: locale.backToSignIn,
                            //     color: Theme.of(context).scaffoldBackgroundColor,
                            //     textColor: Theme.of(context).hintColor,
                            //     onTap: () {
                            //       Navigator.pop(context);
                            //     }),

                            SizedBox(height: 10.0),

                            // CustomButton(
                            //     color: Theme.of(context).scaffoldBackgroundColor,
                            //     onTap: () {
                            //       Get.to(VerificationUI());
                            //     }),

                            // Text(
                            //   locale.wellSendAnOTP!,
                            //   textAlign: TextAlign.center,
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .bodyText1!
                            //       .copyWith(color: Theme.of(context).disabledColor),
                            // ),


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
        ),
      ),
    );
  }

  getCurrentLocation(BuildContext context) {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        longitude = currentPosition!.longitude;
        latitude = currentPosition!.latitude;

        print("longitude : $longitude");
        print("latitude : $latitude");
        print("address : $currentPosition");
      });

      getAddressFromLatLng();
    }).catchError((e) {
      Get.find<LoaderController>().updateFormController(false);
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      // var currentPosition;
      List<Placemark> p = await GeocodingPlatform.instance
          .placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
      Placemark place = p[0];
      setState(() {
        currentAddress =
        '${place.name}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
        // var signUpAddressController;
        // if (signUpAddressController.text.isEmpty) {
        //   signUpAddressController.text = currentAddress;
        // }
        print(currentAddress + ' yes');
        print(place.administrativeArea.toString());
        print(place.subAdministrativeArea.toString());
        print(place.thoroughfare.toString());
        print(place.toJson().toString());
        // FocusScope.of(context).unfocus();
        editLocationController.text = currentAddress.toString();
        Get.find<LoaderController>().updateFormController(false);
      });
    } catch (e) {
      Get.find<LoaderController>().updateFormController(false);
      print(e);
    }
  }
}
