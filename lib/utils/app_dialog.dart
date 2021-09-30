import 'package:flutter/material.dart';
import 'package:todo_list/generated/l10n.dart';

Future<void> showError({
  required BuildContext context,
  required dynamic error,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AppAlertDialog(message: error.toString());
    },
  );
}

class AppAlertDialog extends StatelessWidget {
  final String message;

  const AppAlertDialog({Key? key, this.message = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('S.of(context).error'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(message),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('S.of(context).close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
