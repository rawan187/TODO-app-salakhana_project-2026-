import 'package:flutter/material.dart';
import 'package:salakhana_project/Controller/task_cont.dart';
import 'package:salakhana_project/Model/task.dart';
import 'package:salakhana_project/View/screens/add.dart';
import 'package:salakhana_project/View/screens/update.dart';
import 'package:salakhana_project/View/widgets/task_tile.dart';

class Habits extends StatefulWidget {
  final String userEmail;

  const Habits({
    super.key,
    required this.userEmail,
  });

  @override
  State<Habits> createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {
  final TaskController controller = TaskController();

  @override
  void initState() {
    super.initState();
    controller.loadData(widget.userEmail);
    controller.resetHabits(); // reset all habit tasks daily
    refresh(); // refresh UI after reset
  }

  void refresh() {
    setState(() {
      controller.loadData(widget.userEmail); // reload tasks from Hive
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use getter to get only habit tasks
    final habitTasks = controller.habitTasks;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[400],
        onPressed: () async {
          // Pass isHabit = true since we are in Habits screen
          final result =
              await Navigator.push(context, MaterialPageRoute(builder: (_) => Add(isHabit: true, userEmail: widget.userEmail)));

          if (result == true) {
            refresh();
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),

      body: habitTasks.isEmpty
          ? Center(child: Text("No Habits Yet But You Can Start Now ✨"))
          : ListView.builder(
              itemCount: habitTasks.length,
              itemBuilder: (context, index) {
                final Task task = habitTasks[index];
               // final realIndex = controller.todolist.indexOf(task); // Get the actual index of the task in the full list
                // Get the real index in todolist to perform update/delete
                //////////final originalIndex = controller.todolist.indexOf(task);

                return TaskTile(
                  task: task,

                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        //error here???
                        builder: (_) => Update(
                          isHabit: true, // Pass isHabit = true since we are in Habits screen
                          task: task,
                          userEmail: widget.userEmail, // Pass userEmail to Update screen
                        ),
                      ),
                    );

                    if (result == true) {
                      refresh();
                    }
                  },

                  onToggle: () {
                    controller.toggleTask(task, widget.userEmail); // Pass userEmail to toggleTask
                    refresh();
                  },

                  onDelete: () {
                    controller.deleteTask(task, widget.userEmail); // Pass userEmail to deleteTask
                    refresh();
                  },
                );
              },
            ),
    );
  }
}