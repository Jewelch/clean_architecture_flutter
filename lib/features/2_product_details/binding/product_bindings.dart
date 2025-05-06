import '../../../main.dart';
import '../data/datasource/local/product_local_datasource.dart';
import '../data/datasource/remote/product_remote_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/get_product_uc.dart';
import '../presentation/bloc/product_bloc.dart';

void injectProductBindings() {
  // Bloc
  sl.registerFactory(() => ProductBloc(getProductUC: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProductUC(sl()));

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), connectivity: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(requestPerformer: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImpl());
}
