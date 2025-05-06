part of 'main.dart';

final GetIt sl = GetIt.instance;

abstract class _Binding {
  static Future<void> all() async => asynchronous().then(synchronous);

  static Future<void> asynchronous() async {}

  static void synchronous([_]) {
    sl.registerLazySingleton(() => RequestPerformer());
    sl.registerLazySingleton(() => Connectivity());
    sl.registerLazySingleton<ConnecetivityManager>(() => ConnecetivityManager(connectivity: sl()));
  }
}
