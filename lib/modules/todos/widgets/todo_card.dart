// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:todo_with_bloc_pattern/core/constants.dart';
import 'package:todo_with_bloc_pattern/data/storage/filter_model.dart';

import '../../../data/storage/todo_model.dart';
import '../bloc/todos_bloc.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.todo,
    required this.index,
    required this.pagingController,
    required this.filter,
  }) : super(key: key);
  final TodoModel todo;
  final int index;
  final PagingController<int, TodoModel> pagingController;
  final FilterModel filter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        shape: listTileShape,
        tileColor: index % 2 == 0
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5)
            : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
        title: Text(todo.title),
        subtitle: Text('${todo.description} [${todo.tags}]'),
        leading: IconButton(
          icon: todo.isCompleted == true
              ? const Icon(Icons.check_box_outlined)
              : const Icon(Icons.check_box_outline_blank_outlined),
          onPressed: () {
            pagingController.itemList = [];
            context.read<TodosBloc>().add(SetTodosFilter(filter: filter));
            context.read<TodosBloc>().add(ToggleCompleteTodo(todo.id));
          },
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            pagingController.itemList = [];
            context.read<TodosBloc>().add(SetTodosFilter(filter: filter));
            context.read<TodosBloc>().add(DeleteTodo(todo.id));
          },
        ),
        onTap: () => context.pushNamed('todo', extra: todo),
      ),
    );
  }
}
