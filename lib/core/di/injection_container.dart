import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:jch_requester/generic_requester.dart';

import '../../features/todo/data/datasource/local/todo_local_datasource.dart';
import '../../features/todo/data/datasource/remote/todo_remote_datasource.dart';
import '../../features/todo/data/repositories/todo_repository_impl.dart';
import '../../features/todo/domain/repositories/todo_repository.dart';
import '../../features/todo/domain/usecases/get_todos_uc.dart';
import '../../features/todo/presentation/bloc/todo_bloc.dart';
import '../managers/connectivity_manager.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Managers
  sl.registerLazySingleton(() => RequestPerformer());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<ConnecetivityManager>(() => ConnecetivityManager(connectivity: sl()));

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
