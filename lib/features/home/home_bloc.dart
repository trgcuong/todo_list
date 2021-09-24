
import 'package:equatable/equatable.dart';
import 'package:todo_list/base/base_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
