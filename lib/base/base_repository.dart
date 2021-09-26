import 'package:isar/isar.dart';
import 'package:todo_list/app/di.dart';


class BaseLocalData{
  final isar = getIt.get<Isar>();
}