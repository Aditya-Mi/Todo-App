import 'package:flutter/material.dart';
import 'package:todo/data/todo.dart';

class AddTodo extends StatefulWidget {
  final void Function(Todo todo) onSave;
  const AddTodo({
    super.key,
    required this.onSave,
  });

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _controller = TextEditingController();
  Priority _selectedPriority = Priority.low;

  void submitTodoData() {
    final task = _controller.text;
    if (task.isEmpty) {
      return;
    }
    widget.onSave(
        Todo(task: task, isCompleted: false, priority: _selectedPriority));
    Navigator.of(context, rootNavigator: true).pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedPriority,
                  items: Priority.values
                      .map(
                        (priority) => DropdownMenuItem(
                          value: priority,
                          child: Text(
                            priority.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: ((value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedPriority = value;
                    });
                  }),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: submitTodoData,
                  child: const Text('Save'),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
