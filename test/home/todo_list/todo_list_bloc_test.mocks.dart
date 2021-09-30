// Mocks generated by Mockito 5.0.15 from annotations
// in todo_list/test/home/todo_list/todo_list_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_list/data/model/task_model.dart' as _i4;
import 'package:todo_list/data/repository/task_repository.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [TaskRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskRepository extends _i1.Mock implements _i2.TaskRepository {
  MockTaskRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.TaskModel>> getAllTasks() =>
      (super.noSuchMethod(Invocation.method(#getAllTasks, []),
              returnValue: Future<List<_i4.TaskModel>>.value(<_i4.TaskModel>[]))
          as _i3.Future<List<_i4.TaskModel>>);
  @override
  _i3.Future<List<_i4.TaskModel>> getIncompleteTasks() =>
      (super.noSuchMethod(Invocation.method(#getIncompleteTasks, []),
              returnValue: Future<List<_i4.TaskModel>>.value(<_i4.TaskModel>[]))
          as _i3.Future<List<_i4.TaskModel>>);
  @override
  _i3.Future<List<_i4.TaskModel>> getCompleteTasks() =>
      (super.noSuchMethod(Invocation.method(#getCompleteTasks, []),
              returnValue: Future<List<_i4.TaskModel>>.value(<_i4.TaskModel>[]))
          as _i3.Future<List<_i4.TaskModel>>);
  @override
  _i3.Future<void> newTask(_i4.TaskModel? task) =>
      (super.noSuchMethod(Invocation.method(#newTask, [task]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> updateTask(_i4.TaskModel? task) =>
      (super.noSuchMethod(Invocation.method(#updateTask, [task]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  String toString() => super.toString();
}