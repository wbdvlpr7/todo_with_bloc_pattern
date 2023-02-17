import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/loader.dart';
import '../../../data/storage/filter_model.dart';
import '../../../data/storage/todo_model.dart';
import '../bloc/todos_bloc.dart';
import '../widgets/todo_card.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  TextEditingController txtTag = TextEditingController();
  final PagingController<int, TodoModel> _pagingController =
      PagingController(firstPageKey: 0);

  FilterModel filter = const FilterModel(pageKey: 0, pageSize: 5);
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context
          .read<TodosBloc>()
          .add(SetTodosFilter(filter: filter.copyWith(pageKey: pageKey)));
      context.read<TodosBloc>().add(GetTodos());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TodosBloc, TodosState>(
          buildWhen: (previous, current) {
            return previous.inCompletedCount != current.inCompletedCount;
          },
          builder: (context, state) {
            return Text('Todos (${state.inCompletedCount.toString()})');
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.pushNamed('todo'),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              _pagingController.itemList = [];
              context.read<TodosBloc>().add(SetTodosFilter(
                  filter: filter.copyWith(
                      tags: null, pageKey: 0, isCompleted: null)));
              context.read<TodosBloc>().add(const DeleteAllTodos());
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Tags:'),
              Expanded(
                child: BlocBuilder<TodosBloc, TodosState>(
                  builder: (context, state) {
                    return TextFormField(
                      controller: txtTag,
                      onChanged: (value) {
                        _pagingController.itemList = [];
                        context.read<TodosBloc>().add(SetTodosFilter(
                            filter: state.filter
                                .copyWith(tags: value, pageKey: 0)));
                        context.read<TodosBloc>().add(GetTodos());
                      },
                    );
                  },
                ),
              ),
              BlocBuilder<TodosBloc, TodosState>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        _pagingController.itemList = [];
                        context.read<TodosBloc>().add(SetTodosFilter(
                            filter: filter.copyWith(
                                isCompleted:
                                    !(state.filter.isCompleted ?? false))));

                        context.read<TodosBloc>().add(GetTodos());
                      },
                      icon: Icon(state.filter.isCompleted == true
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank));
                },
              ),
              IconButton(
                  onPressed: () {
                    txtTag.text = '';
                    context.read<TodosBloc>().add(SetTodosFilter(
                        filter:
                            filter.copyWith(tags: null, isCompleted: null)));
                    _pagingController.itemList = [];
                    context.read<TodosBloc>().add(GetTodos());
                  },
                  icon: const Icon(Icons.clear_all)),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildListView(),
            ),
          ),
        ],
      ),
    );
  }

  buildListView() {
    return BlocListener<TodosBloc, TodosState>(
      listener: (context, state) {
        if (state.status == TodosStatus.loading) {
        } else if (state.status == TodosStatus.success) {
          final isLastPage = state.todos.length < state.filter.pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(state.todos);
          } else {
            final nextPageKey = state.filter.pageKey + state.todos.length;
            _pagingController.appendPage(state.todos, nextPageKey);
          }
        } else if (state.status == TodosStatus.failure) {
          _pagingController.error = state.failure?.message;
        }
      },
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, TodoModel>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<TodoModel>(
            // animateTransitions: true,
            newPageProgressIndicatorBuilder: (context) => const GLoader(),
            firstPageProgressIndicatorBuilder: (context) => const GLoader(),
            // transitionDuration: const Duration(milliseconds: 500),
            itemBuilder: (context, e, index) {
              return TodoCard(
                todo: e,
                index: index,
                pagingController: _pagingController,
                filter: filter,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
