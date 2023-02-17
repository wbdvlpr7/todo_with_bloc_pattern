// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

class GetTodos extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class DeleteTodo extends TodosEvent {
  final int id;
  const DeleteTodo(
    this.id,
  );
  @override
  List<Object?> get props => [id];
}

class DeleteAllTodos extends TodosEvent {
  const DeleteAllTodos();
  @override
  List<Object?> get props => [];
}

class ToggleCompleteTodo extends TodosEvent {
  final int id;
  const ToggleCompleteTodo(
    this.id,
  );
  @override
  List<Object?> get props => [id];
}

class AddTodo extends TodosEvent {
  final TodoModel todo;
  const AddTodo(
    this.todo,
  );
  @override
  List<Object?> get props => [todo];
}

class SetTodosFilter extends TodosEvent {
  final FilterModel filter;
  const SetTodosFilter({
    required this.filter,
  });

  @override
  List<Object> get props => [filter];
}

class GetInCompletedCount extends TodosEvent {
  const GetInCompletedCount();
  @override
  List<Object> get props => [];
}
