import 'package:hive/hive.dart';

part 'todo_model.g.dart'; // This will be generated

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  late final int limit;

  @HiveField(1)
  late final int total;

  @HiveField(2)
  late final List<Todos> todos;

  TodoModel({
    required this.todos,
   required this.limit ,
    required this.total ,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'] ?? 0;
    total = json['total'] ?? 0;
    todos = List.from(json['todos'] ?? []).map((e) => Todos.fromJson(e)).toList();
  }
}

@HiveType(typeId: 1)
class Todos {
  @HiveField(0)
  late final int id;

  @HiveField(1)
  late final String todo;

  @HiveField(2)
  late final bool completed;

  @HiveField(3)
  late final int userId;

  Todos({
    required this.id,
    required this.todo,
   required this.completed ,
    required this.userId ,
  });

  Todos.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    todo = json['todo'] ?? '';
    completed = json['completed'] ?? false;
    userId = json['userId'] ?? 0;
  }
}
