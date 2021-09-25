import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/add_to_cart_repo.dart';
import 'package:doctoworld_user/repositories/get_all_test_by_category_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Departments extends StatefulWidget {
  final labId;
  Departments({this.labId});
  @override
  _DepartmentsState createState() => _DepartmentsState();
}

class SearchDoctorTile {
  String image;
  String name;
  String speciality;
  String hospital;
  String experience;
  String fee;
  String reviews;

  SearchDoctorTile(this.image, this.name, this.speciality, this.hospital,
      this.experience, this.fee, this.reviews);
}

class _DepartmentsState extends State<Departments> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int? id;
  @override
  Widget build(BuildContext context) {
    LoaderController c = Get.put(LoaderController());
    var locale = AppLocalizations.of(context)!;

    return Wrap(
      children: List.generate(
          getAllLabDepartmentsModel.data!.length,
          (index) => Wrap(
                children: [
                  Divider(
                    thickness: 4,
                    color: Theme.of(context).backgroundColor,
                  ),
                  ExpansionTileCard(
                    onExpansionChanged: (value) {
                      setState(() {
                        id = getAllLabDepartmentsModel.data![index].id;
                      });
                      Get.find<LoaderController>().updateInnerDataLoader(true);
                      //0/ get labs repo will be called in getCurrentLocation method
                      getMethod(
                          context,
                          getAllTestsByCategoryService,
                          {
                            'test_category_id':
                                getAllLabDepartmentsModel.data![index].id
                          },
                          true,
                          getAllTestsByCategoryRepo);
                    },
                    children: [
                      id == getAllLabDepartmentsModel.data![index].id
                          ? GetBuilder<LoaderController>(
                              init: LoaderController(),
                              builder: (_) => _.innerLoader
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child:
                                            getAllTestsByCategory.status != true
                                                ? Center(
                                                    child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        'No test Available'),
                                                  ))
                                                : Wrap(
                                                    children: List.generate(
                                                        getAllTestsByCategory
                                                            .data!.length,
                                                        (index) => Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {

                                                                  Get.find<LoaderController>().updateFormController(true);
                                                                  addToCartMethod(getAllTestsByCategory.data![index].id,
                                                                      getAllTestsByCategory.data![index].price);
                                                                  //Navigator.pushNamed(context, PageRoutes.doctorInfo);
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        /// test image
                                                                        Expanded(
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            child: Image
                                                                                .network(
                                                                              "$imageBaseUrl${getAllTestsByCategory.data![index].imagePath}",
                                                                              fit: BoxFit
                                                                                  .fill,
                                                                              height:
                                                                                  80,
                                                                            ),
                                                                          ),
                                                                        ),

                                                                        SizedBox(
                                                                          width: 15,
                                                                        ),
                                                                        Expanded(
                                                                          flex: 3,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              ///test name
                                                                              RichText(
                                                                                  text: TextSpan(style: Theme.of(context).textTheme.subtitle2, children: <TextSpan>[
                                                                                TextSpan(
                                                                                    text: getAllTestsByCategory.data![index]!.name! + '\n',
                                                                                    style: Theme.of(context).textTheme.subtitle1),
                                                                                TextSpan(
                                                                                  text: 'Rs: ',
                                                                                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).disabledColor, fontSize: 12, height: 1.5),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: getAllTestsByCategory.data![index].price,
                                                                                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black, fontSize: 16, height: 1.5),
                                                                                ),
                                                                              ])),

                                                                              /// by home sample
                                                                              Row(
                                                                                mainAxisAlignment:
                                                                                    MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text('By Home'),
                                                                                  getAllTestsByCategory.data![index].isAvailableForHome == 1
                                                                                      ? Icon(
                                                                                          Icons.check_circle_outline_outlined,
                                                                                          color: Theme.of(context).primaryColor,
                                                                                        )
                                                                                      : Container()
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(
                                                                      height: 6,
                                                                      thickness: 6,
                                                                      color: Theme.of(context).backgroundColor,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                  ),
                                      ),
                                    ),
                            )
                          : Container(),
                    ],
                    title: Text(
                      getAllLabDepartmentsModel.data![index].name!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )),
    );
  }
  addToCartMethod(productId,productPrice){

    postMethod(context, addToCartService, {'product_id':productId,
      'customer_id':storageBox!.read('customerId'),
      'qty':1,
      'type':'test',
      'product_price':productPrice}, true, addToCartRepo);
  }
}
