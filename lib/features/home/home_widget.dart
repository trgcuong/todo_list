import 'package:flutter/material.dart';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/generated/l10n.dart';

import 'home_bloc.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(BuildContext context, int index) {
    context.readBloc<HomeBloc>().addEvent(ChangCurrentPageHomeEvent(index));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocProvider(
      create: (context) => HomeBloc(),
      child: BaseBlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('To-do List'),
            ),
            body: Center(
            child: _widgetOptions.elementAt(state.currentPage)),
            bottomNavigationBar: _buildBottomNavigationBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, HomeState state) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.list_alt),
          label: S.of(context).incomplete,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.fact_check_outlined),
          label: S.of(context).complete,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.view_list_rounded),
          label: S.of(context).all,
        ),
      ],
      currentIndex: state.currentPage,
      onTap:(index) => _onItemTapped(context, index),
    );
  }
}
