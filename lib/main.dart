import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/app/config.dart';
import 'package:todo_list/app/di.dart';

import 'app/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.register();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
