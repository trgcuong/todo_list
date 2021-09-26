import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/isar.g.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> register() async {
    getIt.registerSingleton<Isar>(await openIsar());
    getIt.registerSingleton<TaskRepository>(TaskDatabase());
  }
}
