import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Locale/locale.dart';

class SearchHistoryPage extends StatefulWidget {
  @override
  _SearchHistoryPageState createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: FadedSlideAnimation(
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 14, right: 14),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    hintText: locale.searchDoctors,
                    filled: true,
                    fillColor: Theme.of(context).backgroundColor,
                    prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
            Expanded(
                child: Container(
              color: Theme.of(context).backgroundColor,
              padding: const EdgeInsets.only(left: 12.0, top: 16, right: 12),
              margin: const EdgeInsets.only(top: 14),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.recentSearch!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).disabledColor),
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PageRoutes.listOfDoctorsPage);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locale.cardio!),
                              SizedBox(
                                height: 10,
                              ),
                              Text(locale.ophtha!),
                              SizedBox(
                                height: 10,
                              ),
                              Text(locale.derma!),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/search_experts.png',
                          scale: 2.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          locale.searchExpertInField!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).disabledColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
