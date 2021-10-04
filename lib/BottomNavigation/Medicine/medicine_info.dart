import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/get_medicine_from_search_model.dart';
import 'package:doctoworld_user/Models/get_product_by_category_model.dart';

import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/add_to_cart_repo.dart';
import 'package:doctoworld_user/repositories/get_cart_items_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProductInfo extends StatefulWidget {
  final ProductDetailData? medicineDetail;
  ProductInfo({this.medicineDetail});
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  String? selectedType;
  IconData saved = Icons.bookmark_border;
  @override
  void initState() {
    // TODO: implement initState
    isCartPage=false;
    if(widget.medicineDetail!.isItemType=='1'){
    selectedType='Strip';
    }
    getMethod(context, getCartProductsService,
        {'customer_id':storageBox!.read('customerId')}, true, getAllCartItemsRepo);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(_)=> ModalProgressHUD(
        inAsyncCall: _.formLoader,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [

              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        Get.find<LoaderController>().updateDataController(true);

                      });
                      Get.to(CartPage());
                    },
                  ),
                  getCartItemsModel==null || getCartItemsModel.status==false?
                  SizedBox():Positioned.directional(
                    textDirection: Directionality.of(context),
                    top: 8,
                    end: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 5.5,
                      child: Center(
                          child: Text(

                            "${getCartItemsModel.data!.length}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor,
                                fontSize: 9),
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
          body: FadedSlideAnimation(
            ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                Stack(
                  children: [
                    FadedScaleAnimation(
                      widget.medicineDetail!.imagePath ==
                              null
                          ? Image.asset(
                              'assets/Medicines/11.png',

                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                              height: 200,
                            )
                          : Image.network(
                              '$imageBaseUrl'
                                  '${widget.medicineDetail!.imagePath}',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                              height: 200,
                            ),
                      durationInMilliseconds: 400,
                    ),
                    // Positioned.directional(
                    //     textDirection: Directionality.of(context),
                    //     end: 5,
                    //     top: 15,
                    //     child: Image.asset(
                    //       'assets/ic_prescription.png',
                    //       scale: 3,
                    //     )),
                  ],
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          '${widget.medicineDetail!.name}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        // Spacer(),
                        // Icon(
                        //   Icons.star,
                        //   color: Color(0xffF29F19),
                        //   size: 16,
                        // ),
                        // SizedBox(
                        //   width: 5,
                        // ),

                        /// rating
                        // Text(
                        //   '${getProductsByCategoryModel.data.data[widget.index!].name}',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyText1!
                        //       .copyWith(color: Color(0xffF29F19), fontSize: 16),
                        // ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        // Text(
                        //   '${widget.medicineDetail!.category!.name}',
                        //   style:
                        //       Theme.of(context).textTheme.subtitle2!.copyWith(
                        //             color: Theme.of(context).disabledColor,
                        //           ),
                        // ),
                        // Spacer(),
                        // GestureDetector(
                        //     onTap: () {
                        //       Navigator.pushNamed(
                        //           context, PageRoutes.reviewsPage);
                        //     },
                        //     child: Text(
                        //       locale.readAll! + ' 125 ' + locale.reviews!,
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .subtitle2!
                        //           .copyWith(
                        //             color: Theme.of(context).disabledColor,
                        //           ),
                        //     )),
                        // Icon(
                        //   Icons.arrow_forward_ios,
                        //   size: 12,
                        //   color: Theme.of(context).disabledColor,
                        // )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Text(
                    locale.description!,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Text(
                    '${widget.medicineDetail!.description}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w400,
                    color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                ///
                widget.medicineDetail!.isItemType=='1'?
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: List.generate(
                        widget.medicineDetail!.itemPrice.length,
                            (i) => InkWell(
                          onTap: (){
                            setState(() {
                              productPrice=widget.medicineDetail!.itemPrice[i]['price'];
                              selectedType=widget.medicineDetail!.itemPrice[i]['type'];
                            });
                            // setState(() {
                            //   slot=getAppointmentSlotsModel.data![i].slot;
                            //   selectedSlot=getAppointmentSlotsModel.data!.indexOf(
                            //       getAppointmentSlotsModel.data![i]);
                            //   print('slot '+selectedSlot.toString()+i.toString());
                            // });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                  selectedType==widget.medicineDetail!.itemPrice[i]['type']?Colors.green:Theme.of(context).primaryColor
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                              color:

                              selectedType==widget.medicineDetail!.itemPrice[i]['type'].
                              toString()?
                              Colors.green:Theme.of(context).primaryColor,
                            ),
                            child: Text(
                                widget.medicineDetail!.itemPrice[i]['type'],
                                style: TextStyle(
                                    color: Colors.white)),
                          ),
                        )),
                  ),
                ):SizedBox(),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          title: Text(
                            widget.medicineDetail!.isItemType=='1'?
                            productPrice:'Rs ${widget.medicineDetail!.salePrice}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          // trailing: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     Text(locale.packOf! + ' 8'),
                          //     Icon(
                          //       Icons.keyboard_arrow_down,
                          //       size: 14,
                          //     )
                          //   ],
                          // ),
                        ),
                      ),



                      CustomButton(
                        radius: 0,
                        label: locale.addToCart,
                        onTap: () {
                          Get.find<LoaderController>().updateFormController(true);
                          addToCartMethod(widget.medicineDetail!.id,
                              widget.medicineDetail!.salePrice);
                        },
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
        ),
      ),
    );
  }
  addToCartMethod(productId,productPrice){

    postMethod(context, addToCartService, {'product_id':productId,
      'customer_id':storageBox!.read('customerId'),
      'qty':1,
      'type':'medicine',
      'product_price':productPrice}, true, addToCartRepo);
  }
}
