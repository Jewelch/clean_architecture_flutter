import 'package:equatable/equatable.dart';

import '../../data/models/todo_model.dart';

class TodoEntity extends Equatable {
  final int id;
  final String title;
  final bool isCompleted;

  const TodoEntity({required this.id, required this.title, this.isCompleted = false});

  factory TodoEntity.fromModel(TodoModel model) {
    return TodoEntity(id: model.id ?? 0, title: model.title ?? '', isCompleted: model.isCompleted ?? false);
  }

  TodoEntity copyWith({int? id, String? title, bool? isCompleted}) {
    return TodoEntity(id: id ?? this.id, title: title ?? this.title, isCompleted: isCompleted ?? this.isCompleted);
  }

  @override
  List<Object?> get props => [id, title, isCompleted];
}
