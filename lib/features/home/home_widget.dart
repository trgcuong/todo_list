import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/features/home/todo_list/todo_list_widget.dart';
import 'package:todo_list/generated/l10n.dart';

import 'home_bloc.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
 final PageController _pageController = PageController(initialPage: 0);
  void _onItemTapped(BuildContext context, int index) {
    context.readBloc<HomeBloc>().add(ChangCurrentPageHomeEvent(index));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocProvider(
      create: (context) => HomeBloc(),
      child: BaseBlocConsumer<HomeBloc, HomeState>(
        listener: (context, state){
          _pageController.jumpToPage(state.currentPage);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: PageView(
              controller: _pageController ,
              children: const [
                TodoListWidget(type: TodoListType.incomplete,),
                TodoListWidget(type: TodoListType.complete,),
                TodoListWidget(type: TodoListType.all,),
              ],
            ),
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
