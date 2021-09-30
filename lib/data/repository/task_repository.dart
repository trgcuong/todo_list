import 'package:isar/isar.dart';
import 'package:todo_list/base/base_repository.dart';
import 'package:todo_list/data/database/task.dart';
import 'package:todo_list/data/model/task_model.dart';
import 'package:todo_list/isar.g.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getAllTasks();

  Future<List<TaskModel>> getIncompleteTasks();

  Future<List<TaskModel>> getCompleteTasks();

  Future<void> newTask(TaskModel task);

  Future<void> updateTask(TaskModel task);
}

class TaskDatabase extends BaseLocalData implements TaskRepository {
  TaskDatabase(Isar isar) : super(isar);

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return isar.taskModelDbs.where().findAll().then((tasks) => tasks
        .map((e) => TaskModel(
              id: e.id!,
              content: e.content,
              isComplete: e.isComplete,
            ))
        .toList());
  }

  @override
  Future<List<TaskModel>> getIncompleteTasks() async {
    return isar.taskModelDbs
        .where()
        .filter()
        .isCompleteEqualTo(false)
        .findAll()
        .then((tasks) => tasks
            .map((e) => TaskModel(
                  id: e.id!,
                  content: e.content,
                  isComplete: e.isComplete,
                ))
            .toList());
  }

  @override
  Future<List<TaskModel>> getCompleteTasks() async {
    return isar.taskModelDbs
        .where()
        .filter()
        .isCompleteEqualTo(true)
        .findAll()
        .then((tasks) => tasks
            .map((e) => TaskModel(
                  id: e.id!,
                  content: e.content,
                  isComplete: e.isComplete,
                ))
            .toList());
  }

  @override
  Future<void> newTask(TaskModel task) {
    return isar
        .writeTxn((isar) => isar.taskModelDbs.put(TaskModelDb.from(task)));
  }

  @override
  Future<void> updateTask(TaskModel task) {
    return isar
        .writeTxn((isar) => isar.taskModelDbs.put(TaskModelDb.from(task)));
  }
}

class FakeTaskRepository implements TaskRepository {
  @override
  Future<List<TaskModel>> getAllTasks() async {
    return [
      const TaskModel(content: 'task 1', isComplete: true),
      const TaskModel(content: 'task 2', isComplete: false),
      const TaskModel(content: 'task 3', isComplete: true)
    ];
  }

  @override
  Future<List<TaskModel>> getCompleteTasks() async {
    return [
      const TaskModel(content: 'task 1', isComplete: true),
      const TaskModel(content: 'task 2', isComplete: true)
    ];
  }

  @override
  Future<List<TaskModel>> getIncompleteTasks() async {
    return [
      const TaskModel(content: 'task 1'),
      const TaskModel(content: 'task 2'),
    ];
  }

  @override
  Future<void> newTask(TaskModel task) async {}

  @override
  Future<void> updateTask(TaskModel task) async {}
}
