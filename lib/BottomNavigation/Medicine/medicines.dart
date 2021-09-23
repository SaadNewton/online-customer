import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:doctoworld_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:doctoworld_user/Components/custom_add_item_button.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';

import 'package:doctoworld_user/repositories/get_cart_items_repo.dart';
import 'package:doctoworld_user/repositories/get_products_by_category_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';

import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class MedicinesPage extends StatefulWidget {
  final String? categoryName;
  final categoryId;
  MedicinesPage({this.categoryName,this.categoryId});
  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {

  @override
  void initState() {
    // TODO: implement initState
    isCartPage=false;
    getMethod(context, getCartProductsService,
        {'customer_id':storageBox!.read('customerId')}, true, getAllCartItemsRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(_)=> ModalProgressHUD(
        inAsyncCall: _.formLoader,
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.categoryName!),
              textTheme: Theme.of(context).textTheme,
              centerTitle: true,
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Get.find<LoaderController>().updateCartDataController(true);

                        });
                        Get.to(CartPage());
                      },
                    ),
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      top: 8,
                      end: 12,
                      child: _.cartLoader?
                      CircularProgressIndicator():
                      getCartItemsModel.status==false?SizedBox():CircleAvatar(
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
            body: GetBuilder<LoaderController>(
              init: LoaderController(),
              builder: (_) => _.dataLoader
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : getProductsByCategoryModel.status==false?Center(child: Text(
                  getProductsByCategoryModel.message!
              ),):FadedSlideAnimation(
                      Medicines(categoryId: widget.categoryId,),
                      beginOffset: Offset(0, 0.3),
                      endOffset: Offset(0, 0),
                      slideCurve: Curves.linearToEaseOut,
                    ),
            )),
      ),
    );
  }
}

class Medicines extends StatefulWidget {
  final categoryId;
  Medicines({this.categoryId});
  @override
  _MedicinesState createState() => _MedicinesState();
}

class MedicineInfo {
  String image;
  String name;
  String price;
  bool prescription;
  int productIndex;
  MedicineInfo(
      this.image, this.name, this.price, this.prescription, this.productIndex);
}

class _MedicinesState extends State<Medicines> {
  int? medicinePageNumber=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<MedicineInfo> _myItems = List.generate(
      getProductsByCategoryModel.data!.data!.length,
      (index) => MedicineInfo(
          getProductsByCategoryModel.data!.data![index].imagePath ?? 'user',
          getProductsByCategoryModel.data!.data![index].name!,
          getProductsByCategoryModel.data!.data![index].salePrice!,
          false,
          index),
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: [
            GridView.builder(
              shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                physics: BouncingScrollPhysics(),
                itemCount: _myItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.18,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                     if( getProductsByCategoryModel.data!.data![index].isItemType=='1'){
                       productPrice=getProductsByCategoryModel.data!.data![index].itemPrice[0]['price'];
                     }
                      Get.to(ProductInfo(
                        index: index,
                      ));
                    },
                    child: Container(
                      // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),

                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                FadedScaleAnimation(
                                  _myItems[index].image == 'user'
                                      ? Image.asset(
                                          'assets/FooterIcons/ic_medicineact.png',
                                          color: Theme.of(context).primaryColor,
                                          height: 100,
                                        )
                                      : Image.network(
                                          "$imageBaseUrl${_myItems[index].image}",
                                          height: 100,
                                        ),
                                  durationInMilliseconds: 400,
                                ),
                                Text(_myItems[index].name),
                                SizedBox(height: 5),
                                Text(
                                  'Rs ' + _myItems[index].price,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child:
                              GestureDetector(
                                onTap: () {
                                Get.to(ProductInfo(index: index,));

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                }),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(child: InkWell(
                 onTap: (){
                   setState(() {
                     medicinePageNumber=medicinePageNumber!+1;
                   });
                   Get.find<LoaderController>().updateDataController(true);
                   getMethod(
                       context,
                       getProductByCategoryService,
                       {
                         'category_id':
                         widget.categoryId,
                         'page':medicinePageNumber
                       },
                       true,
                       getProductsByCategoryRepo);
                 },
                 child: SvgPicture.asset('assets/refresh-button.svg',
                   height: 40,
                   color: Theme.of(context).primaryColor,))),
           )
          ],
        ),
      ),
    );
  }
}
//done
