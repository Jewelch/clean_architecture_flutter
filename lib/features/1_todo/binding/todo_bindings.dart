import '../../../main.dart';
import '../data/datasource/local/todo_local_datasource.dart';
import '../data/datasource/remote/todo_remote_datasource.dart';
import '../data/repositories/todo_repository_impl.dart';
import '../domain/repositories/todo_repository.dart';
import '../domain/usecases/get_todos_uc.dart';
import '../presentation/bloc/todo_bloc.dart';

void injectTodosBindings() {
  // Bloc
  sl.registerFactory(() => TodoBloc(getTodosUC: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTodosUC(sl()));

  // Repositories
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), connectivity: sl()),
  );

  // Data sources
  sl.registerLazySingleton<TodoRemoteDataSource>(() => TodoRemoteDataSourceImpl(requestPerformer: sl()));
  sl.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSourceImpl());
}
