import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Models/get_all_orders_model.dart';
import 'package:doctoworld_user/Models/order_card_model.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Locale/locale.dart';

class OrderInfoPage extends StatelessWidget {

  final SingleOrderDetail? orderDetail;
  OrderInfoPage({this.orderDetail});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: theme.dividerColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(locale.orderNum! + ' 221451'),
        textTheme: theme.textTheme,
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.more_vert_sharp, color: theme.primaryColor),
              onPressed: () {})
        ],
      ),
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ListTile(
              tileColor: theme.scaffoldBackgroundColor,
              leading: Image.asset('assets/upload prescription.png', height: 40),
              title: Row(
                children: [
                  Text('storeName'),
                  Spacer(),
                  Text(
                    'status'.toUpperCase(),
                    style: theme.textTheme.subtitle1!.copyWith(
                        color: 'status'.toLowerCase() == 'in transit'
                            ? inProcessColor
                            : 'status'.toLowerCase() == 'confirmed'
                                ? kMainColor
                                : kMainTextColor),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text('date', style: theme.textTheme.caption),
                  Spacer(),
                  Text(
                    '\$' + 'totalPrice' + ' | ' + 'paymentType',
                    style: theme.textTheme.caption,
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    ListTile(
                      leading:
                          Icon(Icons.check_circle, color: theme.primaryColor),
                      title: Text(locale.orderConfirmed!),
                      subtitle: Text('2:00 pm, 11 June 2020',
                          style: theme.textTheme.caption),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Theme.of(context).dividerColor,
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                            stops: [
                              0.15,
                              0.15
                            ]),
                      ),
                      child: ListTile(
                        leading:
                            Icon(Icons.check_circle, color: theme.primaryColor),
                        title: Text(locale.orderPicked!),
                        subtitle: Text('4:13 pm, 11 June 2020',
                            style: theme.textTheme.caption),
                        trailing: TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          icon: Icon(Icons.navigation),
                          label: Text(locale.track!),
                          onPressed: () => Navigator.pushNamed(
                              context, PageRoutes.orderTracking),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.check_circle_outline_outlined,
                          color: theme.disabledColor),
                      title: Text(locale.orderDelivered!,
                          style: theme.textTheme.subtitle1!
                              .copyWith(color: theme.disabledColor)),
                      subtitle: Text(locale.yetToDeliver!,
                          style: theme.textTheme.caption),
                    ),
                  ],
                ),
                PositionedDirectional(
                  top: 48,
                  start: 16,
                  child: Column(
                    children: [
                      Icon(Icons.more_vert_sharp, color: theme.primaryColor),
                      SizedBox(height: 48),
                      Icon(Icons.more_vert_sharp, color: theme.primaryColor),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(locale.orderedItems!, style: theme.textTheme.caption),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('orderCard!.medicines[index]'),
                      subtitle: Text('2 ' + locale.packs!,
                          style: theme.textTheme.caption),
                      trailing:
                          Text('\$ 8.00', style: theme.textTheme.subtitle1),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              tileColor: theme.scaffoldBackgroundColor,
              leading: ImageIcon(
                AssetImage('assets/ic_prescription.png'),
                size: 20,
                color: theme.primaryColor,
              ),
              title: Text(locale.presciptionUploaded!),
              trailing: Icon(Icons.remove_red_eye, color: theme.primaryColor),
            ),
            Container(
              color: theme.scaffoldBackgroundColor,
              child: Column(
                children: [
                  ListTile(
                    title: Text(locale.subbTotal!,
                        style: theme.textTheme.subtitle2),
                    trailing:
                        Text('\$ 24.00', style: theme.textTheme.bodyText2),
                  ),
                  ListTile(
                    title: Text(locale.promoCodeApplied!,
                        style: theme.textTheme.subtitle2),
                    trailing:
                        Text('- \$ 2.00', style: theme.textTheme.bodyText2),
                  ),
                  ListTile(
                    title: Text(locale.serviceCharge!,
                        style: theme.textTheme.subtitle2),
                    trailing: Text('\$ 4.00', style: theme.textTheme.bodyText2),
                  ),
                  ListTile(
                    title: Text(locale.amountVaiCOD!),
                    trailing:
                        Text('\$ 26.00', style: theme.textTheme.subtitle1),
                  ),
                ],
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
