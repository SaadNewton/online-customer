import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/lab_search_screen.dart';
import 'package:doctoworld_user/BottomNavigation/labs/lab_info.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/controllers/location_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_user_detail_reop.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'labs/labs_tests_search_screen.dart';

class LabsHome extends StatefulWidget {
  final LocationController controller = Get.put(LocationController());
  @override
  _LabsHomeState createState() => _LabsHomeState();
}

class _LabsHomeState extends State<LabsHome> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LocationController>().loadMore = false;
      Get.find<LoaderController>().updateDataController(true);
      labPage=1;
      /// get labs repo will be called in getCurrentLocation method
      Get.find<LocationController>().getCurrentLocation(context);
    });
    getUserDetailRepo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (_) => _.dataLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: _.currentCity == null
                    ? Text(
                  'WELCOME',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
                    : Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      _.currentCity!,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              body: LabsBody(),
            ),
    );
  }
}

class LabsBody extends StatefulWidget {
  @override
  _LabsBodyState createState() => _LabsBodyState();
}

class LabDetail {
  String image;
  String name;
  String type;
  String location;
  dynamic labdetail;
  LabDetail(this.image, this.name, this.type, this.location, this.labdetail);
}

class _LabsBodyState extends State<LabsBody> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: (getAllLabsModel.status==false && Get.find<LocationController>().labsList.length == 0)
          ?Center(child: Text(getAllLabsModel.message!),)
          :ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Text(
              locale.hello! + ', ${userDetailModel.data.name},',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 20, color: Theme.of(context).disabledColor),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 25, left: 20, right: 20),
            child: FadedScaleAnimation(
              Text(
                'Find Test',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              durationInMilliseconds: 400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: InkWell(
              onTap: (){
                Get.to(LabsTestsSearchScreen());
              },
              child: EntryField(
                enabled: false,
                hint: 'Search Tests',
                prefixIcon: Icons.search,
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          //   child: Row(
          //     children: [
          //       Text(
          //         locale.searchByCategory!,
          //         style: Theme.of(context).textTheme.bodyText2!.copyWith(
          //             color: Theme.of(context).disabledColor, fontSize: 20),
          //       ),
          //       Spacer(),
          //       Text(
          //         locale.viewAll!,
          //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
          //             color: Theme.of(context).primaryColor, fontSize: 20),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 123.3,
          //   margin: EdgeInsets.only(left: 10),
          //   child: ListView.builder(
          //       shrinkWrap: true,
          //       physics: BouncingScrollPhysics(),
          //       scrollDirection: Axis.horizontal,
          //       itemCount: doctorCategories.length,
          //       itemBuilder: (context, index) {
          //         return InkWell(
          //           onTap: () {
          //             Navigator.pushNamed(context, PageRoutes.medicines);
          //           },
          //           child: Padding(
          //             padding: EdgeInsets.only(left: 10),
          //             child: FadedScaleAnimation(
          //               Image.asset(
          //                 doctorCategories[index],
          //                 // height: 100,
          //                 width: 95,
          //                 fit: BoxFit.fill,
          //               ),
          //               durationInMilliseconds: 300,
          //             ),
          //           ),
          //         );
          //       }),
          // ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, right: 16, left: 16),
            child: Text(
              'Labs near you',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).disabledColor, fontSize: 20),
            ),
          ),
          LabsList(),
          getAllLabsModel.status==false
              ?SizedBox()
              : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(child: InkWell(
                onTap: (){

                    labPage=labPage+1;
                    Get.find<LocationController>().loadMore = true;
                  Get.find<LoaderController>().updateDataController(true);
                  Get.find<LocationController>().getCurrentLocation(context);
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
    );
  }
}

class LabsList extends StatelessWidget {
  final List<LabDetail> _Labs = List.generate(
      Get.find<LocationController>().labsList.length,
      (index) => LabDetail(
          Get.find<LocationController>().labsList[index].imagePath??'user',
          Get.find<LocationController>().labsList[index].name??'testing',
          Get.find<LocationController>().labsList[index].city??'testing',
          Get.find<LocationController>().labsList[index].address??'testing',
          Get.find<LocationController>().labsList[index]));

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: _Labs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(LabInfo(
              labDetail: Get.find<LocationController>().labsList[index],
            ));
          },
          child: Column(
            children: [
              Divider(
                color: Theme.of(context).backgroundColor,
                thickness: 6,
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 16),
                title: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _Labs[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20, height: 1.5),
                          ),
                          Text(
                            _Labs[index].type,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontSize: 16,
                                    color: Theme.of(context).disabledColor,
                                    height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: _Labs[index].image=='user'?SvgPicture.asset('assets/labs icon.svg'):Image.network(
                        "$imageBaseUrl${_Labs[index].image}",
                        height: 50,
                      ),
                    ))
                    // Expanded(
                    //   child: Container(
                    //     height: 50,
                    //     width: MediaQuery.of(context).size.width / 2,
                    //     child: ListView.builder(
                    //       shrinkWrap: true,
                    //       physics: BouncingScrollPhysics(),
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: doctorCategories.length,
                    //       itemBuilder: (context, index) {
                    //         return InkWell(
                    //           onTap: () {
                    //             //  Navigator.pushNamed(context, PageRoutes.medicines);
                    //           },
                    //           child: Padding(
                    //             padding: EdgeInsets.only(left: 5),
                    //             child: FadedScaleAnimation(
                    //               Image.asset(
                    //                 doctorCategories[index],
                    //                 // height: 100,
                    //                 width: 90,
                    //                 fit: BoxFit.fill,
                    //               ),
                    //               durationInMilliseconds: 300,
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 16.0, top: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Theme.of(context).disabledColor,
                      size: 13,
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        _Labs[index].location,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 13,
                            color: Theme.of(context).disabledColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),


                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
//done
