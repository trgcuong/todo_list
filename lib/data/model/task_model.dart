class TaskModel {
  int id;

  String content;

  DateTime endTime;

  bool isComplete;
  TaskModel({
    this.id = 0,
    required this.content,
    this.isComplete = false,
    required this.endTime,
  }) {
    if (id <= 0 ) {
      id = DateTime.now().microsecondsSinceEpoch;
    }
  }
}
