import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/delete_todo_uc.dart';
import '../../domain/usecases/get_todos_uc.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUC getTodosUC;
  final DeleteTodoUC deleteTodoUC;

  TodoBloc({required this.getTodosUC, required this.deleteTodoUC}) : super(const TodoInitialState()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(LoadTodosEvent event, Emitter<TodoState> emit) async {
    emit(const TodoLoadingState());

    try {
      final foundTodos = await getTodosUC.execute();

      foundTodos.fold(
        (failure) => emit(const TodoErrorState(errorMessage: 'Error loading todos')),
        (todos) => emit(TodoLoadedState(todos: todos)),
      );
    } catch (e) {
      emit(const TodoErrorState(errorMessage: 'Error loading todos'));
    }
  }

  Future<void> _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    // Todos must be loaded first
    if (state is! TodoLoadedState) return;

    final currentTodos = (state as TodoLoadedState).todos;

    // Make API call to delete the todo
    final deleteResult = await deleteTodoUC.execute(event.id);

    deleteResult.fold((failure) => emit(TodoErrorState(errorMessage: 'Error deleting todo: ${failure.toString()}')), (
      deletedTodo,
    ) {
      final updatedTodos = List<TodoEntity>.from(currentTodos)..removeWhere((todo) => todo.id == event.id);
      emit(TodoLoadedState(todos: updatedTodos));
    });
  }
}
