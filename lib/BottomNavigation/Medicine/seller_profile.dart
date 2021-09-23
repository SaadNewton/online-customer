import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/custom_add_item_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';

class SellerProfilePage extends StatefulWidget {
  @override
  _SellerProfilePageState createState() => _SellerProfilePageState();
}

class MedicineInfo {
  String image;
  String name;
  String price;
  bool prescription;

  MedicineInfo(this.image, this.name, this.price, this.prescription);
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<MedicineInfo> _myItems = [
      MedicineInfo(
          'assets/Medicines/11.png', 'Salospir 100mg\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/22.png', 'Xenical 120mg\nTablet', '3.00', false),
      MedicineInfo('assets/Medicines/33.png', 'Allergy Relief\nTopcare Tablet',
          '4.00', false),
      MedicineInfo(
          'assets/Medicines/44.png', 'Arber OTC\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/55.png', 'Non Drosy\nLartin Tablet', '3.50', false),
      MedicineInfo(
          'assets/Medicines/66.png', 'Coricidin 100mg\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/11.png', 'Salospir 100mg\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/22.png', 'Xenical 120mg\nTablet', '3.00', false),
      MedicineInfo('assets/Medicines/33.png', 'Allergy Relief\nTopcare Tablet',
          '4.00', false),
      MedicineInfo(
          'assets/Medicines/44.png', 'Arber OTC\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/55.png', 'Non Drosy\nLartin Tablet', '3.50', false),
      MedicineInfo(
          'assets/Medicines/66.png', 'Coricidin 100mg\nTablet', '3.50', true),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadedScaleAnimation(
                  Image.asset('assets/SellerImages/1.png', scale: 3.5),
                  durationInMilliseconds: 400,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(locale.wellLifeStore!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 25)),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).hintColor,
                          size: 12,
                        ),
                        Text(' ' + 'Willington Bridge',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).disabledColor,
                                fontSize: 13.0)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            color: Theme.of(context).backgroundColor,
            child: GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _myItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.82,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutes.medicineInfo);
                    },
                    child: Stack(
                      children: [
                        Container(
                          // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  FadedScaleAnimation(
                                    Image.asset(_myItems[index].image),
                                    durationInMilliseconds: 400,
                                  ),
                                  if (_myItems[index].prescription)
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: FadedScaleAnimation(
                                        Image.asset(
                                          'assets/ic_prescription.png',
                                          scale: 3,
                                        ),
                                        durationInMilliseconds: 400,
                                      ),
                                    )
                                  else
                                    SizedBox.shrink(),
                                ],
                              ),
                              Spacer(),
                              Text(_myItems[index].name),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '\$ ' + _myItems[index].price,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CustomAddItemButton(),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
//done
