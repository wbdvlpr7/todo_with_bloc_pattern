import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'injection.dart';
import 'modules/todos/bloc/todos_bloc.dart';
import 'router.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodosBloc>(
      create: (context) => sl<TodosBloc>(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'ToDo',
          routerConfig: gRouter,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
