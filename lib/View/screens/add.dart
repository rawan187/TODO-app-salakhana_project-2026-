import 'package:flutter/material.dart';
import 'package:salakhana_project/Controller/task_cont.dart';
import 'package:salakhana_project/Model/task.dart';

class Add extends StatefulWidget { //parameters for add screen
  final bool isHabit;
  final String userEmail;

  const Add({
    super.key,
    required this.isHabit,
    required this.userEmail,
  });

  @override
  State<Add> createState() => _AddState(); 
}

//error message when the user tries to add a task without a title
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

class _AddState extends State<Add> {

  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  final TaskController controller = TaskController();

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

          SizedBox(height: 20),

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

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: deadlineController,
              decoration: InputDecoration(
                labelText: "Deadline",
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
                      if (taskController.text.isEmpty) {
                        showTitleError(context);
                        return;
                      }
                  
                      final task = Task(
                        title: taskController.text,
                        description: descriptionController.text.isEmpty 
                          ? null 
                          : descriptionController.text,
                          
                        deadline: deadlineController.text.isEmpty
                          ? null
                          : deadlineController.text,
                            
                        isHabit: widget.isHabit, 
                        lastCompletedDate: null,
                        userEmail: widget.userEmail, // Pass userEmail to the Task model
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
          ),
        ],
      ),
    );
  }
}