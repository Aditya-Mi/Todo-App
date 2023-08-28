import 'package:flutter/material.dart';
import 'package:todo/data/todo.dart';
import 'package:todo/todo_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/boxes.dart';

void main() async {
  // hive init
  await Hive.initFlutter();
  // register adapter
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(PriorityAdapter());

  boxTodos = await Hive.openBox('todoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const TodoScreen(),
    );
  }
}
