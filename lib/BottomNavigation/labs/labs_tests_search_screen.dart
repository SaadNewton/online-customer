//@dart=2.9
import 'package:doctoworld_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:doctoworld_user/Components/custom_dialog.dart';
import 'package:doctoworld_user/Models/get_medicine_from_search_model.dart';
import 'package:doctoworld_user/Models/labs_tests_search_model.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/add_to_cart_repo.dart';
import 'package:doctoworld_user/repositories/search_repo.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/post_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:doctoworld_user/storage/local_Storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LabsTestsSearchScreen extends StatefulWidget {
  const LabsTestsSearchScreen({Key key}) : super(key: key);

  @override
  _LabsTestsSearchScreenState createState() => _LabsTestsSearchScreenState();
}

class _LabsTestsSearchScreenState extends State<LabsTestsSearchScreen> {
  TextEditingController _searchController = TextEditingController();

  bool show = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<LoaderController>(
        init: LoaderController(),
        builder:(loaderController)=> ModalProgressHUD(
          inAsyncCall: loaderController.formLoader,
          child: Scaffold(
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: TextFormField(
                                autofocus: true,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal
                                ),
                                controller: _searchController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  hintText: 'Search Labs Tests',
                                  hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.1),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.2)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.2)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.2)),
                                  ),
                                ),
                                onChanged: (value) {
                                  if(value.isEmpty){
                                    loaderController.labsTestsSearchModel = new LabsTestsSearchModel();
                                  }else{

                                  }
                                },
                                onFieldSubmitted: (value){
                                  Get.find<LoaderController>().updateDataController(true);
                                  getMethod(
                                      context,
                                      labsTestsSearchService,
                                      {
                                        'search': _searchController.text
                                      },
                                      true,
                                      getAllLabTestsSearchRepo);
                                },
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Field Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    loaderController.dataLoader
                        ? Center(child: CircularProgressIndicator())
                        : loaderController.labsTestsSearchModel.data == null
                        ? SizedBox()
                        : Expanded(
                      child: ListView(
                        children: List.generate(loaderController.labsTestsSearchModel.data.length, (index) {
                          return Padding(
                            padding:
                            const EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: InkWell(
                              onTap: (){
                                // Get.to(ProductInfo(
                                //   medicineDetail: loaderController.labsTestsSearchModel.data[index],
                                // ));

                                ///


                                  if(getCartItemsModel.data == null){
                                    loaderController.updateFormController(true);
                                    addToCartMethod(loaderController.labsTestsSearchModel.data[index].id,
                                        loaderController.labsTestsSearchModel.data[index].price);
                                  }else if(getCartItemsModel.data[0].labId==loaderController.labsTestsSearchModel.data[index].labId){
                                    Get.find<LoaderController>().updateFormController(true);
                                    addToCartMethod(loaderController.labsTestsSearchModel.data[index].id,
                                        loaderController.labsTestsSearchModel.data[index].price);
                                  }else{
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                            title: 'INFO!',
                                            titleColor: customDialogInfoColor,
                                            descriptions: 'You can\'t be add multi labs tests.',
                                            text: 'Ok',
                                            functionCall: () {
                                              Navigator.pop(context);
                                            },
                                            img: 'assets/dialog_Info.svg',
                                          );
                                        });
                                  }

                                  //Navigator.pushNamed(context, PageRoutes.doctorInfo);


                                ///

                              },
                              child: Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          blurRadius: 9,
                                          spreadRadius: 3,
                                          offset: Offset(0, 4))
                                    ]),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                width: 0.8),
                                            image: DecorationImage(
                                                image: loaderController.labsTestsSearchModel.data[index].imagePath != null
                                                    ? NetworkImage(
                                                    '$imageBaseUrl${loaderController.labsTestsSearchModel.data[index].imagePath}'
                                                )
                                                    : AssetImage(
                                                  'assets/Medicines/11.png',
                                                ))),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [

                                            SizedBox(
                                              height: 2,
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Text(
                                                  '${loaderController.labsTestsSearchModel.data[index].name}',
                                                  softWrap: true,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w900
                                                  ),),
                                                Text(
                                                  'Price: ${loaderController.labsTestsSearchModel.data[index].price}',
                                                  softWrap: true,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w900
                                                  ),),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 4,
                                            ),

                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Is available for home:',
                                                  softWrap: true,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w900
                                                  ),),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  loaderController.labsTestsSearchModel.data[index].isAvailableForHome == 0 ? 'No' : 'Yes',
                                                  softWrap: true,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w900
                                                  ),),

                                              ],
                                            ),
                                            Text(
                                              'Lab: ${loaderController.labsTestsSearchModel.data[index].lab.name}',
                                              softWrap: true,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900
                                              ),),
                                            SizedBox(
                                              height: 4,
                                            ),

                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addToCartMethod(productId,productPrice){

    postMethod(context, addToCartService, {'product_id':productId,
      'customer_id':storageBox.read('customerId'),
      'qty':1,
      'type':'test',
      'product_price':productPrice}, true, addToCartRepo);
  }
}