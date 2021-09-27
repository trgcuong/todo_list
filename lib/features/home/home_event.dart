part of 'home_bloc.dart';

abstract class HomeEvent extends BaseBlocEvent{}

class ChangCurrentPageHomeEvent extends HomeEvent{
  final int page;

  ChangCurrentPageHomeEvent(this.page);

}
