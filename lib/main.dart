import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:salakhana_project/Model/task.dart';
import 'package:salakhana_project/Model/task_adapter.dart';
import 'package:salakhana_project/View/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(TaskAdapter());

  // Open the box only once
  await Hive.openBox<Task>('taskBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const Test(), // Login screen
    );
  }
}