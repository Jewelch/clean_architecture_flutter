import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/1_todo/binding/todo_bindings.dart';
import '../../features/1_todo/presentation/bloc/todo_bloc.dart';
import '../../features/1_todo/presentation/screens/todo_screen.dart';
import '../../features/2_product_details/binding/product_bindings.dart';
import '../../features/2_product_details/presentation/bloc/product_bloc.dart';
import '../../features/2_product_details/presentation/screens/product_details_screen.dart';
import '../../main.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/todos',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/todos',
      name: 'todos',
      builder: (context, state) {
        return BlocProvider<TodoBloc>(
          create: (_) {
            injectTodosBindings();
            return sl<TodoBloc>();
          },
          child: const TodoScreen(),
        );
      },
    ),
    GoRoute(
      path: '/product/:id',
      name: 'product',
      builder: (context, state) {
        // Get the product ID from the route parameters
        final productId = state.pathParameters['id'] ?? '1';

        return BlocProvider<ProductBloc>(
          create: (_) {
            injectProductBindings();
            return sl<ProductBloc>();
          },
          child: ProductDetailsScreen(productId: int.parse(productId)),
        );
      },
    ),
  ],
);
