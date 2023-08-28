import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 2)
class Todo {
  @HiveField(0)
  String task;

  @HiveField(1, defaultValue: false)
  bool isCompleted;

  @HiveField(2)
  Priority priority;

  Todo({required this.task, required this.isCompleted, required this.priority});
}

const priorityString = <Priority, String>{
  Priority.low: 'Low',
  Priority.medium: 'Medium',
  Priority.high: 'High',
};

@HiveType(typeId: 3)
enum Priority {
  @HiveField(0)
  low,

  @HiveField(1)
  medium,

  @HiveField(2)
  high,
}
