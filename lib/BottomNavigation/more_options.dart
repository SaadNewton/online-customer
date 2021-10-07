import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Auth/Login/UI/login_ui.dart';
import 'package:doctoworld_user/Auth/phone_auth.dart';
import 'package:doctoworld_user/BottomNavigation/More/Order/recent_orders_page.dart';
import 'package:doctoworld_user/BottomNavigation/More/Wallet/wallet_page.dart';
import 'package:doctoworld_user/BottomNavigation/More/tnc.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Pages/contact_us_ui.dart';
import 'package:doctoworld_user/Pages/customer_change_password.dart';
import 'package:doctoworld_user/Pages/customer_password_email_ui.dart';
import 'package:doctoworld_user/Pages/edit_profile.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_user_detail_reop.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'More/Order/order_with_prescription_form.dart';

class MoreOptions extends StatefulWidget {
  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class MenuTile {
  String? title;
  String? subtitle;
  IconData iconData;
  Function onTap;
  MenuTile(this.title, this.subtitle, this.iconData, this.onTap);
}

class _MoreOptionsState extends State<MoreOptions> {
  @override
  void initState() {
    // TODO: implement initState
    getUserDetailRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<MenuTile> _menu = [
      MenuTile(locale.wallet, locale.quickPayment, Icons.account_balance_wallet,
          () {
        Get.to(WalletPage());
      }),
      MenuTile(locale.myOrders, locale.orderStatus, Icons.motorcycle, () {
       Get.to(RecentOrdersPage());
      }),

      /// temp close
      // MenuTile(locale.pillReminder, locale.takePillOnTime,
      //     Icons.access_alarms_outlined, () {
      //   Navigator.pushNamed(context, PageRoutes.pillReminder);
      // }),
      // MenuTile(locale.myAddress, locale.saveAddress, Icons.location_pin, () {
      //   Navigator.pushNamed(context, PageRoutes.addressesPage);
      // }),

      // MenuTile(locale.saved, locale.medsAndDoctors, Icons.bookmark_outlined,
      //     () {
      //   Navigator.pushNamed(context, PageRoutes.savedPage);
      // }),
      // MenuTile(locale.changeLanguage, locale.changeLanguage, Icons.language,
      //     () {
      //   // Navigator.pushNamed(context, PageRoutes.languagePage);
      // }),
      MenuTile('Contact Us', 'Contact Us For Help', Icons.message_sharp, () {
        Get.to(ContactUs());
      }),
      MenuTile(locale.tandc, locale.companyPolicy, Icons.assignment, () {
       Get.to(TnCPage());
      }),
      MenuTile('Password Change', 'Change your password', Icons.lock, () {
        Get.to(ChangePassword());
      }),

      MenuTile('Log Out', '', Icons.logout, () {
        storageBox!.erase();
        Get.offAll(PhoneAuthUI());
      }),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(locale.account!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadedScaleAnimation(
                  CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    radius: 50,
                      child: Icon(Icons.person,size: 65,color: Colors.black,)),
                  // Image.asset('assets/userprofile.png', scale: 3.5),
                  durationInMilliseconds: 400,
                ),
                SizedBox(
                  width: 15,
                ),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: userDetailModel.data.name,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 20, height: 2)),
                  TextSpan(
                      text: '\n${userDetailModel.data.phone}',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Theme.of(context).disabledColor, height: 2)),
                ]))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              OutlinedButton(
                  onPressed: () {
                    Get.to(EditProfile());
                  },
                  child: Text(
                    '✎  Edit',
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(width: 12,)
            ],
          ),
          SizedBox(height: 5,),
          Container(
            color: Theme.of(context).backgroundColor,
            child: GridView.builder(
                itemCount: _menu.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.6, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _menu[index].onTap as void Function()?,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: FadedScaleAnimation(
                              Text(
                                _menu[index].title!,
                                style: Theme.of(context).textTheme.subtitle1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              durationInMilliseconds: 400,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _menu[index].subtitle!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                _menu[index].iconData,
                                size: 32,
                                color: Theme.of(context).highlightColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
