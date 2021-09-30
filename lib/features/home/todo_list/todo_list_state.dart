part of 'todo_list_bloc.dart';

@immutable
class TodoListState extends Equatable {
  final List<TaskModel> tasks;
  final dynamic error;
  final bool isLoading;
  final bool isSubmitting;

  const TodoListState({
    this.isLoading = false,
    required this.tasks,
    this.isSubmitting = false,
    this.error,
  });

  @override
  List<Object?> get props => [isLoading, tasks, isSubmitting, error];

  TodoListState copyWith({
    List<TaskModel>? tasks,
    bool? isLoading,
    bool? isSubmitting,
    dynamic error,
  }) {
    return TodoListState(
        tasks: tasks ?? this.tasks,
        isLoading: isLoading ?? false,
        isSubmitting: isSubmitting ?? false,
        error: error);
  }
}
