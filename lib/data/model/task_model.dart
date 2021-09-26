class TaskModel {
  int? id;

  String content;

  bool isComplete;
  TaskModel({
    this.id,
    required this.content,
    this.isComplete = false,
  });

  @override
  String toString() {
    return 'TaskModel{id: $id, content: $content, isComplete: $isComplete}';
  }
}
