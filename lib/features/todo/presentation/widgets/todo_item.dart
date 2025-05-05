import 'package:flutter/material.dart';

import '../../domain/entities/todo_entity.dart';

class TodoItem extends StatelessWidget {
  final TodoEntity todo;
  final Function(int) onToggleCompletion;
  final Function(int) onDelete;

  const TodoItem({super.key, required this.todo, required this.onToggleCompletion, required this.onDelete});

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(todo.title, style: TextStyle(decoration: todo.isCompleted ? TextDecoration.lineThrough : null)),
    leading: Checkbox(value: todo.isCompleted, onChanged: (_) => onToggleCompletion(todo.id)),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 8),
        IconButton(icon: const Icon(Icons.delete), onPressed: () => onDelete(todo.id)),
      ],
    ),
  );
}
