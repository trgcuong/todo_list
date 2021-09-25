import 'package:flutter/material.dart';
import 'package:todo_list/base/base_bloc.dart';

import 'todo_list_bloc.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseBlocProvider(
      create: (context) => TodoListBloc(),
      child: BaseBlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          return Container(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  _itemBuilder(context, index, state),
              itemCount: 10,//todo
            ),
          );
        },
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index, TodoListState state) {
    return ListTile(
      leading: Checkbox(
        onChanged: (bool? value) {},
        value: true,
      ),
      title: Text('Do something'),
    );
  }
}
