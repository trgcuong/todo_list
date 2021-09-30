import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/features/home/home_bloc.dart';

void main() {
  group('HomeState support comparisons', () {
    test('Two instance', () {
      expect(const HomeState(), const HomeState());
    });

    test('Instance with currentPage: 1', () {
      expect(const HomeState(currentPage: 1), const HomeState(currentPage: 1));
    });

    test('Instance with state.copyWith()', () {
      const state = HomeState(currentPage: 1);
      expect(state , state.copyWith());
    });
    
  });
}