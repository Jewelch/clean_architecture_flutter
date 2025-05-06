import 'package:jch_requester/generic_requester.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/managers/connectivity_manager.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasource/local/todo_local_datasource.dart';
import '../datasource/remote/todo_remote_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;
  final ConnecetivityManager connectivity;

  TodoRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.connectivity});

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodos() async {
    if (connectivity.isConnected) {
      try {
        final todosResponse = await remoteDataSource.getTodos();
        if (todosResponse?.todos == null) return Right([]);

        // Save to local
        localDataSource.saveTodos(todosResponse!.todos!);

        // Map Models to Entities
        final todos = todosResponse.todos!.map((model) => TodoEntity.fromModel(model)).toList();

        // Return as entities
        return Right(todos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTodos = await localDataSource.getTodos();
        return Right(localTodos.map((model) => TodoEntity.fromModel(model)).toList());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTodo(int id) async {
    if (!connectivity.isConnected) {
      // Cannot delete without internet connection
      return Left(ServerFailure());
    }

    try {
      final todoResult = await remoteDataSource.deleteTodo(id);

      if (todoResult == null || todoResult.success == false) return const Right(false);

      // Also remove from local cache
      await localDataSource.removeTodo(id);

      // Signals success
      return Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
