import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/app/app_log.dart';
import 'package:todo_list/app/di.dart';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/data/model/task_model.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/features/home/todo_list/todo_list_widget.dart';

part 'todo_list_event.dart';

part 'todo_list_state.dart';

class TodoListBloc extends BaseBloc<TodoListState> {
  late TodoListType type;

  TodoListBloc()
      : super(TodoListState(tasks: List<TaskModel>.empty(), isLoading: true)) {
    on<InitialEvent>((event, emit) async {
      await _initialData(emit);
    });
    on<AddTaskTodoListEvent>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      final task = TaskModel(content: event.content);
      await getIt.get<TaskRepository>().newTask(task);
      final newTasks = List<TaskModel>.from(state.tasks)..insert(0, task);
      AppLog.d(task);
      emit(state.copyWith(tasks: newTasks));
      await _initialData(emit); // reload data
    });
    on<SetCompleteTaskListEvent>((event, emit) async {
      final newTasks = List<TaskModel>.from(state.tasks);
      final task = newTasks[event.index];
      task.isComplete = event.isChecked;
      AppLog.d(task);
      emit(state.copyWith(tasks: newTasks));
      await getIt.get<TaskRepository>().updateTask(task);
    });

  }

  Future<void> _initialData(Emitter<TodoListState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<TaskModel> tasks;
    if (type == TodoListType.incomplete) {
      tasks = await getIt.get<TaskRepository>().getIncompleteTasks();
    } else if (type == TodoListType.complete) {
      tasks = await getIt.get<TaskRepository>().getCompleteTasks();
    } else {
      tasks = await getIt.get<TaskRepository>().getAllTasks();
    }
    tasks = tasks.reversed.toList();
    emit(state.copyWith(tasks: List<TaskModel>.from(tasks)));
  }
}
