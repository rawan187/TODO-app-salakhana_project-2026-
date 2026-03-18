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
                      backgroundColor: Colors.purple[400],
                      minimumSize: Size(double.infinity, 60),
                    ),
                    child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 20)),
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