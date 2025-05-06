import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class GetTodosUC {
  final TodoRepository repository;

  GetTodosUC(this.repository);

  Future<List<TodoEntity>> execute() async {
    return await repository.getTodos();
  }
}
