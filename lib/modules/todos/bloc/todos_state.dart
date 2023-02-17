// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todos_bloc.dart';

enum TodosStatus { initial, loading, success, failure }

class TodosState extends Equatable {
  final TodosStatus status;
  final Failure? failure;
  final List<TodoModel> todos;
  final FilterModel filter;
  final int inCompletedCount;
  const TodosState({
    this.status = TodosStatus.initial,
    this.failure,
    this.todos = const <TodoModel>[],
    this.filter = const FilterModel(pageKey: 0, pageSize: 5),
    this.inCompletedCount = 0,
  });

  @override
  List<Object?> get props => [status, failure, todos, filter, inCompletedCount];

  @override
  bool get stringify => true;

  TodosState copyWith({
    TodosStatus? status,
    Failure? failure,
    List<TodoModel>? todos,
    FilterModel? filter,
    int? inCompletedCount,
  }) {
    return TodosState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      todos: todos ?? this.todos,
      filter: filter ?? this.filter,
      inCompletedCount: inCompletedCount ?? this.inCompletedCount,
    );
  }
}
