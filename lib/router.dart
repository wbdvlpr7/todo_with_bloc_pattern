import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'data/storage/todo_model.dart';
import 'modules/todos/views/todo_page.dart';
import 'modules/todos/views/todos_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter gRouter = GoRouter(
  initialLocation: '/todos',
  navigatorKey: _rootNavigatorKey,
  // errorBuilder: (context, state) => ErrorPage(state.error.toString()),
  redirect: (context, state) async {
    if (state.location.isEmpty) {
      return '/search';
    }
    return null;
    // if (await LoginService.of(context).isLoggedIn) {
    //   return null;
    // }
    // return '/login';
  },
  routes: [
    GoRoute(
      name: 'todos',
      path: '/todos',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const TodosPage(),
      ),
    ),
    GoRoute(
      name: 'todo',
      path: '/todo',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: TodoPage(todo: state.extra as TodoModel?),
      ),
    ),
  ],
);
