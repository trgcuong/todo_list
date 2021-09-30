import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list/features/home/home_widget.dart';
import 'package:todo_list/generated/l10n.dart';
import 'package:todo_list/resources/colors.dart';

import 'app_theme.dart';


class MyApp extends StatelessWidget {
  final Widget? home;

  const MyApp({Key? key, this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: AppTheme.light(),
      home: home ?? const HomeWidget(),
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