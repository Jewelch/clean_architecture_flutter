import 'package:flutter/material.dart';

import '../../domain/entities/todo_entity.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoEntity> todos;
  final Function(int) onToggleCompletion;
  final Function(int) onDelete;

  const TodoList({super.key, required this.todos, required this.onToggleCompletion, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(todo: todo, onToggleCompletion: onToggleCompletion, onDelete: onDelete);
      },
    );
  }
}
