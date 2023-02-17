import '../data/storage/filter_model.dart';
import '../data/storage/storage.dart';
import '../data/storage/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getTodos(FilterModel filter);
  Future<void> deleteTodo(int id);
  Future<void> toggleCompleteTodo(int id);
  Future<void> addTodo(TodoModel todo);
  Future<void> deleteAllTodos();
  Future<int> inCompletedCount();
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this.storage);
  final LocalStorage storage;

  @override
  Future<void> addTodo(TodoModel todo) async {
    await storage.addTodo(todo);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await storage.deleteTodo(id);
  }

  @override
  Future<List<TodoModel>> getTodos(FilterModel filter) async {
    return await storage.getTodos(filter);
  }

  @override
  Future<void> toggleCompleteTodo(int id) async {
    await storage.toggleCompleteTodo(id);
  }

  @override
  Future<void> deleteAllTodos() async {
    await storage.deleteAllTodos();
  }

  @override
  Future<int> inCompletedCount() async {
    return storage.inCompletedCount();
  }
}
