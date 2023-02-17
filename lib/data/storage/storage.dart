import 'filter_model.dart';
import 'todo_model.dart';

abstract class LocalStorage {
  Future<List<TodoModel>> getTodos(FilterModel filter);
  Future<void> deleteTodo(int id);
  Future<void> deleteAllTodos();
  Future<void> toggleCompleteTodo(int id);
  Future<void> addTodo(TodoModel todo);
  Future<int> inCompletedCount();
}
