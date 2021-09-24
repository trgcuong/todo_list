import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(State initialState) : super(initialState);
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
