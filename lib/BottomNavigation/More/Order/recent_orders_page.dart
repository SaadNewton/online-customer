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
int? orderCurrentPage;
  @override
  void initState() {
    // TODO: implement initState
    orderCurrentPage=0;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().recentOrderPage = 1;
      Get.find<LoaderController>().updateDataController(true);
    });
    getMethod(context, getAllOrdersService,
        {'customer_id':storageBox!.read('customerId'),
        'page':orderCurrentPage}, true, getAllOrdersRepo);
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
          builder:(_)=>_.dataLoader
              ? Center(child: CircularProgressIndicator(),)
              : (getAllOrdersModel.status==false && Get.find<LoaderController>().recentOrderList.length == 0)
              ? Center(child: Text(getAllOrdersModel.message!),)
              : FadedSlideAnimation(
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Pending',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  color: Theme.of(context).dividerColor,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Get.find<LoaderController>().recentOrderList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                  Get.find<LoaderController>().recentOrderList[index].status=='pending'?
                       OrderCard(Get.find<LoaderController>().recentOrderList[index]):SizedBox(),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      locale.inProcess!,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Get.find<LoaderController>().recentOrderList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                  Get.find<LoaderController>().recentOrderList[index].status!=null &&
                      Get.find<LoaderController>().recentOrderList[index].status!='pending'
                      ? OrderCard(Get.find<LoaderController>().recentOrderList[index])
                      : SizedBox(),
                ),

                getAllOrdersModel.status == false
                    ?SizedBox()
                    : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: InkWell(
                      onTap: (){

                        Get.find<LoaderController>().recentOrderPage =
                            Get.find<LoaderController>().recentOrderPage+1;
                        Get.find<LoaderController>().updateDataController(true);
                        getMethod(context, getAllOrdersService,
                            {'customer_id':storageBox!.read('customerId'),
                              'page':Get.find<LoaderController>().recentOrderPage},
                            true, getAllOrdersRepoMore);
                      },
                      child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text(
                            'Load more',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                          ),
                        ),
                      )
                  )),
                )
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
                orderCard.status!=null?Text(
                  orderCard.status!.toString().replaceAll('_', ' ').toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: kMainTextColor),
                ):SizedBox(),
              ],
            ),
            subtitle: Row(
              children: [
                orderCard.createdAt == null ? SizedBox() :
                Text(
                  DateFormat('dd MMM yyyy').format(DateTime.parse(orderCard.createdAt!)),
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
                orderCard.totalPrice==null || orderCard.paymentMethod==null?SizedBox(): Text(
                  'Rs. ' + orderCard.totalPrice! + ' | ' + orderCard.paymentMethod!,
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
