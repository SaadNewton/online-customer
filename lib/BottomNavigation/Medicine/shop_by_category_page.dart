import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Data/category_data_list.dart';
import 'package:doctoworld_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_products_by_category_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShopByCategoryPage extends StatefulWidget {
  @override
  _ShopByCategoryPageState createState() => _ShopByCategoryPageState();
}

class _ShopByCategoryPageState extends State<ShopByCategoryPage> {
  int? _currentIndex;
 int  medicinePageNumber=0;
  late List<String> subCategories;
  int categoryId=allCategoriesModel.data.data[0].id;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateDataController(true);
    });
    getMethod(
        context,
        getProductByCategoryService,
        {'category_id': allCategoriesModel.data.data[0].id,
        },
        true,
        getProductsByCategoryRepo);
    _currentIndex = 0;
    subCategories = getSubcategories(0);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.shopByCategory!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: GetBuilder<LoaderController>(
        init: LoaderController(),
        builder: (_) => _.dataLoader
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Theme.of(context).dividerColor,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(

                          physics: BouncingScrollPhysics(),
                          itemCount: allCategoriesModel.data.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  Get.find<LoaderController>()
                                      .updateDataController(true);
                                  _currentIndex = index;
                                  categoryId=allCategoriesModel.data.data[index].id;
                                  getMethod(
                                      context,
                                      getProductByCategoryService,
                                      {
                                        'category_id': allCategoriesModel
                                            .data.data[index].id
                                      },
                                      true,
                                      getProductsByCategoryRepo);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Stack(
                                  children: [
                                    FadedScaleAnimation(
                                      Image.network(
                                        "$imageBaseUrl${allCategoriesModel.data.data[index].imagePath}",
                                        height: 130,
                                        fit: BoxFit.fill,
                                      ),
                                      durationInMilliseconds: 100,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        allCategoriesModel
                                            .data.data[index].name,
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    _currentIndex == index
                                        ? Container(
                                            height: 130,
                                            padding: EdgeInsets.only(bottom: 4),
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Theme.of(context)
                                                        .scaffoldBackgroundColor
                                                        .withOpacity(0.0),
                                                    Theme.of(context)
                                                        .scaffoldBackgroundColor
                                                        .withOpacity(0.6),
                                                    Theme.of(context)
                                                        .scaffoldBackgroundColor
                                                        .withOpacity(0.9)
                                                  ],
                                                  stops: [
                                                    0.3,
                                                    0.65,
                                                    0.9
                                                  ]),
                                            ),
                                            child:
                                                Icon(Icons.arrow_forward_ios),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView(

                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: getProductsByCategoryModel.data!.data!.length,
                            itemBuilder: (context, index) => Container(
                              margin:
                                  EdgeInsetsDirectional.only(start: 16, bottom: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(ProductInfo(
                                    medicineDetail:getProductsByCategoryModel.data!.data![index] ,
                                  ));
                                },
                                child: ListTile(
                                  title: FadedScaleAnimation(
                                    Text(getProductsByCategoryModel
                                        .data!.data![index].name!),
                                    durationInMilliseconds: 400,
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: InkWell(
                                onTap: (){
                                  setState(() {
                                    medicinePageNumber=medicinePageNumber+1;
                                  });
                                  Get.find<LoaderController>().updateDataController(true);
                                  getMethod(
                                      context,
                                      getProductByCategoryService,
                                      {
                                        'category_id':
                                        categoryId,
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
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
//done
