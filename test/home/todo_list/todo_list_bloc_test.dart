import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/app/app_exception.dart';
import 'package:todo_list/app/di.dart';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/data/model/task_model.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/features/home/todo_list/todo_list_bloc.dart';
import 'package:todo_list/features/home/todo_list/todo_list_widget.dart';

import '../../base.dart';
import 'todo_list_bloc_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late MockTaskRepository mockTaskRepository;
  late List<TaskModel> mockedTasks;
  late TaskModel newTask;
  late TodoListState initialState;
  late TodoListState firstLoadedState;
  late TodoListState completeState;
  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getIt.registerSingleton<TaskRepository>(FakeTaskRepository());
    mockedTasks = List<TaskModel>.from(
      [
        const TaskModel(content: 'task 1'),
        const TaskModel(content: 'task 2'),
      ],
      growable: true,
    );
    newTask = const TaskModel(content: 'task 3');
    initialState = const TodoListState(tasks: [], isLoading: true);
     firstLoadedState = TodoListState(
      isLoading: false,
      tasks: mockedTasks.reversed.toList(),
    );
     completeState = TodoListState(
      isLoading: false,
      tasks: [
        newTask,
        ...mockedTasks.reversed.toList(),
      ],
      isSubmitting: false,
    );

  });
  tearDown(() {
    getIt.unregister<TaskRepository>();
  });

  test('Init TodoListState', () {
    expect(
        TodoListBloc().state, const TodoListState(tasks: [], isLoading: true));
  });

  makeBlocTest<TodoListBloc, TodoListState>(
    'Load incomplete list',
    build: () => TodoListBloc(),
    act: (bloc) => bloc.add(InitialEvent()),
    expect: () => [
      const TodoListState(isLoading: true, tasks: []),
      const TodoListState(isLoading: false, tasks: [
        TaskModel(content: 'task 2'),
        TaskModel(content: 'task 1'),
      ]),
    ],
  );

  makeBlocTest<TodoListBloc, TodoListState>(
    'Load all list',
    build: () => TodoListBloc()..type = TodoListType.all,
    act: (bloc) => bloc.add(InitialEvent()),
    expect: () => [
      const TodoListState(isLoading: true, tasks: []),
      const TodoListState(isLoading: false, tasks: [
        TaskModel(content: 'task 3', isComplete: true),
        TaskModel(content: 'task 2'),
        TaskModel(content: 'task 1', isComplete: true),
      ]),
    ],
  );

  makeBlocTest<TodoListBloc, TodoListState>(
    'add a new task successfully',
    setUp: () {
      getIt.unregister<TaskRepository>();
      getIt.registerSingleton<TaskRepository>(mockTaskRepository);
    },
    build: () {
      when(mockTaskRepository.getIncompleteTasks())
          .thenAnswer((_) async => mockedTasks);
      when(mockTaskRepository.newTask(newTask)).thenAnswer((_) async {
        mockedTasks.add(newTask);
      });
      return TodoListBloc();
    },
    act: (bloc) {
      bloc.add(InitialEvent());

      bloc.add(AddTaskTodoListEvent('task 3'));
    },
    expect: () => [
      initialState,
      firstLoadedState,
      firstLoadedState.copyWith(isSubmitting: true),
      completeState.copyWith(isSubmitting: false),
      completeState.copyWith(isLoading: true),
      completeState.copyWith(isLoading: false),
    ],
  );

  makeBlocTest<TodoListBloc, TodoListState>(
    'add a new task unsuccessfully',
    setUp: () {
      getIt.unregister<TaskRepository>();
      getIt.registerSingleton<TaskRepository>(mockTaskRepository);
    },
    build: () {
      when(mockTaskRepository.getIncompleteTasks())
          .thenAnswer((_) async => mockedTasks);
      when(mockTaskRepository.newTask(newTask))
          .thenThrow(DatabaseException());
      return TodoListBloc();
    },
    act: (bloc) {
      bloc.add(InitialEvent());
      bloc.add(AddTaskTodoListEvent('task 3'));
    },
    expect: () => [
      initialState,
      firstLoadedState,
      firstLoadedState.copyWith(isSubmitting: true),
      firstLoadedState.copyWith(
          isSubmitting: false, error: DatabaseException()),
    ],
  );

  int taskIndex = 1; //index will be set complete
  makeBlocTest<TodoListBloc, TodoListState>(
    'set task 1 is complete successfully',
    setUp: () {
      getIt.unregister<TaskRepository>();
      getIt.registerSingleton<TaskRepository>(mockTaskRepository);
    },
    build: () {
      when(mockTaskRepository.getIncompleteTasks())
          .thenAnswer((_) async => mockedTasks);

      when(mockTaskRepository.updateTask(newTask)).thenAnswer((realInvocation) async{
        mockedTasks[taskIndex] =  mockedTasks[taskIndex].copyWith(isComplete: true);
      });
      return TodoListBloc();
    },
    act: (bloc) {
      bloc.add(InitialEvent());
      bloc.add(SetCompleteTaskListEvent(true, taskIndex));
    },
    expect: () => [
      initialState,
      firstLoadedState,
      firstLoadedState.copyWith(isLoading: false, tasks: [
        const TaskModel(content: 'task 2'),
        const TaskModel(content: 'task 1', isComplete: true),
      ]),
    ],
  );

}
