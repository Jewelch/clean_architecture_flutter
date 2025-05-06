import 'package:jch_requester/generic_requester.dart' show Either;

import '../../../../core/error/failures.dart';
import '../entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoEntity>>> getTodos();
  Future<Either<Failure, bool>> deleteTodo(int id);
}
