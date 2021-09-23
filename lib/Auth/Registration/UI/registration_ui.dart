import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Auth/Login/UI/login_ui.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationUI extends StatefulWidget {


  @override
  _RegistrationUIState createState() => _RegistrationUIState();
}

class _RegistrationUIState extends State<RegistrationUI> {
  GlobalKey<FormState> signKey  = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(locale.registerNow!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),

      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Spacer(),
                Text(
                  locale.yourPhoneNumberNotRegistered!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                SizedBox(height: 10),

                /// name
                EntryField(
                  controller: _nameController,
                  prefixIcon: Icons.person,
                  hint: 'Name',
                  validator: (value){
                    if(value.isEmpty){
                      return 'Field is Required';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0),

                /// user-name


                EntryField(
                  controller: _usernameController,
                  prefixIcon: Icons.person,
                  hint: 'User Name',
                  validator: (value){
                    if(value.isEmpty){
                      return 'Field is Required';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0),

                /// Email
                EntryField(
                  controller: _emailController,
                  prefixIcon: Icons.mail,
                  hint: locale.emailAddress,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Field is Required';
                    }else if(!value.contains('@')){
                      return 'Please Enter Valid Email';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0),


                /// phone
                EntryField(
                  controller: _phoneController,
                  prefixIcon: Icons.phone_iphone,
                  hint: locale.mobileNumber,
                ),
                SizedBox(height: 20.0),


                /// password

                EntryField(
                  controller: _passController,
                  prefixIcon: Icons.remove_red_eye_outlined,
                  hint: 'Password',
                  validator: (value){
                    if(value.isEmpty){
                      return 'Field is Required';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0),


                /// confirm pass

                EntryField(
                  controller: _confirmPassController,
                  prefixIcon: Icons.remove_red_eye_outlined,
                  hint: 'Confirm Password',
                  validator: (value){
                    if(value.isEmpty){
                      return 'Field is Required';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0),

                /// Address
                EntryField(
                  controller: _addressController,
                  prefixIcon: Icons.home,
                  hint: 'Address',
                  validator: (value){
                    if(value.isEmpty){
                      return 'Field is Required';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0),

                ///  Location

                EntryField(
                  controller: _locationController,
                  prefixIcon: Icons.add_location,
                  hint: 'Location',
                  validator: (value){
                    if(value.isEmpty){
                      return 'Field is Required';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0),


                CustomButton(
                  onTap: () {},
                ),
                SizedBox(height: 10.0),
                CustomButton(
                  label: locale.backToSignIn,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  textColor: Theme.of(context).hintColor,
                  onTap: (){
                    Get.to(LoginUI());
                  }
                ),
                Spacer(flex: 5),
                Text(
                  locale.wellSendAnOTP!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
