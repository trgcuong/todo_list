class TaskModel {
  int id;

  String content;

  bool isComplete;
  TaskModel({
    this.id = 0,
    required this.content,
    this.isComplete = false,
  }) {
    if (id <= 0 ) {
      id = DateTime.now().microsecondsSinceEpoch;
    }
  }
}
