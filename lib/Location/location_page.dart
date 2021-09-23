import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'address_type_button.dart';

TextEditingController _addressController = TextEditingController();

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SetLocation();
  }
}

class SetLocation extends StatefulWidget {
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  bool isCard = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.cancel!),
        textTheme: Theme.of(context).textTheme,
        actions: [
          CustomButton(
            textColor: Theme.of(context).primaryColor,
            color: Theme.of(context).scaffoldBackgroundColor,
            textSize: 22,
          ),
        ],
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/map.png',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 36.0),
                            child: Image.asset('assets/map_pin.png', scale: 4),
                          ))
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).cardColor,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/map_pin.png', scale: 5),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          'Paris, France',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Spacer(),
                      isCard
                          ? InkWell(
                              child: Icon(
                                Icons.close,
                                size: 20,
                                color: Theme.of(context).hintColor,
                              ),
                              onTap: () {
                                setState(() {
                                  isCard = !isCard;
                                });
                              },
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                ),
                isCard ? SaveAddressCard() : Container(),
                CustomButton(onTap: () {
                  if (isCard == false) {
                    setState(() {
                      isCard = true;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                }),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

enum AddressType {
  Home,
  Office,
  Other,
}
AddressType selectedAddress = AddressType.Other;

class SaveAddressCard extends StatefulWidget {
  @override
  _SaveAddressCardState createState() => _SaveAddressCardState();
}

class _SaveAddressCardState extends State<SaveAddressCard> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: FadedSlideAnimation(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              locale.selectAddressType!,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AddressTypeButton(
                  label: AppLocalizations.of(context)!.home,
                  icon: Icons.home,
                  onPressed: () {
                    setState(() {
                      selectedAddress = AddressType.Home;
                    });
                  },
                  isSelected: selectedAddress == AddressType.Home,
                ),
                AddressTypeButton(
                  label: AppLocalizations.of(context)!.office,
                  icon: Icons.business,
                  onPressed: () {
                    setState(() {
                      selectedAddress = AddressType.Office;
                    });
                  },
                  isSelected: selectedAddress == AddressType.Office,
                ),
                AddressTypeButton(
                  label: AppLocalizations.of(context)!.other,
                  icon: Icons.assistant,
                  onPressed: () {
                    setState(() {
                      selectedAddress = AddressType.Other;
                    });
                  },
                  isSelected: selectedAddress == AddressType.Other,
                ),
              ],
            ),
            EntryField(
              controller: _addressController,
              label: locale.enterAddressDetails,
              hint: locale.address,
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
