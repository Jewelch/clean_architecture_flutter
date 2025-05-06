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
    // Get current state to work with current todos list
    if (state is TodoLoadedState) {
      final currentTodos = (state as TodoLoadedState).todos;

      // Optimistically remove the todo from UI immediately
      final updatedTodos = List<TodoEntity>.from(currentTodos)..removeWhere((todo) => todo.id == event.id);

      emit(TodoLoadedState(todos: updatedTodos));

      try {
        // Make API call to delete the todo
        await deleteTodoUC.execute(event.id);
      } catch (e) {
        // If there was an error, restore the original state
        emit(TodoLoadedState(todos: currentTodos));
        emit(TodoErrorState(errorMessage: 'Error deleting todo: ${e.toString()}'));

        // Re-emit the loaded state so the UI continues to show todos
        emit(TodoLoadedState(todos: currentTodos));
      }
    }
  }
}
