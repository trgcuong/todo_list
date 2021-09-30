
import 'package:equatable/equatable.dart';
import 'package:todo_list/base/base_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ChangCurrentPageHomeEvent>((event, emit) {
      int page = event.page;
      if(page <0 || page > 2) {
        page = 0;
      }
      emit(state.copyWith(currentPage: page));
    });
  }
}
