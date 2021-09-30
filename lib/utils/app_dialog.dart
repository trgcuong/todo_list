import 'package:flutter/material.dart';
import 'package:todo_list/generated/l10n.dart';


Future<void> showError({required BuildContext context, required dynamic error}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.of(context).error),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(error.toString()),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(S.of(context).close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
