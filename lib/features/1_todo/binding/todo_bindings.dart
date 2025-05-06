import '../../../main.dart';
import '../data/datasource/local/todo_local_datasource.dart';
import '../data/datasource/remote/todo_remote_datasource.dart';
import '../data/repositories/todo_repository_impl.dart';
import '../domain/repositories/todo_repository.dart';
import '../domain/usecases/delete_todo_uc.dart';
import '../domain/usecases/get_todos_uc.dart';
import '../presentation/bloc/todo_bloc.dart';

void injectTodosBindings() {
  try {
    // For singletons, use registerLazySingleton or check if already registered
    if (!sl.isRegistered<GetTodosUC>()) {
      sl.registerLazySingleton(() => GetTodosUC(sl()));
    }

    if (!sl.isRegistered<DeleteTodoUC>()) {
      sl.registerLazySingleton(() => DeleteTodoUC(sl()));
    }

    if (!sl.isRegistered<TodoRepository>()) {
      sl.registerLazySingleton<TodoRepository>(
        () => TodoRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), connectivity: sl()),
      );
    }

    if (!sl.isRegistered<TodoRemoteDataSource>()) {
      sl.registerLazySingleton<TodoRemoteDataSource>(() => TodoRemoteDataSourceImpl(requestPerformer: sl()));
    }

    if (!sl.isRegistered<TodoLocalDataSource>()) {
      sl.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSourceImpl());
    }

    // For BLoC, unregister if exists and register again (factory always creates new instance)
    if (sl.isRegistered<TodoBloc>()) {
      sl.unregister<TodoBloc>();
    }
    sl.registerFactory(() => TodoBloc(getTodosUC: sl(), deleteTodoUC: sl()));
  } catch (e) {
    print('Error in todo bindings: $e');
  }
}
