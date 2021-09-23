import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/reminder_card_model.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';

class PillReminderPage extends StatelessWidget {
  final List<PillReminderModel> pillReminders = [
    PillReminderModel('Multi Vitamins', 'Mon, Tues, Wed', '08:00 am, 02:00 pm'),
    PillReminderModel(
      'Diabetes Pills',
      'Mon, Tues, Wed, Thurs, Fri, Sat, Sun',
      '08:00 am, 02:00 pm, 08:00 pm',
    ),
    PillReminderModel('Multi Vitamins', 'Mon, Tues, Wed', '08:00 am, 02:00 pm'),
    PillReminderModel('Diabetes Pills', 'Mon, Tues, Wed', '08:00 am, 02:00 pm'),
  ];
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          locale.pillReminder!,
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        ListView.builder(
          itemCount: pillReminders.length,
          itemBuilder: (context, index) => Column(
            children: [
              SizedBox(height: 6),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                tileColor: Theme.of(context).scaffoldBackgroundColor,
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).dividerColor,
                  foregroundColor: Theme.of(context).primaryColor,
                  radius: 28,
                  child: Icon(Icons.notifications_active),
                ),
                title: Text(pillReminders[index].medicine),
                subtitle: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.caption,
                    children: [
                      TextSpan(text: pillReminders[index].days + '\n'),
                      TextSpan(
                        text: pillReminders[index].timings,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Theme.of(context).hintColor, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, PageRoutes.createPillReminder),
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
