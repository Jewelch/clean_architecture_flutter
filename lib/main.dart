import 'package:flutter/material.dart';
import 'package:jch_requester/generic_requester.dart';

import 'app/app_widget.dart';
import 'app/environment/app_environments.dart';
import 'core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await di.init();

  // Styling
  //
  // Binding (Dependencies injection)

  await configureRequester();

  runApp(const MyApp());
}

Future<void> configureRequester() async => RequestPerformer.configure(
  BaseOptions(baseUrl: AppEnvironments.baseUrl),
  debugginActivated: true,
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
