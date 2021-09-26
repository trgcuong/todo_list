// ignore_for_file: unused_import, implementation_imports

import 'dart:ffi';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:isar/src/isar_native.dart';
import 'package:isar/src/query_builder.dart';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as p;
import 'data/database/task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

const _utf8Encoder = Utf8Encoder();

final _schema =
    '[{"name":"TaskModelDb","idProperty":"id","properties":[{"name":"id","type":3},{"name":"content","type":5},{"name":"isComplete","type":0}],"indexes":[],"links":[]}]';

Future<Isar> openIsar(
    {String name = 'isar',
    String? directory,
    int maxSize = 1000000000,
    Uint8List? encryptionKey}) async {
  final path = await _preparePath(directory);
  return openIsarInternal(
      name: name,
      directory: path,
      maxSize: maxSize,
      encryptionKey: encryptionKey,
      schema: _schema,
      getCollections: (isar) {
        final collectionPtrPtr = malloc<Pointer>();
        final propertyOffsetsPtr = malloc<Uint32>(3);
        final propertyOffsets = propertyOffsetsPtr.asTypedList(3);
        final collections = <String, IsarCollection>{};
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 0));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['TaskModelDb'] = IsarCollectionImpl<TaskModelDb>(
          isar: isar,
          adapter: _TaskModelDbAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 3),
          propertyIds: {'id': 0, 'content': 1, 'isComplete': 2},
          indexIds: {},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.id,
          setId: (obj, id) => obj.id = id,
        );
        malloc.free(propertyOffsetsPtr);
        malloc.free(collectionPtrPtr);

        return collections;
      });
}

Future<String> _preparePath(String? path) async {
  if (path == null || p.isRelative(path)) {
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, path ?? 'isar');
  } else {
    return path;
  }
}

class _TaskModelDbAdapter extends TypeAdapter<TaskModelDb> {
  @override
  int serialize(IsarCollectionImpl<TaskModelDb> collection, RawObject rawObj,
      TaskModelDb object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = value0;
    final value1 = object.content;
    final _content = _utf8Encoder.convert(value1);
    dynamicSize += _content.length;
    final value2 = object.isComplete;
    final _isComplete = value2;
    final size = dynamicSize + 19;

    late int bufferSize;
    if (existingBufferSize != null) {
      if (existingBufferSize < size) {
        malloc.free(rawObj.buffer);
        rawObj.buffer = malloc(size);
        bufferSize = size;
      } else {
        bufferSize = existingBufferSize;
      }
    } else {
      rawObj.buffer = malloc(size);
      bufferSize = size;
    }
    rawObj.buffer_length = size;
    final buffer = rawObj.buffer.asTypedList(size);
    final writer = BinaryWriter(buffer, 19);
    writer.writeLong(offsets[0], _id);
    writer.writeBytes(offsets[1], _content);
    writer.writeBool(offsets[2], _isComplete);
    return bufferSize;
  }

  @override
  TaskModelDb deserialize(IsarCollectionImpl<TaskModelDb> collection,
      BinaryReader reader, List<int> offsets) {
    final object = TaskModelDb();
    object.id = reader.readLongOrNull(offsets[0]);
    object.content = reader.readString(offsets[1]);
    object.isComplete = reader.readBool(offsets[2]);
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension GetCollection on Isar {
  IsarCollection<TaskModelDb> get taskModelDbs {
    return getCollection('TaskModelDb');
  }
}

extension TaskModelDbQueryWhereSort on QueryBuilder<TaskModelDb, QWhere> {
  QueryBuilder<TaskModelDb, QAfterWhere> anyId() {
    return addWhereClause(WhereClause(indexName: 'id'));
  }
}

extension TaskModelDbQueryWhere on QueryBuilder<TaskModelDb, QWhereClause> {}

extension TaskModelDbQueryFilter
    on QueryBuilder<TaskModelDb, QFilterCondition> {
  QueryBuilder<TaskModelDb, QAfterFilterCondition> idIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> idEqualTo(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> idGreaterThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> idLessThan(int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> idBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'id',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> contentEqualTo(String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> contentStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'content',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> contentEndsWith(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'content',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> contentContains(String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'content',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'content',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TaskModelDb, QAfterFilterCondition> isCompleteEqualTo(
      bool value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'isComplete',
      value: value,
    ));
  }
}

extension TaskModelDbQueryLinks on QueryBuilder<TaskModelDb, QFilterCondition> {
}

extension TaskModelDbQueryWhereSortBy on QueryBuilder<TaskModelDb, QSortBy> {
  QueryBuilder<TaskModelDb, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> sortByContent() {
    return addSortByInternal('content', Sort.Asc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> sortByContentDesc() {
    return addSortByInternal('content', Sort.Desc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> sortByIsComplete() {
    return addSortByInternal('isComplete', Sort.Asc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> sortByIsCompleteDesc() {
    return addSortByInternal('isComplete', Sort.Desc);
  }
}

extension TaskModelDbQueryWhereSortThenBy
    on QueryBuilder<TaskModelDb, QSortThenBy> {
  QueryBuilder<TaskModelDb, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.Asc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.Desc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> thenByContent() {
    return addSortByInternal('content', Sort.Asc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> thenByContentDesc() {
    return addSortByInternal('content', Sort.Desc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> thenByIsComplete() {
    return addSortByInternal('isComplete', Sort.Asc);
  }

  QueryBuilder<TaskModelDb, QAfterSortBy> thenByIsCompleteDesc() {
    return addSortByInternal('isComplete', Sort.Desc);
  }
}

extension TaskModelDbQueryWhereDistinct
    on QueryBuilder<TaskModelDb, QDistinct> {
  QueryBuilder<TaskModelDb, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<TaskModelDb, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('content', caseSensitive: caseSensitive);
  }

  QueryBuilder<TaskModelDb, QDistinct> distinctByIsComplete() {
    return addDistinctByInternal('isComplete');
  }
}

extension TaskModelDbQueryProperty
    on QueryBuilder<TaskModelDb, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> idProperty() {
    return addPropertyName('id');
  }

  QueryBuilder<String, QQueryOperations> contentProperty() {
    return addPropertyName('content');
  }

  QueryBuilder<bool, QQueryOperations> isCompleteProperty() {
    return addPropertyName('isComplete');
  }
}
