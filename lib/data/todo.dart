import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@HiveType(typeId: 2)
class Todo {
  @HiveField(0)
  String id;

  @HiveField(1)
  String task;

  @HiveField(2, defaultValue: false)
  bool isCompleted;

  @HiveField(3)
  Priority priority;

  Todo(
      {String? id,
      required this.task,
      required this.isCompleted,
      required this.priority})
      : id = id ?? const Uuid().v4();
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
