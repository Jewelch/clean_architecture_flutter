import '../../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> saveTodos(List<TodoModel> todos);
  Future<void> clearTodos();
  Future<void> removeTodo(int id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  // In-memory storage for this example
  List<TodoModel> _todos = [];

  @override
  Future<List<TodoModel>> getTodos() async {
    // In a real app, this would fetch from SharedPreferences, Hive, or SQLite
    return _todos;
  }

  @override
  Future<void> saveTodos(List<TodoModel> todos) async {
    // In a real app, this would save to local storage
    _todos = todos;
  }

  @override
  Future<void> clearTodos() async {
    // In a real app, this would clear the storage
    _todos = [];
  }

  @override
  Future<void> removeTodo(int id) async {
    // In a real app, this would remove the todo from local storage
    _todos.removeWhere((todo) => todo.id == id);
  }
}
