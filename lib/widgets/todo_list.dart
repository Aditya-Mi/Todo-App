import 'package:flutter/material.dart';
import 'package:todo/widgets/todo_tile.dart';

class TodoList extends StatelessWidget {
  final List<dynamic> todoList;
  final Function(String id) deleteTask;
  final Function(bool? value, String id) onChanged;
  const TodoList(
      {super.key,
      required this.todoList,
      required this.deleteTask,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // itemCount: boxTodos.values.length,
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        final todo = todoList[index];
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            deleteTask(todo.id);
          },
          child: TodoTile(
              task: todo.task,
              isCompleted: todo.isCompleted,
              priority: todo.priority,
              onChanged: (value) => onChanged(value, todo.id)),
        );
      },
    );
  }
}
