import 'package:flutter/material.dart';
import 'package:salakhana_project/Controller/task_cont.dart';
import 'package:salakhana_project/Model/task.dart';

class Update extends StatefulWidget {

  final int index;
  final Task task;

  const Update({super.key, required this.index, required this.task});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {

  late TextEditingController taskController;
  late TextEditingController descriptionController;

  final TaskController controller = TaskController();

  @override
  void initState() {
    super.initState();

    taskController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Update Task",style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.purple[300],
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: taskController,
              decoration: InputDecoration(
                label: Text("Task",style: TextStyle(color: Colors.purple,fontSize: 25))
              ),
            ),
          ),

          SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                label: Text("Description",style: TextStyle(color: Colors.purple,fontSize: 25))
              ),
            ),
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {

                final updatedTask = Task(
                  title: taskController.text,
                  description: descriptionController.text.isEmpty 
                      ? null 
                      : descriptionController.text,
                  isDone: widget.task.isDone,
                );

                controller.updateTask(widget.index, updatedTask);

                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[300],
                minimumSize: Size(double.infinity, 70),
              ),
              child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 25)),
            ),
          )
        ],
      ),
    );
  }
}