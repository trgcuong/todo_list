import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/data/model/task_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super( TodoListState(tasks: List<TaskModel>.empty())) {
    on<TodoListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
