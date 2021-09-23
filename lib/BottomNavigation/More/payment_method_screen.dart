import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Checkout/confirm_order.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_cart_items_repo.dart';
import 'package:doctoworld_user/repositories/get_payment_method_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class PaymentType {
  String icon;
  String? title;

  PaymentType(this.icon, this.title);
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateDataController(true);

    });
    getMethod(context, getPaymentMethodsService,
        null, true, getAllPaymentMethodsRepo);
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<PaymentType> paymentModes = [
      PaymentType('', locale.wallet),
      PaymentType('assets/PaymentIcons/payment_cod.png', locale.cashOnDelivery),
      PaymentType('assets/PaymentIcons/payment_paypal.png', locale.payPal),
      PaymentType('assets/PaymentIcons/payment_payu.png', locale.payUMoney),
      PaymentType('assets/PaymentIcons/payment_stripe.png', locale.stripe),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
         'Select Method',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: GetBuilder<LoaderController>(
        init:LoaderController(),
        builder:(_)=> _.dataLoader?
        Center(child: CircularProgressIndicator(),):FadedSlideAnimation(
          Container(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),

                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: getPaymentMethodModel.data!.length,
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Get.to(ConfirmOrder(paymentMethodId: getPaymentMethodModel.data![index].id,));
                                // Navigator.pushNamed(
                                //     context, PageRoutes.orderPlacedPage);
                              },
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 7),
                              leading: index == 0
                                  ? CircleAvatar(
                                      backgroundColor: Colors.grey[50],
                                      child: Icon(
                                        Icons.credit_card,
                                        size: 20,
                                        color: Colors.lightGreen,
                                      ))
                                  : FadedScaleAnimation(
                                      Image.asset(
                                        paymentModes[index].icon,
                                        scale: 3,
                                      ),
                                      durationInMilliseconds: 400,
                                    ),
                              title: Text(
                                 getPaymentMethodModel.data![index].name!,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            Divider(
                              thickness: 4,
                              height: 4,
                            ),
                          ],
                        );
                      }),
                ),
                // Expanded(
                //     child: Container(
                //   color: Theme.of(context).backgroundColor,
                // )),
              ],
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
