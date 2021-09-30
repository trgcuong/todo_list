import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<State> extends Bloc<BaseBlocEvent, State> {
  BaseBloc(State initialState) : super(initialState);

  @override
  void add(BaseBlocEvent event) {
    super.add(event);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(ErrorEvent(error));
    super.onError(error, stackTrace);
  }
}

abstract class BaseEmitter<State> extends Emitter<State> {}

abstract class BaseBlocEvent {}

class InitialEvent extends BaseBlocEvent {}

class ErrorEvent extends BaseBlocEvent {
  final dynamic error;

  ErrorEvent(this.error);
}

class BaseBlocConsumer<B extends BlocBase<S>, S> extends BlocConsumer<B, S> {
  const BaseBlocConsumer({
    Key? key,
    required Widget Function(BuildContext context, S state) builder,
    required void Function(BuildContext context, S state) listener,
    B? bloc,
    bool Function(S previous, S current)? buildWhen,
    bool Function(S previous, S current)? listenWhen,
  }) : super(
          key: key,
          builder: builder,
          listener: listener,
          bloc: bloc,
          buildWhen: buildWhen,
        );
}

class BaseBlocBuilder<B extends BlocBase<S>, S> extends BlocBuilder<B, S> {
  const BaseBlocBuilder({
    Key? key,
    required Widget Function(BuildContext context, S state) builder,
    B? bloc,
    bool Function(S previous, S current)? buildWhen,
  }) : super(
          key: key,
          bloc: bloc,
          buildWhen: buildWhen,
          builder: builder,
        );
}

class BaseBlocProvider<T extends BlocBase<Object?>> extends BlocProvider<T> {
  BaseBlocProvider({
    Key? key,
    required T Function(BuildContext context) create,
    Widget? child,
    bool? lazy,
  }) : super(key: key, create: create, child: child, lazy: lazy);

  BaseBlocProvider.value({
    Key? key,
    required T value,
    Widget? child,
  }) : super.value(key: key, child: child, value: value);
}

extension BlocExtension on BuildContext {
  T readBloc<T extends BaseBloc>() {
    return read<T>();
  }
  T watchBloc<T extends BaseBloc>() {
    return watch<T>();
  }
}
