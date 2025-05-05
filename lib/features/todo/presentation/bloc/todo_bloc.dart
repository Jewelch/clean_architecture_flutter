import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_todos_uc.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUC getTodosUC;

  TodoBloc({required this.getTodosUC}) : super(const TodoInitialState()) {
    on<LoadTodosEvent>(_onLoadTodos);
  }

  Future<void> _onLoadTodos(LoadTodosEvent event, Emitter<TodoState> emit) async {
    emit(const TodoLoadingState());

    try {
      final result = await getTodosUC.execute();
      result.isEmpty ? emit(const TodoLoadedState(todos: [])) : emit(TodoLoadedState(todos: result));
    } catch (e) {
      emit(const TodoErrorState(errorMessage: 'Error loading todos'));
    }
  }
}
