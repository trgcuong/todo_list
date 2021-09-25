part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final int currentPage;

  const HomeState({
    this.currentPage = 0,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [currentPage, isLoading];

  HomeState copyWith({
    bool? isLoading,
    int? currentPage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
