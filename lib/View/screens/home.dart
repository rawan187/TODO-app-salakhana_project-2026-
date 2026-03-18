import 'package:flutter/material.dart';
import 'package:salakhana_project/Controller/task_cont.dart';
import 'package:salakhana_project/Model/task.dart';
import 'package:salakhana_project/View/screens/add.dart';
import 'package:salakhana_project/View/screens/update.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TaskController controller = TaskController();

  @override
  void initState() {
    super.initState();
    controller.loadData(); // Load tasks on page open
  }

  void refresh() {
    setState(() {
      controller.loadData(); // Refresh UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Tasks", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.purple[300],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[300],
        onPressed: () async {
          // Navigate to Add task screen
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Add()),
          );

          if (result == true) {
            refresh(); // Refresh after returning
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: controller.todolist.isEmpty
          ? Center(child: Text("No Tasks Yet But You Can Start Now"))
          : ListView.builder(
              itemCount: controller.todolist.length,
              itemBuilder: (context, index) {
                final Task task = controller.todolist[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () async {
                      // Navigate to Update task screen
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Update(
                            index: index,
                            task: task, //error here
                          ),
                        ),
                      );
                      if (result == true) {
                        refresh(); // Refresh after update
                      }
                    },
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 20,
                        decoration: task.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text(
                      task.description ?? "",
                      style: TextStyle(fontSize: 16),
                    ),
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: (_) {
                        controller.toggleTask(index); // Toggle completion
                        refresh();
                      },
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        controller.deleteTask(index); // Delete task
                        refresh();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
    );
  }
}