import 'package:flutter/material.dart';
import 'package:salakhana_project/Controller/task_cont.dart';
import 'package:salakhana_project/Model/task.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {

  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final TaskController controller = TaskController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Add Task",style: TextStyle(color: Colors.white))),
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

                final task = Task(
                  title: taskController.text,
                  description: descriptionController.text.isEmpty 
                      ? null 
                      : descriptionController.text,
                );

                controller.addTask(task);

                Navigator.pop(context, true); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[300],
                minimumSize: Size(double.infinity, 70),
              ),
              child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 25)),
            ),
          )
        ],
      ),
    );
  }
}