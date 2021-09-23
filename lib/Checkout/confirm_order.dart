import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/controllers/cart_controller.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/confirm_order_repo.dart';
import 'package:doctoworld_user/repositories/get_user_detail_reop.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ConfirmOrder extends StatefulWidget {
  final paymentMethodId;
  ConfirmOrder({this.paymentMethodId});
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class CartItem {

  String name;
  int quantity;
  String amount;
  bool presReq;

  CartItem(this.name, this.quantity, this.amount, this.presReq,);
}

class _ConfirmOrderState extends State<ConfirmOrder> with SingleTickerProviderStateMixin{
TabController? tabController;
TextEditingController locationController=TextEditingController();
TextEditingController nameController=TextEditingController();
TextEditingController phoneController=TextEditingController();
int currentTabIndex=0;

@override
  void initState() {
    // TODO: implement initState
  getUserDetailRepo();
  locationController.text=userDetailModel.data.address;
  nameController.text=userDetailModel.data.name;
  phoneController.text=userDetailModel.data.phone;

  tabController  = new TabController(length: 2, vsync: this);
  super.initState();
  }
CartController cartController=Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locale.confirmOrder!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
      body: GetBuilder<LoaderController>(
        builder:(_)=> ModalProgressHUD(
          inAsyncCall:_.formLoader ,
          child: FadedSlideAnimation(

                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:   Row(children: [
                        Expanded(child: Divider(color: Theme.of(context).primaryColor,
                          thickness: 3,)),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: currentTabIndex!=0?Colors.white:Theme.of(context).primaryColor),
                            shape: BoxShape.circle,
                            color: currentTabIndex!=0?Theme.of(context).primaryColor:Colors.white
                          ),
                          child: Center(child:Text('1',
                          style: TextStyle(
                            color: currentTabIndex!=0?Theme.of(context).primaryColorLight:Theme.of(context).primaryColor,
                            fontSize: 18,

                          ),)),),
                        Expanded(child: Divider(color:
                        currentTabIndex!=0?Theme.of(context).primaryColor:Theme.of(context).primaryColorLight,
                          thickness: currentTabIndex!=0?3:2,)),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: currentTabIndex==2?Colors.white:Theme.of(context).primaryColor),
                            shape: BoxShape.circle,
                            color: currentTabIndex==2?Theme.of(context).primaryColor:Colors.white,

                          ),
                          child: Center(child:Text('2',
                            style: TextStyle(
                              color: currentTabIndex==2?Theme.of(context).primaryColorLight:Theme.of(context).primaryColor,
                              fontSize: 18,

                            ),)),),
                        Expanded(child: Divider(color:
                        currentTabIndex==2?Theme.of(context).primaryColor:Theme.of(context).primaryColorLight,
                          thickness: currentTabIndex==1?3:2,)),
                      ],),
                    ),

                    Expanded(child: viewSelectorMethod(currentTabIndex,locale))
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
viewSelectorMethod(int firstTabCompleted, locale) {
  switch (firstTabCompleted) {
    case 0:
      {
        /// customer details
        return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(

            children: [
              Center(
                child: Text('Customer Details',
                  style:TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600
                  ) ,),
              ),
              SizedBox(
                height: 15,
              ),


              /// full name
              ///
              Text('Full Name',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600
                ),),

              SizedBox(height: 5,),

              EntryField(
                prefixIcon: Icons.person,
                controller: nameController,
              ),

              SizedBox(height: 20,),



              /// phone
              ///
              Text('Phone',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600
                ),),

              SizedBox(height: 5,),

              EntryField(
                prefixIcon: Icons.phone,
                controller: phoneController,
              ),

              SizedBox(height: 20,),

              /// address
              ///
              Text('Address',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600
                ),),

              SizedBox(height: 5,),


                 EntryField(
                  onTap:  (){
                    if(!locationGet)
                    Get.find<LoaderController>().updateFormController(true);
                    getCurrentLocation(context);
                  },
                  prefixIcon: Icons.home,
                  controller: locationController,
                  suffixIcon:  Icons.location_on_outlined,
                ),


              SizedBox(height: 30,),
              CustomButton(
                onTap: () {
                  setState(() {
                    currentTabIndex=1;
                  });
                  // Get.to(PaymentMethodScreen());
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) =>
                  //       _prescriptionRequired(context),
                  // );
                },
                radius: 0,
                label: 'Next',
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 14,
                ),
              ),
            ],
          ),
        );
      }
      break;
    case 1:
      {
        /// order summery
        return  ListView(

        children: [
          Divider(
            height: 5,
            thickness: 5,
            color: Theme.of(context).backgroundColor,
          ),
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
        height: 75,):Image.network(
        "$imageBaseUrl${getCartItemsModel.data![index].medicine!.imagePath}",
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
          Text('Qty '+getCartItemsModel.data![index].qty!
              // '${getCartItemsModel.data![index].medicine!.salePrice!}'
              ,

              style: Theme.of(context)
                  .textTheme
                  .subtitle1),

        Text('Rs '+getCartItemsModel.data![index].price!
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
        ):Row(
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
          Divider(
            height: 5,
            thickness: 5,
            color: Theme.of(context).backgroundColor,
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
      context, 'Delivery Charges', cartController.cartTotalPrice<500? 'Rs 50':'Rs 0',),
      buildAmountRow(
      context, locale.amountPayable!, "Rs ${cartController.cartTotalPrice.toInt()+
          (cartController.cartTotalPrice.toInt()<500?50:0)}"),

      ],
      ),
      ),
      SizedBox(
      height: 5,
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                onTap: () {
                  setState(() {
                    currentTabIndex=0;
                  });
                  // Get.to(PaymentMethodScreen());
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) =>
                  //       _prescriptionRequired(context),
                  // );
                },
                radius: 0,
                label: 'Back',
                trailing: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 14,
                ),
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: CustomButton(
              onTap: () {
                setState(() {
                  currentTabIndex=2;
                });
                Get.find<LoaderController>().updateFormController(true);
                postMethod(context, orderPlaceService, {'customer_id':storageBox!.read('customerId'),
                  'full_name':nameController.text,
                  'phone':phoneController.text,
                  'address':locationController.text,
                  'payment_method_id':widget.paymentMethodId,
                  'shipping_price':cartController.cartTotalPrice.toInt()<500?50:0,
                  'sub_total':cartController.cartTotalPrice.toInt(),
                  'tax':0,
                  'total_price':cartController.cartTotalPrice.toInt()+
                      (cartController.cartTotalPrice.toInt()<500?50:0),
                  'lat':latitude,
                  'long':longitude
                }, true, confirmOrderRepo);
              // Get.to(PaymentMethodScreen());
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) =>
              //       _prescriptionRequired(context),
              // );
              },
              radius: 0,
              label: 'Confirm',
              trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 14,
              ),
              ),
            ),
          ],
        ),
      ),
      ],
      ),
      ),
      ),
      ],
      );
      }
      break;
    case 2 :
      {
        return Container();
      }

  }
}
  Container buildCustomContainer(BuildContext context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Padding buildAmountRow(BuildContext context, String title, String amount) {
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: title == locale.amountToPay
                    ? FontWeight.w500
                    : FontWeight.w400,
                fontSize: title != locale.amountToPay ? 15 : 16),
          ),
          SizedBox(
            width: 4,
          ),
          GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.error_outline,
                size: 16,
                color: Theme.of(context).primaryColor,
              )),
          Spacer(),
          Text(
            '\$ ' + amount,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 16.5,
                fontWeight: title == locale.amountToPay
                    ? FontWeight.w500
                    : FontWeight.w400),
          ),
        ],
      ),
    );
  }
