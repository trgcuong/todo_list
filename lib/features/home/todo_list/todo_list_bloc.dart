import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/app/di.dart';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/data/model/task_model.dart';
import 'package:todo_list/data/repository/task_repository.dart';

part 'todo_list_event.dart';

part 'todo_list_state.dart';

class TodoListBloc extends BaseBloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState(tasks: List<TaskModel>.empty())) {
    on<InitialEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final tasks = await getIt.get<TaskRepository>().getAllTasks();
      emit(state.copyWith(tasks: List<TaskModel>.from(tasks)));
    });
    on<AddTaskToDoListEvent>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      final task = TaskModel(content: event.content);
      await getIt.get<TaskRepository>().newTask(task);
      final newTasks = List<TaskModel>.from(state.tasks)..insert(0, task);
      emit(state.copyWith(tasks: newTasks));
    });
  }
}
