import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:flutter/material.dart';

class ReviewOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(locale.reviewOrder!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(bottom: 16),
                        title: Text(
                          'Well Life Store',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Theme.of(context).disabledColor),
                        ),
                        subtitle: Text(
                          'Salospir 100mg\nTablet',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        trailing: FadedScaleAnimation(
                          Image.asset('assets/Medicines/11.png'),
                          durationInMilliseconds: 400,
                        ),
                      ),
                      Text(
                        locale.overallExp!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Theme.of(context).disabledColor),
                      ),
                      Container(
                        height: 56,
                        child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, iconIndex) => Icon(
                            Icons.star,
                            size: 48,
                            color: inProcessColor,
                          ),
                        ),
                      ),
                      EntryField(
                        label: locale.addFeedback,
                        hint: locale.writeYourFeedback,
                        maxLines: 4,
                      ),
                      SizedBox(height: 16),
                      CustomButton(label: locale.submit)
                    ],
                  ),
                )),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
