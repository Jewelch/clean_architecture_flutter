import 'package:bloc_vs_cubit/common/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/app_widget.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../widgets/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(const LoadTodosEvent());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List - Bloc'), backgroundColor: Colors.green),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return switch (state) {
            TodoInitialState() => const Center(child: Text('Initializing...')),
            TodoLoadingState() => const Center(child: CircularProgressIndicator()),
            TodoErrorState(errorMessage: final message) => Center(child: Text('Error: $message')),
            TodoLoadedState(todos: final todos) =>
              todos.isEmpty
                  ? const Center(child: Text('No todos yet!'))
                  : TodoList(
                    todos: todos,
                    onToggleCompletion: (id) {
                      context.read<TodoBloc>().add(ToggleTodoEvent(id));
                    },

                    onDelete: (id) {
                      context.read<TodoBloc>().add(DeleteTodoEvent(id));
                    },
                  ),
          };
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ValueListenableBuilder(valueListenable: AppWidgetState.appState, builder: (_, value, __) => Text('${value}')),
          HorizontalSpacing(40),
          FloatingActionButton(onPressed: _showAddTodoDialog, tooltip: 'Add Todo', child: const Icon(Icons.add)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Future<void> _showAddTodoDialog() async {
    _textController.clear();
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: 'Enter todo title'),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const VerticalSpacing(10),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  context.read<TodoBloc>().add(AddTodoEvent(_textController.text));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
