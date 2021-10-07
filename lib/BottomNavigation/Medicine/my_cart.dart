import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/More/payment_method_screen.dart';
import 'package:doctoworld_user/Checkout/confirm_order.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/controllers/cart_controller.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/add_to_cart_repo.dart';
import 'package:doctoworld_user/repositories/get_cart_items_repo.dart';
import 'package:doctoworld_user/repositories/update_cart_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class medicine {
  medicine(this.img, this.name, this.category, this.price);
  String img;
  String name;
  String category;
  String price;
//  int count;
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
  List<int> count = [1, 1, 1];
  @override
  void initState() {
    // TODO: implement initState
    isCartPage=true;
    getMethod(context, getCartProductsService,
        {'customer_id':storageBox!.read('customerId')}, true, getAllCartItemsRepo);
    super.initState();
  }
  CartController cartController=Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    // bool _isPromoApplied = false;
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(_)=> ModalProgressHUD(
        inAsyncCall: _.formLoader,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              locale.myCart!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: GetBuilder<LoaderController>(
init:LoaderController(),
            builder:(_)=>_.cartLoader?Center(
              child: CircularProgressIndicator(),
            ):
            FadedSlideAnimation(
                !getCartItemsModel.status!?Center(child: Text('Empty Cart'),): ListView(

                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: getCartItemsModel.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12),
                              child: getCartItemsModel.data![index].type=='medicine'?
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  getCartItemsModel.data![index].medicine!.imagePath==null?
                                  Image.asset('assets/Medicines/11.png',
                                    width: 100,
                                    height: 75,):Image.network(
                                    "$imageBaseUrl${getCartItemsModel.data![index].medicine!.imagePath}",
                                    height: 75,
                                    width: 100,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          getCartItemsModel.data![index].medicine!.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          getCartItemsModel.data![index].medicine!.potency??' ' ,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.find<LoaderController>().updateFormController(true);
                                                     updateCartMethod(
                                                        getCartItemsModel.data![index].id,
                                                         (int.parse(
                                                             getCartItemsModel.data![index].
                                                             qty!)-1));
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Theme.of(context).primaryColor,
                                                    size: 16,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text('${getCartItemsModel.data![index].qty}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1),
                                                SizedBox(
                                                  width: 15,
                                                ),
                        GestureDetector(
                        onTap: () {
                          Get.find<LoaderController>().updateFormController(true);
                          updateCartMethod( getCartItemsModel.data![index].id,
                              (int.parse(getCartItemsModel.data![index].qty!)+1));
                        },
                        child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                        ),
                        ),
                                                SizedBox(
                                                  width: 40,

                                                ),
                                              ],
                                            ),

                                            Text('Rs ${double.tryParse(getCartItemsModel.data![index].price!)!
                                                * int.parse(getCartItemsModel.data![index].qty!)}'
                                                // '${getCartItemsModel.data![index].medicine!.salePrice!}'
                                                ,

                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              ):





                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  getCartItemsModel.data![index].test!.imagePath==null?
                                  Image.asset('assets/Medicines/11.png',
                                    height: 75,):Image.network(
                                    "$imageBaseUrl${getCartItemsModel.data![index].test!.imagePath}",
                                    height: 75,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          getCartItemsModel.data![index].test!.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          getCartItemsModel.data![index].test!.estTime??' ' ,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Qty 1',
                                                textAlign: TextAlign.right,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!.copyWith(color: Colors.grey)),
                                            Text('Rs '+getCartItemsModel.data![index].test!.price!,
                                                // '${getCartItemsModel.data![index].medicine!.salePrice!}'

                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12),
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 12),
                                  hintText: locale.addPromoCode,
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          // Navigator.pushNamed(
                                          //     context, PageRoutes.offersPage);
                                        },
                                        child: Text(
                                          locale.viewOffers!.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // _isPromoApplied = true;
                                          });
                                          // Scaffold.of(context).showSnackBar(new SnackBar(
                                          //     content: new Text('Promo Code Applied!')
                                          // ));
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(4),
                                                  bottomRight: Radius.circular(4))),
                                          child: Icon(
                                            Icons.check,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            child:
                            Column(
                              children: [
                                buildAmountRow(
                                    context, locale.subTotal!, "Rs ${cartController.cartTotalPrice}"),

                                 buildAmountRow(
                                      context, locale.amountPayable!, "Rs ${cartController.cartTotalPrice}"),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomButton(
                            onTap: () {
                              Get.to(PaymentMethodScreen());
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) =>
                              //       _prescriptionRequired(context),
                              // );
                            },
                            radius: 0,
                            label: locale.checkout,
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
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
      ),
    );
  }

  Padding buildAmountRow(BuildContext context, String title, String amount) {
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            width: 4,
          ),
          title == locale.amountPayable
              ? GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.error_outline,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ))
              : SizedBox.shrink(),
          Spacer(),
          Text(
             amount,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }



  Widget _prescriptionRequired(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: FadedSlideAnimation(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadedScaleAnimation(
              Image.asset(
                'assets/upload prescription.png',
                scale: 3.5,
              ),
              durationInMilliseconds: 400,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              locale.prescriptionRequire!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 20,
            ),
            Text(locale.yourOrderContains2items!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 35,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
        Get.to(ConfirmOrder());
                },
                child: Text(
                  locale.uploadPrescription!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  locale.cancel!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).primaryColor),
                )),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
  updateCartMethod(cartId,int quantity){
print('quantit '+quantity.toString());
    postMethod(context, updateCartItem, {'cart_id':cartId,
      'quantity':quantity,}, true, updateCartRepo);

  }
}
//done
