import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoosePaymentMethod extends StatefulWidget {
  @override
  _ChoosePaymentMethodState createState() => _ChoosePaymentMethodState();
}

class PaymentType {
  String icon;
  String? title;

  PaymentType(this.icon, this.title);
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
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
        centerTitle: true,
        title: Text(
          locale.selectPaymentMethod!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 20),
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: locale.amountToPay!.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).hintColor, height: 1.4)),
                  TextSpan(
                      text: '\n\$ 20.00',
                      style: Theme.of(context).textTheme.headline4)
                ])),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text(
                  locale.paymentModes!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              ListView.builder(
                  itemCount: 5,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, PageRoutes.orderPlacedPage);
                          },
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 7),
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
                            index == 0
                                ? locale.wallet!
                                : paymentModes[index].title!,
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
              Container(
                height: 200,
                color: Theme.of(context).backgroundColor,
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
//done
