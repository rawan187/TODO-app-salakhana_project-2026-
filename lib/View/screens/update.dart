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
                
                // Add circular black border
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // circular radius
                  borderSide: BorderSide(color: Colors.black, width: 2), // black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // keep same radius
                  borderSide: BorderSide(color: Colors.black, width: 2), // black border
                ),
              ),
            ),
          ),

          SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.black, fontSize: 25),
                
                // Add circular black border
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // circular radius
                  borderSide: BorderSide(color: Colors.black, width: 2), // black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // keep same radius
                  borderSide: BorderSide(color: Colors.black, width: 2), // black border
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
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                  
                      final updatedTask = Task(
                        title: taskController.text,
                        description: descriptionController.text.isEmpty 
                            ? null 
                            : descriptionController.text,
                      );
                  
                      controller.updateTask(widget.index, updatedTask);
                  
                      Navigator.pop(context, true); 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[400],
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 20)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}