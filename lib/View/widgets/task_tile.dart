import 'package:flutter/material.dart';
import 'package:salakhana_project/Model/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
    required this.onTap,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isHoveringDelete = false;

void showDeleteConfirm(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Delete Task",
          style: TextStyle(color: Colors.purple[400]),
        ),
        content: Text(
          "Are you sure you want to delete this task?",
          style: TextStyle(color: Colors.black),
        ),

        actions: [
          // ❌ Cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog only
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          // ✔️ Delete button
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog first
              widget.onDelete(); // then delete task
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        onTap: widget.onTap,

        title: Text(
          widget.task.title,
          style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.bold,
            decoration:
                widget.task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),

        
        //ui fields
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (widget.task.description != null)
              Text(
                "📜 Description: ${widget.task.description!}",
                style: TextStyle(fontSize: 16),
              ),

            if (widget.task.deadline != null)
              Text(
                "📅 Deadline: ${widget.task.deadline!}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
          ],
        ),
        

        leading: Checkbox(
          value: widget.task.isDone,
          onChanged: (_) => widget.onToggle(),
        ),

        trailing: MouseRegion(
          onEnter: (_) => setState((() => isHoveringDelete = true)),
          onExit: (_) => setState((() => isHoveringDelete = false)),
          //update here
          child: IconButton(
            onPressed: () {
              showDeleteConfirm(context);
            },
            icon: Icon(
              Icons.delete,
              color: isHoveringDelete ? Colors.red : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}