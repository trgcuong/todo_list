part of 'todo_list_bloc.dart';

@immutable
abstract class TodoListEvent extends BaseBlocEvent {}

@immutable
class AddTaskTodoListEvent extends TodoListEvent{
  final String content;

  AddTaskTodoListEvent(this.content);

}
@immutable
class SetCompleteTaskListEvent extends TodoListEvent{
  final bool isChecked;
  final int index;

  SetCompleteTaskListEvent(this.isChecked, this.index);

  @override
  String toString() {
    return 'SetCompleteTaskListEvent{isChecked: $isChecked, index: $index}';
  }
}