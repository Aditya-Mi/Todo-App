import 'package:flutter/material.dart';
import 'package:todo/data/boxes.dart';
import 'package:todo/data/todo.dart';
import 'package:todo/widgets/add_todo.dart';
import 'package:todo/widgets/todo_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int length = 0;
  int noOfCompleted = 0;
  Iterable completedTodo = [];

  void onChanged(bool? value, int index) {
    setState(() {
      Todo todo = boxTodos.getAt(index);
      todo.isCompleted = !todo.isCompleted;
      boxTodos.putAt(index, todo);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void saveNewTask(Todo todo) {
    setState(() {
      boxTodos.put(
          "key_${todo.task}",
          Todo(
              task: todo.task,
              isCompleted: todo.isCompleted,
              priority: todo.priority));
    });
  }

  void deleteTask(int index) {
    setState(() {
      boxTodos.deleteAt(index);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    length = boxTodos.values.length;
    completedTodo = boxTodos.values.where((todo) => todo.isCompleted == true);
    noOfCompleted = completedTodo.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[400],
        elevation: 0,
        title: const Text('Todo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return AddTodo(
              onSave: saveNewTask,
            );
          }));
        },
        child: const Icon(Icons.add),
      ),
      body: boxTodos.values.isEmpty
          ? const Center(
              child: Text('No todo'),
            )
          : SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    '$noOfCompleted out of $length completed',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: boxTodos.values.length,
                    itemBuilder: (context, index) {
                      Todo todo = boxTodos.getAt(index);
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          deleteTask(index);
                        },
                        child: TodoTile(
                            task: todo.task,
                            isCompleted: todo.isCompleted,
                            priority: todo.priority,
                            onChanged: (value) => onChanged(value, index)),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
