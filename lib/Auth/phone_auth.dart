import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:doctoworld_user/Auth/Login/UI/login_ui.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/services/otp_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Verification/UI/verification_ui.dart';


class PhoneAuthUI extends StatefulWidget {
  @override
  _PhoneAuthUIState createState() => _PhoneAuthUIState();
}

class _PhoneAuthUIState extends State<PhoneAuthUI> {

  GlobalKey<FormState> numberKey  = GlobalKey();
  final TextEditingController loginNumberController = TextEditingController();
  @override
  void dispose() {
    loginNumberController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: theme.primaryColorLight,
        body: FadedSlideAnimation(
          SingleChildScrollView(
            child: Container(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.65,
                    color: theme.backgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Spacer(),
                        Expanded(
                            flex: 3,
                            child: Image.asset('assets/splash-logo.png',
                            color: Theme.of(context).primaryColor,)),
                        Spacer(),
                        Expanded(
                            flex: 3, child: Image.asset('assets/hero_image.png')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: numberKey,
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.595),
                          EntryField(
                            textInputFormatter: LengthLimitingTextInputFormatter(11),
                            hint: locale.enterMobileNumber,
                            textInputType: TextInputType.phone,
                            prefixIcon: Icons.phone_iphone,
                            color: theme.scaffoldBackgroundColor,
                            controller: loginNumberController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Field Required';
                              }else if(value.length < 11){
                                return 'Enter valid Phone Number';
                              } else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0),
                          CustomButton(
                              onTap: () {
                                if(numberKey.currentState!.validate()){

                                  if(loginNumberController.text.contains('+92')){
                                    print('NUMBER--->>${loginNumberController.text}');
                                    otpFunction(
                                        loginNumberController.text,
                                        context
                                    );
                                    Get.to(VerificationUI(
                                      number:  loginNumberController,fromSignUpForm: false,
                                      postData: {'role':'customer',
                                        'phone':loginNumberController.text
                                    },));
                                  }else{
                                    if(loginNumberController.text.startsWith('0'))
                                      setState(() {
                                        loginNumberController.text = loginNumberController.text.replaceFirst('0', '+92');
                                      });
                                    print('NUMBER--->>${loginNumberController.text}');

                                    otpFunction(
                                        loginNumberController.text,
                                        context
                                    );
                                    Get.to(VerificationUI(number:  loginNumberController,fromSignUpForm: false,
                                      postData: {'role':'customer',
                                        'login_type':'login_phone',
                                        'phone':loginNumberController.text
                                      },));
                                  }

                                }
                              }

                          ),
                          Column(
                            children: [

                              SizedBox(
                                height: 30,
                              ),
                              Text('OR'),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () => Get.to(LoginUI()),
                                child: Text(
                                  'Try Another Way',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          )
                          // Spacer(flex: 2),
                          // Text(
                          //   locale.orQuickContinueWith!,
                          //   style: theme.textTheme.subtitle1,
                          // ),

                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: CustomButton(
                          //         icon: Image.asset('assets/icons/ic_fb.png',
                          //             scale: 2),
                          //         color: facebookButtonColor,
                          //         label: locale.facebook,
                          //         onTap: () =>
                          //             widget.loginInteractor.loginWithFacebook(),
                          //       ),
                          //     ),
                          //     SizedBox(width: 20.0),
                          //     Expanded(
                          //       child: CustomButton(
                          //         label: locale.gmail,
                          //         icon: Image.asset(
                          //           'assets/icons/ic_ggl.png',
                          //           scale: 3,
                          //         ),
                          //         color: theme.scaffoldBackgroundColor,
                          //         textColor: theme.hintColor,
                          //         onTap: () =>
                          //             widget.loginInteractor.loginWithGoogle(),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}