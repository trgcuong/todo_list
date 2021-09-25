part of 'todo_list_bloc.dart';

@immutable
 class TodoListState extends Equatable{
  final List<TaskModel> tasks;

  final bool isLoading;

  const TodoListState({this.isLoading = false,required this.tasks});

  @override
  List<Object?> get props => [isLoading, tasks.hashCode];

}

