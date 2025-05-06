part of 'main.dart';

Future<void> _configureRequester() async => RequestPerformer.configure(
  BaseOptions(baseUrl: AppEnvironments.baseUrl),
  debugginActivated: false,
  interceptor: QueuedInterceptorsWrapper(
    onRequest: (options, handler) async {
      return handler.next(options);
    },
    onResponse: (response, handler) {
      return handler.next(response);
    },
    onError: (error, handler) {
      Debugger.red(error.response?.data?["body"]?["message"]);
      return handler.next(error);
    },
  ),
);
