import 'package:isar/isar.dart';
import 'package:todo_list/data/model/task_model.dart';

@Collection()
class TaskModelDb {
  int? id;

  String content = "";

  bool isComplete = false;

  TaskModelDb();

  factory TaskModelDb.from(TaskModel model) {
    return TaskModelDb.create(
      id: model.id,
      content: model.content,
      isComplete: model.isComplete,
    );
  }

  TaskModelDb.create({
    this.id,
    this.content = "",
    this.isComplete = false,
  });
}
