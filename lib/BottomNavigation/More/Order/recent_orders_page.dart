import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/get_all_orders_model.dart';
import 'package:doctoworld_user/Models/order_card_model.dart';
import 'package:doctoworld_user/BottomNavigation/More/Order/order_info.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_all_orders_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class RecentOrdersPage extends StatefulWidget {
  @override
  _RecentOrdersPageState createState() => _RecentOrdersPageState();
}

class _RecentOrdersPageState extends State<RecentOrdersPage> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateDataController(true);
    });
    getMethod(context, getAllOrdersService,
        {'customer_id':storageBox!.read('customerId')}, true, getAllOrdersRepo);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(locale.recentOrders!),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
        ),
        body: GetBuilder<LoaderController>(
          init: LoaderController(),
          builder:(_)=>_.dataLoader?Center(child: CircularProgressIndicator(),):
getAllOrdersModel.status==false?Center(child: Text(getAllOrdersModel.message!),):
          FadedSlideAnimation(
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    locale.inProcess!,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  color: Theme.of(context).dividerColor,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: getAllOrdersModel.data!.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                       getAllOrdersModel.data!.data![index].status=='pending'?
                       OrderCard(getAllOrdersModel.data!.data![index]):SizedBox(),
                ),

                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    locale.past!,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  color: Theme.of(context).dividerColor,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: getAllOrdersModel.data!.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => getAllOrdersModel.data!.data![index].status=='delivered'?
                  OrderCard(getAllOrdersModel.data!.data![index]):SizedBox(),
                ),
              ],
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ),
      );
  }
}

class OrderCard extends StatelessWidget {
  final SingleOrderDetail orderCard;

  OrderCard(this.orderCard);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderInfoPage(orderDetail: orderCard,)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.asset('assets/ic_cart.png',
                color: Theme.of(context).primaryColor,height: 40),
            title: Row(
              children: [
                Text('Order : ${orderCard.id}'),
                Spacer(),
                Text(
                  orderCard.status!.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: orderCard.status!.toLowerCase() == 'pending'
                          ? inProcessColor
                          : orderCard.status!.toLowerCase() == 'delivered'
                              ? kMainColor
                              : kMainTextColor),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Text(
                  DateFormat('dd MMM yyyy').format(DateTime.parse(orderCard.createdAt!)),
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
                Text(
                  '\$' + orderCard.totalPrice! + ' | ' + orderCard.paymentMethod!,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),

          Divider(thickness: 6, height: 0),
        ],
      ),
    );
  }
}
