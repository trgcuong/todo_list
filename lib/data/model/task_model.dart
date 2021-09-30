import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int? id;

  final String content;

  final bool isComplete;

  const TaskModel({
    this.id,
    required this.content,
    this.isComplete = false,
  });

  @override
  List<Object> get props => [
        if (id != null) id!,
        content,
        isComplete,
      ];



  @override
 // String toString() => 'TaskModel{content: $content}';
  String toString() => 'TaskModel{isComplete: $isComplete}';

  TaskModel copyWith({
    int? id,
    String? content,
    bool? isComplete,
  }) {
    return TaskModel(
      id: id ?? this.id,
      content: content ?? this.content,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
