import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/app/application.dart';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/features/home/home_bloc.dart';
import 'package:todo_list/features/home/home_widget.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  late MockHomeBloc mockHomeBloc;
  late PageController pageController;
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
  });
  setUp(() {
    mockHomeBloc = MockHomeBloc();
    pageController =  PageController(initialPage: 0);
  });

  testWidgets('First load HomeWidget', (widgetTester) async {
    when(() => mockHomeBloc.state).thenReturn(const HomeState(currentPage: 0));
    await widgetTester.pumpWidget(MyApp(
      home: BaseBlocProvider.value(
        value: mockHomeBloc,
        child: HomePageView(pageController: pageController),
      ),
    ));
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