var currentPosition;
var longitude=0.0;
var latitude=0.0;
var currentAddress;
bool locationGet=false;
getCurrentLocation(BuildContext context) {
  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
    setState(() {
      currentPosition = position;
      longitude = currentPosition!.longitude;
      latitude = currentPosition!.latitude;

      print("longitude : $longitude");
      print("latitude : $latitude");
      print("address : $currentPosition");
    });

    getAddressFromLatLng();
  }).catchError((e) {
    Get.find<LoaderController>().updateFormController(false);
    print(e);
  });
}

getAddressFromLatLng() async {
  try {
    // var currentPosition;
    List<Placemark> p = await GeocodingPlatform.instance
        .placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude);
    Placemark place = p[0];
    setState(() {
      currentAddress =
      '${place.name}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
      // var signUpAddressController;
      // if (signUpAddressController.text.isEmpty) {
      //   signUpAddressController.text = currentAddress;
      // }
      print(currentAddress + ' yes');
      print(place.administrativeArea.toString());
      print(place.subAdministrativeArea.toString());
      print(place.thoroughfare.toString());
      print(place.toJson().toString());
      // FocusScope.of(context).unfocus();
      locationController.text = place.name.toString();
      locationGet=true;
      Get.find<LoaderController>().updateFormController(false);
    });
  } catch (e) {
    Get.find<LoaderController>().updateFormController(false);
    print(e);
  }
}
}
