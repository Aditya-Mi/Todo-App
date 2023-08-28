import 'package:flutter/material.dart';
import 'package:todo/data/todo.dart';

class TodoTile extends StatelessWidget {
  final String task;
  final bool isCompleted;
  final Priority priority;
  final void Function(bool?)? onChanged;

  const TodoTile(
      {super.key,
      required this.task,
      required this.isCompleted,
      required this.priority,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: onChanged,
              activeColor: Colors.black,
              checkColor: Colors.white,
            ),
            Text(
              task,
              style: TextStyle(
                  fontSize: 18,
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
