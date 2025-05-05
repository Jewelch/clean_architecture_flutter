import 'package:equatable/equatable.dart';

import '../../domain/entities/todo_entity.dart';

sealed class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object?> get props => [];
}

final class TodoInitialState extends TodoState {
  const TodoInitialState();
}

final class TodoLoadingState extends TodoState {
  const TodoLoadingState();
}

final class TodoLoadedState extends TodoState {
  final List<TodoEntity> todos;

  const TodoLoadedState({required this.todos});

  TodoLoadedState copyWith({List<TodoEntity>? todos}) {
    return TodoLoadedState(todos: todos ?? this.todos);
  }

  @override
  List<Object?> get props => [todos];
}

final class TodoErrorState extends TodoState {
  final String errorMessage;

  const TodoErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
