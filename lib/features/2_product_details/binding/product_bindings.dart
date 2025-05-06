import '../../../main.dart';
import '../data/datasource/local/product_local_datasource.dart';
import '../data/datasource/remote/product_remote_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/get_product_uc.dart';
import '../presentation/bloc/product_bloc.dart';

void injectProductBindings() {
  try {
    // For singletons, use registerLazySingleton or check if already registered
    if (!sl.isRegistered<GetProductUC>()) {
      sl.registerLazySingleton(() => GetProductUC(sl()));
    }

    if (!sl.isRegistered<ProductRepository>()) {
      sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), connectivity: sl()),
      );
    }

    if (!sl.isRegistered<ProductRemoteDataSource>()) {
      sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(requestPerformer: sl()));
    }

    if (!sl.isRegistered<ProductLocalDataSource>()) {
      sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImpl());
    }

    // For BLoC, unregister if exists and register again (factory always creates new instance)
    if (sl.isRegistered<ProductBloc>()) {
      sl.unregister<ProductBloc>();
    }
    sl.registerFactory(() => ProductBloc(getProductUC: sl()));
  } catch (e) {
    print('Error in product bindings: $e');
  }
}
