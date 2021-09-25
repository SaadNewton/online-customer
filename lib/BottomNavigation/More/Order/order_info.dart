import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Models/get_all_orders_model.dart';
import 'package:doctoworld_user/Models/order_card_model.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:intl/intl.dart';

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
        title: Text(locale.orderNum! + ' ${orderDetail!.customerName}'),
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

                  Spacer(),
                  orderDetail!.isOrderApproved == 1 ?
                  Text(
                    'Approved'.toUpperCase(),
                    style: theme.textTheme.subtitle1!.copyWith(
                        color: 'status'.toLowerCase() == 'in transit'
                            ? inProcessColor
                            : 'status'.toLowerCase() == 'confirmed'
                                ? kMainColor
                                : kMainTextColor),
                  ) : Text('Pending'),
                ],
              ),
              subtitle: Row(
                children: [
                  Text('${DateFormat('dd MMM yy').format(DateTime.parse(orderDetail!.createdAt!))}',
                      style: theme.textTheme.caption),
                  Spacer(),
                  Text(
                    '\Rs ' + '${orderDetail!.totalPrice}' + ' | ' + '${orderDetail!.paymentMethod}',
                    style: theme.textTheme.caption,
                  ),
                ],
              ),
            ),
            orderDetail!.orderProduct![0].type == 'test' ?
            Column(
              children: [

                Container(
                  margin: EdgeInsetsDirectional.only(end: 20),
                  decoration: orderDetail!.status == 'sample_collected'
                      || orderDetail!.status == 'in_process'
                      || orderDetail!.status == 'delivered'
                      ? BoxDecoration(
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
                  ):BoxDecoration(),
                  child: ListTile(
                    leading:
                    orderDetail!.status == 'sample_collected'
                        || orderDetail!.status == 'in_process'
                        || orderDetail!.status == 'delivered'
                        ? Icon(Icons.check_circle, color: theme.primaryColor)
                        :  Icon(Icons.check_circle),
                    title: Text('Sample Collected',
                        style: theme.textTheme.subtitle1!
                            .copyWith(color:  orderDetail!.status == 'sample_collected'
                            || orderDetail!.status == 'in_process'
                            || orderDetail!.status == 'delivered'
                            ?Colors.black:theme.disabledColor)),
                    // trailing: TextButton.icon(
                    //   style: TextButton.styleFrom(
                    //     padding: EdgeInsets.zero,
                    //   ),
                    //   icon: Icon(Icons.navigation),
                    //   label: Text(locale.track!),
                    //   onPressed: () => Navigator.pushNamed(
                    //       context, PageRoutes.orderTracking),
                    // ),
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(end: 20),
                  decoration: orderDetail!.status == 'in_process'
                      || orderDetail!.status == 'delivered'

                      ? BoxDecoration(
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
                  ):BoxDecoration(),
                  child: ListTile(
                    leading: orderDetail!.status == 'in_process'
                        || orderDetail!.status == 'delivered'

                        ? Icon(Icons.check_circle,
                        color: theme.primaryColor)
                        : Icon(Icons.check_circle),
                    title: Text('In Process',
                        style: theme.textTheme.subtitle1!
                            .copyWith(color: orderDetail!.status == 'in_process'
                            || orderDetail!.status == 'delivered'

                            ?Colors.black:theme.disabledColor)),
                    // subtitle: Text(locale.yetToDeliver!,
                    //     style: theme.textTheme.caption),
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(end: 20),
                  decoration: orderDetail!.status == 'delivered' ? BoxDecoration(
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
                  ):BoxDecoration(),
                  child: ListTile(
                    leading: orderDetail!.status == 'delivered' ?
                    Icon(Icons.check_circle, color: theme.primaryColor)
                        : Icon(Icons.check_circle),
                    title: Text('Delivered',
                        style: theme.textTheme.subtitle1!
                            .copyWith(color: orderDetail!.status == 'delivered' ?Colors.black:theme.disabledColor)),
                    // trailing: TextButton.icon(
                    //   style: TextButton.styleFrom(
                    //     padding: EdgeInsets.zero,
                    //   ),
                    //   icon: Icon(Icons.navigation),
                    //   label: Text(locale.track!),
                    //   onPressed: () => Navigator.pushNamed(
                    //       context, PageRoutes.orderTracking),
                    // ),
                  ),
                ),
              ],
            ): Column(
              children: [

                Container(
                  margin: EdgeInsetsDirectional.only(end: 20),
                  decoration:   orderDetail!.status == 'order_picked'
      || orderDetail!.status == 'delivered' ?BoxDecoration(
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
                  ):BoxDecoration(),

                  child: ListTile(

                    leading: orderDetail!.status == 'order_picked'
                        || orderDetail!.status == 'delivered' ?
                    Icon(Icons.check_circle, color: theme.primaryColor)
                    : Icon(Icons.check_circle),

                    title: Text(locale.orderPicked!,
                        style: theme.textTheme.subtitle1!
                            .copyWith(color: orderDetail!.status == 'order_picked'
                            || orderDetail!.status == 'delivered' ?Colors.black:theme.disabledColor)),
                    // trailing: TextButton.icon(
                    //   style: TextButton.styleFrom(
                    //     padding: EdgeInsets.zero,
                    //   ),
                    //   icon: Icon(Icons.navigation),
                    //   label: Text(locale.track!),
                    //   onPressed: () => Navigator.pushNamed(
                    //       context, PageRoutes.orderTracking),
                    // ),
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(end: 20),
                  decoration:    orderDetail!.status == 'delivered' ?BoxDecoration(
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
                  ):BoxDecoration(),
                  child: ListTile(
                    leading: orderDetail!.status == 'delivered'   ?
                    Icon(Icons.check_circle, color: theme.primaryColor)
                    :  Icon(Icons.check_circle, ),
                    title: Text(locale.orderDelivered!,
                        style: theme.textTheme.subtitle1!
                            .copyWith(color: orderDetail!.status == 'delivered'
                            ?Colors.black:theme.disabledColor)),
                    // subtitle: Text(locale.yetToDeliver!,
                    //     style: theme.textTheme.caption),
                  ),
                ),
              ],
            ),
             ///.....................///

            // PositionedDirectional(
            //   top: 48,
            //   start: 16,
            //   child: Column(
            //     children: [
            //       Icon(Icons.more_vert_sharp, color: theme.primaryColor),
            //       SizedBox(height: 30),
            //       Icon(Icons.more_vert_sharp, color: theme.primaryColor),
            //     ],
            //   ),
            // ),
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
                    itemCount: orderDetail!.orderProduct!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('${orderDetail!.orderProduct![index].name}'),
                      subtitle: Text('${orderDetail!.orderProduct![index].qty} ' + locale.packs!,
                          style: theme.textTheme.caption),
                      trailing:
                          Text('\Rs ${orderDetail!.orderProduct![index].salePrice}', style: theme.textTheme.subtitle1),
                    ),
                  ),
                ],
              ),
            ),
           orderDetail!.isPrescription == 1 ? ListTile(
              tileColor: theme.scaffoldBackgroundColor,
              leading: ImageIcon(
                AssetImage('assets/ic_prescription.png'),
                size: 20,
                color: theme.primaryColor,
              ),
              title: Text(locale.presciptionUploaded!),
              trailing: Icon(Icons.remove_red_eye, color: theme.primaryColor),
            ) :
               SizedBox(),
            Container(
              color: theme.scaffoldBackgroundColor,
              child: Column(
                children: [
                  ListTile(
                    title: Text(locale.subbTotal!,
                        style: theme.textTheme.subtitle2),
                    trailing:
                        Text('\Rs ${orderDetail!.subTotal}', style: theme.textTheme.bodyText2),
                  ),
                  ListTile(
                    title: Text(locale.promoCodeApplied!,
                        style: theme.textTheme.subtitle2),
                    trailing:
                        Text('- \Rs 2.00', style: theme.textTheme.bodyText2),
                  ),
                  ListTile(
                    title: Text(locale.serviceCharge!,
                        style: theme.textTheme.subtitle2),
                    trailing: Text('\Rs ${orderDetail!.shippingPrice}', style: theme.textTheme.bodyText2),
                  ),
                  // ListTile(
                  //   title: Text(locale.amountVaiCOD!),
                  //   trailing:
                  //       Text('\$ 26.00', style: theme.textTheme.subtitle1),
                  // ),
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
