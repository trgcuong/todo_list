part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class ChangCurrentPageHomeEvent extends HomeEvent{
  final int page;

  ChangCurrentPageHomeEvent(this.page);

}
