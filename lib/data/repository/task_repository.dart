import 'package:isar/isar.dart';
import 'package:todo_list/app/di.dart';
import 'package:todo_list/base/base_repository.dart';
import 'package:todo_list/data/database/task.dart';
import 'package:todo_list/data/model/task_model.dart';
import 'package:todo_list/isar.g.dart';

abstract class TaskRepository {
  Future<List> getAllTasks();
  Future<void> newTask(TaskModel task);
}

class TaskDatabase extends BaseLocalData implements TaskRepository{
  final isar = getIt.get<Isar>();
  @override
  Future<List> getAllTasks() async {
   return isar.taskModelDbs.where().findAll();
  }

  @override
  Future<void> newTask(TaskModel task) {
    return isar.taskModelDbs.put(TaskModelDb.from(task));
  }

}