import 'package:flutter/material.dart';
import 'package:todo_list/features/home/home_widget.dart';
import 'package:todo_list/resources/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: ThemeData(
        primarySwatch: AppColors.blue,
      ),
      home: const HomeWidget(),
    );
  }
}
