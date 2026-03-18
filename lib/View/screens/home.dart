import 'package:flutter/material.dart';
import 'package:salakhana_project/Controller/task_cont.dart';
import 'package:salakhana_project/Model/task.dart';
import 'package:salakhana_project/View/screens/add.dart';
import 'package:salakhana_project/View/screens/update.dart';
import 'package:salakhana_project/View/widgets/task_tile.dart'; 

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
    controller.loadData();
  }

  void refresh() {
    setState(() {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Your Tasks", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.purple[400],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[400],
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Add()),
          );

          if (result == true) {
            refresh();
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),

      body: controller.todolist.isEmpty
          ? Center(child: Text("No Tasks Yet But You Can Start Now ✨"))
          : ListView.builder(
              itemCount: controller.todolist.length,
              itemBuilder: (context, index) {

                final Task task = controller.todolist[index];

                return TaskTile(
                  task: task,

                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Update(
                          index: index,
                          task: task, 
                        ),
                      ),
                    );

                    if (result == true) {
                      refresh();
                    }
                  },

                  onToggle: () {
                    controller.toggleTask(index);
                    refresh();
                  },

                  onDelete: () {
                    controller.deleteTask(index);
                    refresh();
                  },
                );
              },
            ),
    );
  }
}