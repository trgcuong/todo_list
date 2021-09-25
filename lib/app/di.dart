import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:todo_list/isar.g.dart';

final getIt = GetIt.instance;

class DependencyInjection{
 static Future<void> register() async {
    getIt.registerLazySingletonAsync<Isar>(() =>  openIsar());

  }
}
