import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:doctoworld_user/BottomNavigation/labs/about_tab.dart';
import 'package:doctoworld_user/BottomNavigation/labs/departments_tab.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/controllers/loading_controller.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:doctoworld_user/repositories/get_all_lab_departments.dart';
import 'package:doctoworld_user/services/get_method_call.dart';
import 'package:doctoworld_user/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LabInfo extends StatefulWidget {
  final index;
  LabInfo({this.index});

  @override
  _LabInfoState createState() => _LabInfoState();
}

class _LabInfoState extends State<LabInfo> with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedTab = 0;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<LoaderController>().updateDataController(true);

      //0/ get labs repo will be called in getCurrentLocation method
    });
    getMethod(
        context,
        getTestCategoriesService,
        {'lab_id': getAllLabsModel.data!.data![widget.index].id} ,
        true,
        getAllDepartmentsRepo);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (_) => ModalProgressHUD(
        inAsyncCall: _.formLoader,
        child: Scaffold(
          body: _.dataLoader
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: NestedScrollView(
                    // physics: BouncingScrollPhysics(),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverList(
                            delegate: SliverChildListDelegate([
                          FadedScaleAnimation(
                          getAllLabsModel.data!.data![widget.index].imagePath==null?
                          Image.asset(
                          'assets/upload prescription.png',
                            height: MediaQuery.of(context).size.height*0.3,
                          fit: BoxFit.fill,
                          ):Image.network(
                              '$imageBaseUrl${getAllLabsModel.data!.data![widget.index].imagePath!}',
                              fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height*0.3,
                            ),
                            durationInMilliseconds: 400,
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getAllLabsModel.data!.data![widget.index].name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 24, height: 2),
                                ),
                                Text(
                                  getAllLabsModel.data!.data![widget.index].city!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          fontSize: 16,
                                          color: Theme.of(context).disabledColor,
                                          height: 2),
                                ),
                              ],
                            ),
                          ),
                        ])),
                      ];
                    },
                    body: Wrap(
                      // crossAxisAlignment: WrapCrossAlignment.start,
                      // direction: Axis.vertical,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TabBar(
                            onTap: (index) {
                              setState(() {
                                selectedTab = index;
                              });
                            },
                            controller: tabController,
                            indicatorColor: Colors.transparent,
                            unselectedLabelColor: Theme.of(context).disabledColor,
                            labelColor: Theme.of(context).primaryColor,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                            unselectedLabelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                            isScrollable: true,
                            labelPadding:
                                EdgeInsetsDirectional.only(end: 20, top: 10),
                            tabs: [
                              Tab(text: locale!.about),
                              Tab(text: 'Categories'),
                            ],
                          ),
                        ),
                        Builder(builder: (BuildContext? customBuilder) {
                          if (selectedTab == 0) {
                            return FadedSlideAnimation(
                              About(
                                index: widget.index,
                              ),
                              beginOffset: Offset(0, 0.3),
                              endOffset: Offset(0, 0),
                              slideCurve: Curves.linearToEaseOut,
                            );
                          } else if (selectedTab == 1) {
                            return FadedSlideAnimation(
                              Departments(
                                  labId: getAllLabsModel
                                      .data!.data![widget.index].id!),
                              beginOffset: Offset(0, 0.3),
                              endOffset: Offset(0, 0),
                              slideCurve: Curves.linearToEaseOut,
                            );
                          }
                          return Container();
                        }),


                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}


