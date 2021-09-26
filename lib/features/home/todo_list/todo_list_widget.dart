import 'package:flutter/material.dart';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/generated/l10n.dart';
import 'package:todo_list/utils/common_widgets.dart';

import 'todo_list_bloc.dart';

enum TodoListType { incomplete, complete, all }

class TodoListWidget extends StatefulWidget {
  final TodoListType type;

  const TodoListWidget({Key? key, required this.type}) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  final bloc = TodoListBloc();

  final TextEditingController _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    bloc.type = widget.type;
    bloc.add(InitialTodoListEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocProvider(
      create: (context) => bloc,
      child: BaseBlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.add_circle_outline),
                    hintText: S.of(context).addANewTask,
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (text) {
                    bloc.add(AddTaskTodoListEvent(text));
                    _textController.clear();
                  },
                ),
              ),
              const Divider(),
              if (state.isLoading)
                const Expanded(child: Center(child: LoadingView()))
              else if (state.tasks.isEmpty)
                _buildEmptyLayout(context)
              else
                _buildListTask(state),
            ],
          );
        },
      ),
    );
  }

  Expanded _buildListTask(TodoListState state) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index) => _itemBuilder(context, index, state),
          itemCount: state.tasks.length),
    );
  }

  Expanded _buildEmptyLayout(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(S.of(context).youHaveNoTaskPleaseAddANewOne),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index, TodoListState state) {
    final task = state.tasks[index];
    return ListTile(
      leading: Checkbox(
        onChanged: (bool? checked) {
          bloc.add(SetCompleteTaskListEvent(checked ?? false, index));
        },
        value: task.isComplete,
      ),
      title: Text(task.content),
    );
  }
}
