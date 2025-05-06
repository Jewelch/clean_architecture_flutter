import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/1_todo/binding/todo_bindings.dart';
import '../features/1_todo/presentation/bloc/todo_bloc.dart';
import '../features/1_todo/presentation/screens/todo_screen.dart';
import '../features/2_product_details/binding/product_bindings.dart';
import '../features/2_product_details/presentation/bloc/product_bloc.dart';
import '../features/2_product_details/presentation/screens/product_details_screen.dart';
import '../main.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => AppWidgetState();
}

class AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  static ValueNotifier<AppLifecycleState> appState = ValueNotifier(AppLifecycleState.resumed);
  int _currentIndex = 0;

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
    home: Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          //! Todo Screen
          BlocProvider<TodoBloc>(
            create: (_) {
              injectTodosBindings();
              return sl<TodoBloc>();
            },
            child: const TodoScreen(),
          ),

          //= Product Details Screen
          BlocProvider<ProductBloc>(
            create: (_) {
              injectProductBindings();
              return sl<ProductBloc>();
            },
            child: const ProductDetailsScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'Todos'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Product'),
        ],
      ),
    ),
  );
}
