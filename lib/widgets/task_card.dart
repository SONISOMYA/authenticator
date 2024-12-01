import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  final String scheduledDate;
  final String taskId;
  final bool isCompleted;
  final VoidCallback onMarkAsDone;

  const TaskCard({
    super.key,
    required this.color,
    required this.headerText,
    required this.descriptionText,
    required this.scheduledDate,
    required this.taskId,
    required this.isCompleted,
    required this.onMarkAsDone,
    required Null Function() onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          headerText,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(descriptionText),
        trailing: IconButton(
          icon: Icon(
            isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.green,
          ),
          onPressed: onMarkAsDone, // Mark as done when clicked
        ),
      ),
    );
  }
}
