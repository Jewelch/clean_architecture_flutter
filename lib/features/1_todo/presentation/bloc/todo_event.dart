import 'package:equatable/equatable.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

final class LoadTodosEvent extends TodoEvent {
  const LoadTodosEvent();
}

final class AddTodoEvent extends TodoEvent {
  final String title;

  const AddTodoEvent(this.title);

  @override
  List<Object?> get props => [title];
}

final class ToggleTodoEvent extends TodoEvent {
  final int id;

  const ToggleTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

final class DeleteTodoEvent extends TodoEvent {
  final int id;

  const DeleteTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}
