import 'package:jch_requester/generic_requester.dart';

class TodosListModel extends ModelingProtocol {
  final List<TodoModel>? todos;

  TodosListModel({this.todos});

  @override
  fromJson(json) => TodosListModel(todos: (json['todos'] as List).map((e) => TodoModel.fromJson(e)).toList());

  toJson() => {'todos': todos?.map((e) => e.toJson()).toList()};

  @override
  List<Object?> get props => [todos];
}

class TodoModel {
  final int? id;
  final String? title;
  final bool? isCompleted;
  final int? userId;

  TodoModel({this.id, this.title, this.isCompleted, this.userId});

  factory TodoModel.fromJson(json) => TodoModel(
    id: json['id'] as int?,
    title: json['todo'] as String?,
    isCompleted: json['completed'] as bool?,
    userId: json['userId'] as int?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'isCompleted': isCompleted, 'userId': userId};
}
