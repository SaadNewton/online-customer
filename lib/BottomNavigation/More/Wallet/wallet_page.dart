import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/More/Wallet/add_money.dart';
import 'package:doctoworld_user/BottomNavigation/More/Wallet/get_wallet_by_user_repo.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletCard {
  final String name;
  final String orderDetails;
  final String payment;
  final String earnings;

  WalletCard(this.name, this.orderDetails, this.payment, this.earnings);
}

class WalletPage extends StatefulWidget {


  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  void initState() {
  //  TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateDataController(true);

    });
    getMethod(context, walletHistoryService,
        {'user_id':storageBox!.read('customerId'), 'user_type': 'customer'}, true, getWalletByUserRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text(locale.wallet!,style: TextStyle(color: Colors.black),),
        textTheme: Theme.of(context).textTheme,
      ),
      body: GetBuilder<LoaderController>(
        init:LoaderController(),
        builder:(_)=>_.dataLoader? Center(
          child:  CircularProgressIndicator(),
        )
            : Container(
          child: getWalletByUserTypeModel.status == false
              ? FadedSlideAnimation(
            Stack(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 120),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                      child: Text(locale.recent!),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 172.0),
                  child: Center(
                    child: Text(
                      'No record found',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                  )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                      child: Text(
                        locale.availableBalance!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Rs 0',
                        style: theme.textTheme.headline6!.copyWith(fontSize: 30),
                      ),
                    ),
                  ],
                ),
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 15,
                  top: 10,
                  child: CustomButton(
                    radius: 0,
                    onTap: () {
                      Get.to(AddMoney());
                    },
                    label: locale.addMoney,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          )
          : FadedSlideAnimation(
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 120),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                      child: Text(locale.recent!),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 172.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: getWalletByUserTypeModel.data![0].transactions!.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return
                        // getWalletByUserTypeModel.data == null ? Center(child: Text('No Record Found'))
                        //  :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                getWalletByUserTypeModel.data![0].transactions
                                ![index].description == null ? SizedBox()
                               : Text('${getWalletByUserTypeModel.data![0].transactions![index].description}',
                                    ),
                                Spacer(),
                                Text('\Rs ${getWalletByUserTypeModel.data![0].transactions![index].amount}'),

                              ],
                            ),
                          ),
                         Padding(
                           padding: const EdgeInsets.only(left: 16.0),
                           child: Text(  '${getWalletByUserTypeModel
                               .data![0].transactions![index].amountType}'),
                         ),
                          Divider(
                            thickness: 6,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                      child: Text(
                        locale.availableBalance!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '\Rs ${getWalletByUserTypeModel.data![0].amount}',
                        style: theme.textTheme.headline6!.copyWith(fontSize: 30),
                      ),
                    ),
                  ],
                ),
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 15,
                  top: 30,
                  child: CustomButton(
                    radius: 0,
                    onTap: () {
                     Get.to(AddMoney());
                    },
                    label: locale.addMoney,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ),
      ),
    );
  }

  Widget buildRowChildWallet(ThemeData theme, String text1, String text2,
      {CrossAxisAlignment? alignment}) {
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: <Widget>[
        Text(text1, style: theme.textTheme.bodyText1),
        SizedBox(height: 6.0),
        Text(
          text2,
          style: theme.textTheme.subtitle2,
        ),
      ],
    );
  }
}
