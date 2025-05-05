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
  Future<List<TodoEntity>> getTodos() async {
    try {
      if (connectivity.isConnected) {
        // Try to get from remote first
        final remoteTodos = await remoteDataSource.getTodos();
        // Save to local
        // Return as entities
        return remoteTodos.fold(
          (failure) => <TodoEntity>[],
          (todos) => todos?.todos?.map((model) => TodoEntity.fromModel(model)).toList() ?? <TodoEntity>[],
        );
      } else {
        // Try to get from local
        final localTodos = await localDataSource.getTodos();
        // Return as entities
        return localTodos.map((model) => TodoEntity.fromModel(model)).toList();
      }
    } catch (e) {
      rethrow;
    }
  }
}
