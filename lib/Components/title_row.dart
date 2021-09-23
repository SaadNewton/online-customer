import 'package:doctoworld_user/Locale/locale.dart';
import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  final String? title;
  final Function? onTap;

  TitleRow(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsetsDirectional.only(start: 20.0),
      title: Text(
        title!,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Theme.of(context).disabledColor),
      ),
      trailing: onTap != null
          ? TextButton(
              onPressed: onTap as void Function()?,
              child: Text(
                AppLocalizations.of(context)!.viewAll!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
