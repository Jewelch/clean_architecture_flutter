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
        final todosResponse = await remoteDataSource.getTodos();

        if (todosResponse?.todos != null) return [];

        // Save to local
        await localDataSource.saveTodos(todosResponse!.todos!);
        // Return as entities
        return todosResponse.todos!.map((model) => TodoEntity.fromModel(model)).toList();
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
