import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/features/home/home_bloc.dart';

import '../base.dart';

void main() {
  test('Init HomeState', () {
    expect(HomeBloc().state, const HomeState());
  });

  makeBlocTest<HomeBloc, HomeState>('Change currentPage to 1',
      build: () {
        return HomeBloc();
      },
      act: (bloc) => bloc.add(ChangCurrentPageHomeEvent(1)),
      expect: () => [const HomeState(currentPage: 1)]);

  makeBlocTest<HomeBloc, HomeState>('Change currentPage to 2',
      build: () {
        return HomeBloc();
      },
      act: (bloc) => bloc.add(ChangCurrentPageHomeEvent(2)),
      expect: () => [const HomeState(currentPage: 2)]);

  makeBlocTest<HomeBloc, HomeState>('Change currentPage to 0',
      build: () {
        return HomeBloc();
      },
      act: (bloc) => bloc.add(ChangCurrentPageHomeEvent(0)),
      expect: () => [const HomeState(currentPage: 0)]);

  makeBlocTest<HomeBloc, HomeState>(
      'Change currentPage to 3, out of range, should reset to 0',
      build: () {
        return HomeBloc();
      },
      act: (bloc) => bloc.add(ChangCurrentPageHomeEvent(3)),
      expect: () => [const HomeState(currentPage: 0)]);
}
