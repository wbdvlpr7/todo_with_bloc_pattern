import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failures.dart';
import '../../../data/storage/filter_model.dart';
import '../../../data/storage/todo_model.dart';
import '../../../repositories/todo_repo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodoRepository repo;
  TodosBloc(this.repo) : super(const TodosState()) {
    on<GetTodos>(_getTodos);
    on<DeleteTodo>(_deleteTodo);
    on<DeleteAllTodos>(_deleteAllTodos);
    on<ToggleCompleteTodo>(_toggleCompleteTodo);
    on<AddTodo>(_addTodo);
    on<SetTodosFilter>(_setTodosFilter);
  }

  FutureOr<void> _getTodos(GetTodos event, Emitter<TodosState> emit) async {
    emit(state.copyWith(status: TodosStatus.loading, todos: []));
    final todos = await repo.getTodos(state.filter);
    final inCompletedCount = await repo.inCompletedCount();
    emit(state.copyWith(
        status: TodosStatus.success,
        todos: todos,
        inCompletedCount: inCompletedCount));
  }

  FutureOr<void> _deleteTodo(DeleteTodo event, Emitter<TodosState> emit) async {
    await repo
        .deleteTodo(event.id)
        .whenComplete(() => _getTodos(GetTodos(), emit));
  }

  Future<void> _deleteAllTodos(
      DeleteAllTodos event, Emitter<TodosState> emit) async {
    await repo.deleteAllTodos().whenComplete(() => _getTodos(GetTodos(), emit));
  }

  FutureOr<void> _toggleCompleteTodo(
      ToggleCompleteTodo event, Emitter<TodosState> emit) async {
    await repo
        .toggleCompleteTodo(event.id)
        .whenComplete(() => _getTodos(GetTodos(), emit));
  }

  Future<void> _addTodo(AddTodo event, Emitter<TodosState> emit) async {
    await repo.addTodo(event.todo);
  }

  FutureOr<void> _setTodosFilter(
      SetTodosFilter event, Emitter<TodosState> emit) {
    emit(state.copyWith(filter: event.filter, todos: []));
  }
}
