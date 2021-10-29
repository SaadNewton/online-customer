import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/get_all_labs_model.dart';
import 'package:doctoworld_user/data/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final SingleLabData? labDetail;
  About({this.labDetail});
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Wrap(
      children: [
        Divider(thickness: 8),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 20, bottom: 20, right: 20),
          child: Column(
            children: [
              /// owner name
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // direction: Axis.horizontal,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Owner :',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 18, height: 2),
                  ),
                  Text(
                    labDetail!.ownerName!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, height: 2, color: Colors.grey),
                  ),
                ],
              ),

              /// owner email
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // direction: Axis.horizontal,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Email :',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 18, height: 2),
                  ),
                  Text(
                    labDetail!.email!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, height: 2, color: Colors.grey),
                  ),
                ],
              ),

              /// sample fee
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // direction: Axis.horizontal,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sample Fee :',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 18, height: 2),
                  ),
                  Text(
                    labDetail!.homeSamplingFees.toString()
                        ??'0.00',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, height: 2, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
