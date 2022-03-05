import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/More/Wallet/add_money_repo.dart';
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
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  GlobalKey<FormState> _addMoneyKey = GlobalKey();
  TextEditingController addMoneyController = TextEditingController();



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
              title: Text('Add Money',
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
                    key: _addMoneyKey,
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

                            ///
                            EntryField(

                              color: Colors.grey.withOpacity(0.2),
                              textInputFormatter: FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                              textInputType: TextInputType.number,
                              controller: addMoneyController,
                              prefixIcon: Icons.person,
                              hint: 'Amount',
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
                              onTap: () {
                                FocusScopeNode currentFocus =
                                FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (_addMoneyKey.currentState!.validate()) {
                                  Get.find<LoaderController>()
                                      .updateFormController(true);
                                  postMethod(
                                      context,
                                      addMoneyService,
                                      {
                                        'user_id': storageBox!.read('customerId'),
                                        'role': 'customer',
                                        'amount': addMoneyController.text
                                      },
                                      true,
                                      addMoneyRepo);
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

}
