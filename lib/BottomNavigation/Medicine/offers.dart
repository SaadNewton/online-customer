import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:flutter/material.dart';

class Offer {
  Offer(this.offerContent, this.offerCode);
  String? offerContent;
  String offerCode;
}

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<Offer> offers = [
      Offer(locale.offer1, 'GET50'),
      Offer(locale.offer2, 'ELECT3'),
      Offer(locale.offer3, 'BUY2G1'),
      Offer(locale.offer1, 'GET50'),
      Offer(locale.offer2, 'ELECT3'),
      Offer(locale.offer3, 'BUY2G1'),
      Offer(locale.offer1, 'GET50'),
      Offer(locale.offer2, 'ELECT3'),
      Offer(locale.offer3, 'BUY2G1'),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(locale.offers!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              return buildOfferCard(
                  context, offers[index].offerContent!, offers[index].offerCode);
            }),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Card buildOfferCard(
      BuildContext context, String offerContent, String offerCode) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: EdgeInsets.only(bottom: 8),
      color: Theme.of(context).cardColor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        title: Text(offerContent),
        trailing: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
            backgroundColor: Theme.of(context).dividerColor,
          ),
          onPressed: () {},
          child: Text(
            offerCode,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
