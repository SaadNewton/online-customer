import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctoworld_user/BottomNavigation/Data/data.dart';
import 'package:doctoworld_user/BottomNavigation/Medicine/medicines.dart';
import 'package:doctoworld_user/BottomNavigation/Medicine/my_cart.dart';
import 'package:doctoworld_user/BottomNavigation/Medicine/shop_by_category_page.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Components/title_row.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_all_categories_repo.dart';
import 'package:doctoworld_user/repositories/get_cart_items_repo.dart';
import 'package:doctoworld_user/repositories/get_products_by_category_repo.dart';
import 'package:doctoworld_user/repositories/get_user_detail_reop.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MedicinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FindMedicine();
  }
}

class FindMedicine extends StatefulWidget {
  final LoaderController c = Get.put(LoaderController());
  @override
  _FindMedicineState createState() => _FindMedicineState();
}

class _FindMedicineState extends State<FindMedicine> {
  List bannerList=['assets/banners/Doctor Online App Banner 4.jpg','assets/banners/Doctor Online App Banner 1.jpg','assets/banners/Doctor Online App Banner 2.jpg',
  'assets/banners/Doctor Online App Banner 3.jpg'];
  int _currentSliderIndexForImageSlider=0;
  @override
  void initState() {
    // TODO: implement initState
    isCartPage=false;
    getMethod(context, getCartProductsService,
        {'customer_id':storageBox!.read('customerId')}, true, getAllCartItemsRepo);
    getUserDetailRepo();
    getMethod(
        context, getAllCategoriesService, null, true, getAllCategoriesRepo);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (_) => _.dataLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      userDetailModel.data.city ?? 'Faisalabad',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                actions: <Widget>[
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
                        CircularProgressIndicator():getCartItemsModel.status==false?SizedBox():CircleAvatar(
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
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 6),
                    child: Text(
                      locale.hello! + ', ${userDetailModel.data.name}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: FadedScaleAnimation(
                  //     Text(
                  //       locale.findYourMedicines!,
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .headline5!
                  //           .copyWith(fontWeight: FontWeight.bold),
                  //     ),
                  //     durationInMilliseconds: 400,
                  //   ),
                  // ),
                  // FadedScaleAnimation(
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 8.0, horizontal: 16),
                  //     child: EntryField(
                  //       hint: locale.searchMedicines,
                  //       prefixIcon: Icons.search,
                  //     ),
                  //   ),
                  //   durationInMilliseconds: 300,
                  // ),
                  /// banner
                  ///
                  Column(
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: CarouselSlider(

                            items: List.generate(bannerList.length, (index){
                              return Container(
                                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                // height: 400,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    bannerList[index],
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            }),

                            ///Slider Container properties
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              onPageChanged: (index, value){
                                setState(() {
                                  _currentSliderIndexForImageSlider = index;
                                });
                              },
                              // height: 600,
                              // aspectRatio: 16/9,
                              viewportFraction: 1,
                              // initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              // enlargeCenterPage: true,
                              // onPageChanged: callbackFunction,
                              scrollDirection: Axis.horizontal,
                            ),

                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: bannerList.map((image) {       //these two lines
                          int index = bannerList.indexOf(image); //are changed
                          return Container(
                            width: _currentSliderIndexForImageSlider == index
                                ?10
                                :5.0,
                            height: 5.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _currentSliderIndexForImageSlider == index
                                    ? Theme.of(context).primaryColor
                                    : Color.fromRGBO(0, 0, 0, 0.4)),
                          );
                        },
                        ).toList(),
                      ),
                    ],
                  ),

