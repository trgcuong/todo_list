part of 'todo_list_bloc.dart';

@immutable
 class TodoListState extends Equatable{
  final List<TaskModel> tasks;

  final bool isLoading;
  final bool isSubmitting;

  const TodoListState({this.isLoading = false,required this.tasks, this.isSubmitting = false});

  @override
  List<Object?> get props => [isLoading, tasks.hashCode, isSubmitting];

  TodoListState copyWith({
    List<TaskModel>? tasks,
    bool? isLoading,
    bool? isSubmitting,
  }) {
    return TodoListState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? false,
      isSubmitting: isSubmitting ?? false,
    );
  }
}

