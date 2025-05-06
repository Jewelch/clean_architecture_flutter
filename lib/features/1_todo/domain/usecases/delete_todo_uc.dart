import 'package:jch_requester/generic_requester.dart' show Either;

import '../../../../core/error/failures.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class DeleteTodoUC {
  final TodoRepository repository;

  DeleteTodoUC(this.repository);

  Future<Either<Failure, TodoEntity?>> execute(int id) async {
    return await repository.deleteTodo(id);
  }
}
