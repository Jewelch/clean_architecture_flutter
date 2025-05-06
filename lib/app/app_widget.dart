import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/todo/binding/todo_bindings.dart';
import '../features/todo/presentation/bloc/todo_bloc.dart';
import '../features/todo/presentation/screens/todo_screen.dart';
import '../main.dart';

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
  Widget build(BuildContext context) => MaterialApp(
    title: 'Bloc vs Cubit Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple), useMaterial3: true),
    home: BlocProvider<TodoBloc>(
      create: (_) {
        injectTodosBindings();
        return sl<TodoBloc>();
      },
      child: TodoScreen(),
    ),
  );
}
