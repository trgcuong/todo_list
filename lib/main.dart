import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list/features/home/home_widget.dart';
import 'package:todo_list/resources/colors.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: ThemeData(
        primarySwatch: AppColors.blue,
      ),
      home: const HomeWidget(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeListResolutionCallback: (locales, supportedLocales) {
        for (Locale locale in locales!) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }
        }
        return S.delegate.supportedLocales[0];
      },
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
