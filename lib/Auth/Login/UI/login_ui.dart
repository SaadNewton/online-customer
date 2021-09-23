import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Auth/Registration/UI/registration_ui.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/registration_data/registration_ui.dart';
import 'package:doctoworld_user/repositories/login_repo.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  GlobalKey<FormState> loginKey = GlobalKey();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late final String? selected = '';
  List<String> items = [
    'Customer',
    'Doctor',
  ];
  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (_) => ModalProgressHUD(
        inAsyncCall: _.formLoader,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: FadedSlideAnimation(
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/Group4.png',
                              ),
                              fit: BoxFit.fill)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Form(
                        key: loginKey,
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.45),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: EntryField(
                                validator: (value) {
                                  if (EmailValidator.validate(value)) {
                                    return null;
                                  } else {
                                    return 'Please enter valid email';
                                  }
                                },
                                hint: 'Email',
                                prefixIcon: Icons.email,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                controller: _emailController,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: EntryField(
                                prefixIcon: Icons.lock,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter valid password';
                                  }
                                  return null;
                                },
                                obSecure: true,
                                suffixIcon: Icons.remove_red_eye_outlined,
                                hint: 'Password',
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                controller: _passController,
                              ),
                            ),
                            SizedBox(height: 30.0),

                            CustomButton(onTap: () {
                              if (loginKey.currentState!.validate()) {
                                //    .loginWithEmail('', _emailController.text);
                                _.updateFormController(true);
                                postMethod(
                                    context,
                                    loginService,
                                    {
                                      'email': _emailController.text,
                                      'password': _passController.text,
                                      'role': 'customer',
                                      'login_type':'login_email',
                                    },
                                    false,
                                    getLoginData);
                              }
                            }),
                            SizedBox(height: 40.0),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don\'t Have an Account?',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  TextSpan(
                                    text: 'Create new one',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationUIOld()));
                                        print('CREATE ACCOUNT');
                                      },
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: CustomButton(
                            //         icon: Image.asset('assets/Icons/ic_fb.png',
                            //             scale: 2),
                            //         color: Color(0xff3b45c1),
                            //         label: locale.facebook,
                            //         onTap: () =>
                            //             widget.loginInteractor.loginWithFacebook(),
                            //       ),
                            //     ),
                            //     SizedBox(width: 20.0),
                            //     Expanded(
                            //       child: CustomButton(
                            //         label: locale.gmail,
                            //         icon: Image.asset('assets/Icons/ic_ggl.png',
                            //             scale: 3),
                            //         color: Theme.of(context).scaffoldBackgroundColor,
                            //         textColor: Theme.of(context).hintColor,
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
      ),
    );
  }
}
