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
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        onTap: widget.onTap,

        title: Text(
          widget.task.title,
          style: TextStyle(
            fontSize: 20,
            decoration:
                widget.task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),

        subtitle: Text(
          widget.task.description ?? "",
          style: TextStyle(fontSize: 16),
        ),

        leading: Checkbox(
          value: widget.task.isDone,
          onChanged: (_) => widget.onToggle(),
        ),

        trailing: MouseRegion(
          onEnter: (_) => setState((() => isHoveringDelete = true)),
          onExit: (_) => setState((() => isHoveringDelete = false)),

          child: IconButton(
            onPressed: widget.onDelete,
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