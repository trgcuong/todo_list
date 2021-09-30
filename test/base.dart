import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

@isTest
void makeBlocTest<B extends BlocBase<State>, State>(
  String description, {
  FutureOr<void> Function()? setUp,
  required B Function() build,
  State Function()? seed,
  Function(B bloc)? act,
  Duration? wait,
  int skip = 0,
  dynamic Function()? expect,
  Function(B bloc)? verify,
  dynamic Function()? errors,
  FutureOr<void> Function()? tearDown,
}) {
  blocTest(
    description,
    setUp: setUp,
    build: build,
    seed: seed,
    act: act,
    wait: wait,
    skip: skip,
    expect: expect,
    verify: verify,
    errors: errors,
    tearDown: tearDown,
  );
}
