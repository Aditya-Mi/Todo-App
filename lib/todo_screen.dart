import 'package:flutter/material.dart';
import 'package:todo/data/boxes.dart';
import 'package:todo/data/todo.dart';
import 'package:todo/widgets/add_todo.dart';
import 'package:todo/widgets/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<dynamic> highTodo = [];
  List<dynamic> mediumTodo = [];
  List<dynamic> lowTodo = [];

  int totalLength = 0;
  int noOfCompleted = 0;
  Iterable completedTodo = [];

  void onChanged(bool? value, String id) async {
    final Todo? todo = await boxTodos.get(id);

    if (todo != null) {
      setState(() {
        todo.isCompleted = !todo.isCompleted;
        boxTodos.put(id, todo);
        completedTodo =
            boxTodos.values.where((todo) => todo.isCompleted == true);
        noOfCompleted = completedTodo.length;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    getHighPriority();
    getMediumPriority();
    getLowPriority();
    totalLength = boxTodos.values.length;
    completedTodo = boxTodos.values.where((todo) => todo.isCompleted == true);
    noOfCompleted = completedTodo.length;
  }

  void saveNewTask(Todo todo) {
    setState(() {
      final Todo localTodo = Todo(
          task: todo.task,
          isCompleted: todo.isCompleted,
          priority: todo.priority);
      boxTodos.put(localTodo.id, localTodo);
      loadData();
    });
  }

  void deleteTask(String id) {
    setState(() {
      boxTodos.delete(id);
      loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getHighPriority() {
    highTodo = boxTodos.values
        .where((todo) => todo.priority == Priority.high)
        .toList();
  }

  void getMediumPriority() {
    mediumTodo = boxTodos.values
        .where((todo) => todo.priority == Priority.medium)
        .toList();
  }

  void getLowPriority() {
    lowTodo =
        boxTodos.values.where((todo) => todo.priority == Priority.low).toList();
  }

  @override
  Widget build(BuildContext context) {
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
                    '$noOfCompleted out of $totalLength completed',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(),
                  const PriorityText(text: "High Priority"),
                  const SizedBox(height: 4.0),
                  TodoList(
                      todoList: highTodo,
                      deleteTask: deleteTask,
                      onChanged: onChanged),
                  const SizedBox(
                    height: 16,
                  ),
                  const PriorityText(text: "Medium Priority"),
                  const SizedBox(height: 8.0),
                  TodoList(
                      todoList: mediumTodo,
                      deleteTask: deleteTask,
                      onChanged: onChanged),
                  const SizedBox(
                    height: 16,
                  ),
                  const PriorityText(text: "Low Priority"),
                  const SizedBox(height: 8.0),
                  TodoList(
                      todoList: lowTodo,
                      deleteTask: deleteTask,
                      onChanged: onChanged),
                ],
              ),
            ),
    );
  }
}

class PriorityText extends StatelessWidget {
  final String text;
  const PriorityText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
