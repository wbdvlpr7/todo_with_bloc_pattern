import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'filter_model.dart';
import 'storage.dart';
import 'todo_model.dart';

part 'hive_db.g.dart';
part 'tables.dart';

class HiveDb implements LocalStorage {
  late Box<TodoBox> todoBox;

  late List<Box<HiveObject>> boxes;

  Future<HiveDb> init() async {
    await Hive.initFlutter();
    final appDir = await getApplicationDocumentsDirectory();
    debugPrint(appDir.toString());
    Hive.registerAdapter<TodoBox>(TodoBoxAdapter());
    todoBox = await Hive.openBox<TodoBox>('TodoBox');
    boxes = [todoBox];
    return this;
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    final existTodo =
        todoBox.values.singleWhereOrNull((element) => element.id == todo.id);
    if (existTodo != null) {
      existTodo.title = todo.title;
      existTodo.description = todo.description;
      existTodo.tags = todo.tags;
      return;
    }
    int id = 1;
    if (todoBox.values.isNotEmpty) {
      id = todoBox.values.map((e) => e.id).max + 1;
    }
    // debugPrint('TodoId: ${id.toString()}');
    await todoBox.add(TodoBox(
        id: id,
        title: todo.title,
        description: todo.description,
        tags: id.toString(),
        isCompleted: todo.isCompleted));
  }

  @override
  Future<void> deleteTodo(int id) async {
    final todo =
        todoBox.values.singleWhereOrNull((element) => element.id == id);
    if (todo != null) {
      await todoBox.delete(todo.key);
    }
  }

  @override
  Future<List<TodoModel>> getTodos(FilterModel filter) async {
    final result = todoBox.values
        .where((e) {
          return (filter.tags == null ||
                  filter.tags == '' ||
                  e.tags.contains(filter.tags!)) &&
              (filter.isCompleted == null ||
                  e.isCompleted == filter.isCompleted);
        })
        .skip(filter.pageKey)
        .take(filter.pageSize)
        .map((e) => TodoModel(
            id: e.id,
            title: e.title,
            description: e.description,
            tags: e.tags,
            isCompleted: e.isCompleted))
        .toList();
    // debugPrint('pageKey:' +
    //     filter.pageKey.toString() +
    //     ' / pageSize:' +
    //     filter.pageSize.toString() +
    //     ' / length:' +
    //     result.length.toString());
    return result;
  }

  @override
  Future<void> toggleCompleteTodo(int id) async {
    final todo =
        todoBox.values.singleWhereOrNull((element) => element.id == id);
    if (todo != null) {
      todo.isCompleted = !todo.isCompleted;
      todo.save();
    }
  }

  @override
  Future<void> deleteAllTodos() async {
    for (final fav in todoBox.values) {
      await todoBox.delete(fav.key);
    }
  }

  @override
  Future<int> inCompletedCount() async {
    return todoBox.values
        .where((element) => element.isCompleted == false)
        .length;
  }
////////////////////////////////////////////////////////////////
} //END Class
