import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';

class Address {
  final IconData icon;
  final String? addressType;
  final String address;

  Address(this.icon, this.addressType, this.address);
}

class SavedAddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.savedAddresses!),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
        ),
        body: FadedSlideAnimation(
          SavedAddresses(),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}

class SavedAddresses extends StatefulWidget {
  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Address> listOfAddressTypes = [
      Address(Icons.home, AppLocalizations.of(context)!.home,
          '1024, Central Residency, Hemilton Park,\nNew York, USA'),
      Address(Icons.business, AppLocalizations.of(context)!.office,
          '1024, Central Residency, Hemilton Park,\nNew York, USA'),
      Address(Icons.assistant, AppLocalizations.of(context)!.other,
          'Flat Num 114, First Floor, Central Residency, USA'),
    ];
    return Container(
      color: Theme.of(context).dividerColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ListView.builder(
              itemCount: listOfAddressTypes.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    tileColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: Icon(
                      listOfAddressTypes[index].icon,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(listOfAddressTypes[index].addressType!),
                    ),
                    subtitle: Text(
                      listOfAddressTypes[index].address,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 11.7),
                    ),
                  ),
                );
              }),
          Spacer(),
          CustomButton(
            icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
            label: AppLocalizations.of(context)!.addNewAddress,
            textColor: Theme.of(context).primaryColor,
            color: Theme.of(context).scaffoldBackgroundColor,
            onTap: () => Navigator.pushNamed(context, PageRoutes.locationPage),
          ),
        ],
      ),
    );
  }
}
