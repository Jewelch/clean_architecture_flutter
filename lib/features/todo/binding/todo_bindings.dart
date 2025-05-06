import 'package:bloc_vs_cubit/main.dart';

import '../../../features/todo/data/datasource/local/todo_local_datasource.dart';
import '../../../features/todo/data/datasource/remote/todo_remote_datasource.dart';
import '../../../features/todo/data/repositories/todo_repository_impl.dart';
import '../../../features/todo/domain/repositories/todo_repository.dart';
import '../../../features/todo/domain/usecases/get_todos_uc.dart';
import '../../../features/todo/presentation/bloc/todo_bloc.dart';

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
