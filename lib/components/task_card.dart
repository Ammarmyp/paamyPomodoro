import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/controllers/task_controller.dart';
import 'package:paamy_pomodorro/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  TaskCard({super.key, required this.task});
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      // subtitle: Text(formatDate(task.createdAt)),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          taskController.toggleTaskCompletion(task);
        },
      ),
      onLongPress: () => taskController.deleteTask(task),
    );
  }
}
