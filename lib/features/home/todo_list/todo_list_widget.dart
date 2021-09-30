import 'package:flutter/material.dart';
import 'package:todo_list/app/app_exception.dart';
import 'package:todo_list/base/base_bloc.dart';
import 'package:todo_list/generated/l10n.dart';
import 'package:todo_list/utils/app_dialog.dart';
import 'package:todo_list/utils/common_widgets.dart';

import '../home_bloc.dart';
import 'todo_list_bloc.dart';

enum TodoListType { incomplete, complete, all }

class TodoListWidget extends StatefulWidget {
  final TodoListType type;

  const TodoListWidget({Key? key, required this.type}) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget>
    with AutomaticKeepAliveClientMixin {
  final bloc = TodoListBloc();

  final TextEditingController _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    bloc.type = widget.type;
    bloc.add(InitialEvent());
    _subscribeHomeState();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseBlocProvider(
      create: (context) => bloc,
      child: BaseBlocConsumer<TodoListBloc, TodoListState>(
        listener: (context, state) {
          //just show error from network with a known message
          if (state.error != null && state.error is NetworkException) {
            showError(context: context, error: state.error);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              if(widget.type == TodoListType.incomplete)
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.add_circle_outline),
                      hintText: S
                          .of(context)
                          .addANewTask,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (text) {
                      bloc.add(AddTaskTodoListEvent(text));
                      _textController.clear();
                    },
                  ),
                ),
              if(widget.type == TodoListType.incomplete)
                const Divider(),
              if (state.isLoading && state.tasks.isEmpty)
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
        child: Text(S
            .of(context)
            .youHaveNoTaskPleaseAddANewOne),
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

  @override
  bool get wantKeepAlive => true;

  void _subscribeHomeState() {
    context
        .readBloc<HomeBloc>()
        .stream
        .listen((state) {
      if ((state.currentPage == 0 && widget.type == TodoListType.incomplete) ||
          (state.currentPage == 1 && widget.type == TodoListType.complete) ||
          (state.currentPage == 0 && widget.type == TodoListType.all)){
        bloc.add(InitialEvent());
      }
    });
  }
}
