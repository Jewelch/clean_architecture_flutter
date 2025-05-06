import 'package:flutter/material.dart';

import '../core/router/app_router.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => AppWidgetState();
}

class AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  static ValueNotifier<AppLifecycleState> appState = ValueNotifier(AppLifecycleState.resumed);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    appState.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState: $state');
    appState.value = state;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bloc vs Cubit Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple), useMaterial3: true),
      routerConfig: router,
    );
  }
}
