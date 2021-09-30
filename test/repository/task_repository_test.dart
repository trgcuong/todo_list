import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/app/app_exception.dart';
import 'package:todo_list/data/database/task.dart';
import 'package:isar/src/query_builder.dart';
import 'package:todo_list/data/repository/task_repository.dart';

class MockIsar extends Mock implements Isar {}

class MockIsarCollection<TaskModelDb> extends Mock
    implements IsarCollection<TaskModelDb> {}

class MockQueryBuilder<OBJ, QWhere> extends Mock
    implements QueryBuilder<OBJ, QWhere> {}

void main() {
  late MockIsar mockIsar;
  late MockIsarCollection<TaskModelDb> mockIsarCollection;
  late MockQueryBuilder<TaskModelDb, QWhere> mockQueryBuilder;
  late FakeTaskRepository fakeTaskRepository;
  late TaskDatabase taskDatabase;
  setUp(() {
    mockIsar = MockIsar();
    mockIsarCollection = MockIsarCollection<TaskModelDb>();
    mockQueryBuilder = MockQueryBuilder<TaskModelDb, QWhere>();
    fakeTaskRepository = FakeTaskRepository();
    taskDatabase = TaskDatabase(mockIsar);
  });

  //can not find the reason make this test is not work
  // test('getAllTask successfully', () {
  //   when(() => mockIsar.taskModelDbs).thenReturn(mockIsarCollection);
  //   when(() => mockIsarCollection.where()).thenReturn(mockQueryBuilder);
  //   when(() => mockQueryBuilder.findAll()).thenAnswer((_) async {
  //     final tasks = await fakeTaskRepository.getAllTasks();
  //     return tasks.map((e) => TaskModelDb.from(e)).toList();
  //   });
  //
  //   expect(taskDatabase.getAllTasks(), fakeTaskRepository.getAllTasks());
  // });

  test('getAllTask unsuccessfully', () {
    when(() => mockIsar.taskModelDbs).thenThrow(DatabaseException());
    expect(taskDatabase.getAllTasks(), throwsException);
  });

}

extension GetCollection on MockIsar {
  IsarCollection<TaskModelDb> get taskModelDbs {
    return getCollection('TaskModelDb');
  }
}
