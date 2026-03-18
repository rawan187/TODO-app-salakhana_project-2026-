import 'package:hive/hive.dart';
import 'package:salakhana_project/Model/task.dart';

class TaskController {
  // Access the box after it has been opened in main
  Box<Task> get box => Hive.box<Task>('taskBox');

  List<Task> todolist = [];

  // Load all tasks from Hive
  void loadData() {
    todolist = box.values.toList();
  }

  // Add a new task
  void addTask(Task task) {
    box.add(task);
    loadData();
  }

  // Update an existing task at index
  void updateTask(int index, Task task) {
    box.putAt(index, task);
    loadData();
  }

  // Delete a task at index
  void deleteTask(int index) {
    box.deleteAt(index);
    loadData();
  }

  // Toggle task completion status
  void toggleTask(int index) {
    final task = box.getAt(index)!;
    task.isDone = !task.isDone;
    box.putAt(index, task);
    loadData();
  }
}