                  /// Path buttons
                  ///
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 170,
                      child: Row(
                        children: [

                          /// doctor button
                          ///
                         Expanded(
                           child: Column(
                             children: [
                               Expanded(
                                 child: Container(
                                  width: double.infinity,
                                   decoration: BoxDecoration(
                                       color: customOrangeColor,
                                     borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5
                                    )]
                                   ),
                                   child: Container(
                                     margin: EdgeInsets.only(bottom: 10),
                                     height: double.infinity,
                                     width: double.infinity,
                                     decoration: BoxDecoration(
                                         image: DecorationImage(image: AssetImage('assets/orange.png'),
                                             fit: BoxFit.fill),
                                         color: Colors.white,
                                         borderRadius: BorderRadius.circular(20),
                                         boxShadow: [BoxShadow(
                                             color: Colors.grey.withOpacity(0.2),
                                             spreadRadius: 2,
                                             blurRadius: 5
                                         )]
                                     ),
                                     child:Padding(
                                       padding: const EdgeInsets.all(15.0),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           SvgPicture.asset('assets/doctor icon.svg',
                                           height: 40,),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text('Doctors',
                                                 style: TextStyle(
                                                   color: customOrangeColor,
                                                   fontSize: 16,
                                                   fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                               SvgPicture.asset('assets/arrow-left-circle.svg',
                                                 color: customOrangeColor,
                                                 height: 20,
                                               )
                                             ],
                                           )
                                         ],
                                       ),
                                     ),
                                   ),
                                 ),
                               ),

                             ],
                           ),
                         ),

                          SizedBox(width: 15,),

                          /// labs button
                          ///
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: customBlueColor,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5
                                        )]
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      height: double.infinity,
                                      width: double.infinity,

                                      decoration: BoxDecoration(
image: DecorationImage(image: AssetImage('assets/blue.png'),
fit: BoxFit.fill),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5
                                          )]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset('assets/labs icon.svg',
                                              height: 40,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Labs',
                                                  style: TextStyle(
                                                      color: customBlueColor,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                SvgPicture.asset('assets/arrow-left-circle.svg',
                                                  color: customBlueColor,
                                                  height: 20,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
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

                  /// pharmacy button
                  ///
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 140,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: customDarkBlueColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5
                                  )]
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(

                                        color: customLightBlueColor,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5
                                        )]
                                    ),
                                    child:Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: customDarkBlueColor,
                                              shape: BoxShape.circle
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset('assets/Path 228.svg',
                                                height: 25,),
                                            ),
                                          ),
                                          Row(

                                            children: [
                                              Text('Pharmacy',
                                                style: TextStyle(
                                                    color: customDarkBlueColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold
                                                ),

                                              ),
                                              SizedBox(width: 20,),
                                              SvgPicture.asset('assets/arrow-left-circle.svg',
                                                color: customDarkBlueColor,
                                                height: 20,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      right: 15,
                                      child: SvgPicture.asset('assets/Group 10.svg'))
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  TitleRow(locale.shopByCategory, () {
                    Get.to(ShopByCategoryPage());
                  }),


                  /// categories
                  Container(
                    height: 124,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: allCategoriesModel.data.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              WidgetsBinding.instance!
                                  .addPostFrameCallback((_) {
                                Get.find<LoaderController>()
                                    .updateDataController(true);
                              });

                              getMethod(
                                  context,
                                  getProductByCategoryService,
                                  {
                                    'category_id':
                                        allCategoriesModel.data.data[index].id,
                                    'page':1
                                  },
                                  true,
                                  getProductsByCategoryRepo);
                              Get.to(MedicinesPage(
                                categoryId:  allCategoriesModel.data.data[index].id,
                                  categoryName: allCategoriesModel
                                      .data.data[index].name));
                            },
                            child: FadedScaleAnimation(
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  width: 120,
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        '$imageBaseUrl${allCategoriesModel.data.data[index].imagePath}',
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          allCategoriesModel
                                              .data.data[index].name,
                                          maxLines: 2,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              durationInMilliseconds: 100,
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 20,)
                  // TitleRow(locale.offers, () {
                  //   Navigator.pushNamed(context, PageRoutes.offersPage);
                  // }),
                  // Container(
                  //   height: 108,
                  //   child: ListView.builder(
                  //       shrinkWrap: true,
                  //       padding: EdgeInsets.symmetric(horizontal: 20),
                  //       physics: BouncingScrollPhysics(),
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: banner.length,
                  //       itemBuilder: (context, index) {
                  //         return Padding(
                  //           padding: EdgeInsetsDirectional.only(end: 20),
                  //           child: GestureDetector(
                  //               onTap: () {
                  //                 Navigator.pushNamed(
                  //                     context, PageRoutes.offersPage);
                  //               },
                  //               child: FadedScaleAnimation(
                  //                 Image.asset(banner[index], fit: BoxFit.fill),
                  //                 durationInMilliseconds: 300,
                  //               )),
                  //         );
                  //       }),
                  // ),
                  // TitleRow(locale.sellerNearYou, null),
                  // Container(
                  //   height: 156,
                  //   child: GridView.builder(
                  //     itemCount: stores.length,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       mainAxisSpacing: 20,
                  //       childAspectRatio: 0.38,
                  //     ),
                  //     shrinkWrap: true,
                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //     physics: BouncingScrollPhysics(),
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) =>
                  //         quickGrid(context, stores[index]),
                  //   ),
                  // ),
                ],
              )),
    );
  }

  // Widget quickGrid(BuildContext context, String image) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pushNamed(context, PageRoutes.sellerProfile);
  //     },
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         FadedScaleAnimation(
  //           Image(
  //             image: AssetImage(image),
  //             height: 54,
  //           ),
  //           durationInMilliseconds: 300,
  //         ),
  //         SizedBox(width: 13.3),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text('Well Life Store',
  //                 style: Theme.of(context).textTheme.subtitle1),
  //             SizedBox(height: 8.0),
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.location_on,
  //                   color: Theme.of(context).hintColor,
  //                   size: 12,
  //                 ),
  //                 Text(' ' + 'Willington Bridge',
  //                     style: Theme.of(context).textTheme.caption!.copyWith(
  //                         color: Theme.of(context).disabledColor,
  //                         fontSize: 10.0)),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
