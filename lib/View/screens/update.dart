import 'package:flutter/material.dart';
import 'package:salakhana_project/Controller/task_cont.dart';
import 'package:salakhana_project/Model/task.dart';

class Update extends StatefulWidget {
  final bool isHabit;
  final Task task;
  final String userEmail;

  const Update({super.key,
  required this.isHabit,
  required this.task,
  required this.userEmail,
  });

  @override
  State<Update> createState() => _UpdateState();
}

// Error message when the user tries to update a task without a title
void showTitleError(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Missing Task", style: TextStyle(color: Colors.purple[400])),
        content: Text("You didn't enter the task title.", style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: TextStyle(color: Colors.purple[400])),
          ),
        ],
      );
    },
  );
}

class _UpdateState extends State<Update> {
  late TextEditingController taskController;
  late TextEditingController descriptionController;
  late TextEditingController deadlineController;

  final TaskController controller = TaskController();

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    deadlineController = TextEditingController(text: widget.task.deadline);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.isHabit ? "Add Habit" : "Add Task", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.purple[400],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: "Task",
                labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: deadlineController,
              decoration: InputDecoration(
                labelText: "Deadline",
                labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Cancel button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                SizedBox(width: 10),
                // Update button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (taskController.text.isEmpty) {
                        showTitleError(context);
                        return;
                      }

                      final updatedTask = Task(
                        title: taskController.text,
                        description: descriptionController.text.isEmpty
                            ? null
                            : descriptionController.text,
                        deadline: deadlineController.text.isEmpty
                            ? null
                            : deadlineController.text,
                        isDone: widget.task.isDone,
                        isHabit: widget.task.isHabit, 
                        lastCompletedDate: widget.task.lastCompletedDate,
                        userEmail: widget.userEmail, 
                      );

                      controller.updateTask(widget.task, updatedTask, widget.userEmail); //why still error here and what the importance of this line

                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[400],
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text("Update", style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}