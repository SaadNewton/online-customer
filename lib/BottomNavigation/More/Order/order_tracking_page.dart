import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';

class OrderTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.orderTrack!,
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/map1.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/ProfilePics/dp5.png'),
                  ),
                ),
              ),
              title: Text('George Adnerson'),
              subtitle: Text(locale.deliveryPartner!),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).dividerColor,
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.phone, color: kMainColor),
                      label: Text(
                        locale.call!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: kMainColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PageRoutes.chatWithDelivery);
                      },
                      icon: Icon(
                        Icons.chat,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      label: Text(
                        locale.chat!,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: kMainColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
