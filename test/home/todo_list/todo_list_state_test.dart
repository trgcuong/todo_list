import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/data/model/task_model.dart';
import 'package:todo_list/features/home/todo_list/todo_list_bloc.dart';

void main() {
  group('TodoListState support comparisons', () {
    final List<TaskModel> tasks = [
      const TaskModel(content: 'Task 1'),
      const TaskModel(content: 'Task 2'),
    ];
    test('Two instance', () {
      expect(const TodoListState(tasks: []), const TodoListState(tasks: []));
    });

    test('Instance with tasks', () {
      expect(TodoListState(tasks: tasks), TodoListState(tasks: tasks));
    });

    test('Instance with state.copyWith()', () {
      final state = TodoListState(tasks: tasks);
      expect(state, state.copyWith());
    });
  });
}
