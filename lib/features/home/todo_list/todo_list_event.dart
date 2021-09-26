part of 'todo_list_bloc.dart';

@immutable
abstract class TodoListEvent {}

class AddTaskToDoListEvent extends TodoListEvent{
  final String content;

  AddTaskToDoListEvent(this.content);

}
@immutable
class InitialEvent extends TodoListEvent{}