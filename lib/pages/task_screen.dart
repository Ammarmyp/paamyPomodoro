import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/models/task_model.dart';
import '../controllers/task_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(formatDate(task.createdAt)),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  taskController.toggleTaskCompletion(task);
                },
              ),
              onLongPress: () => taskController.deleteTask(task),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final titleController = TextEditingController();
              return AlertDialog(
                title: const Text("Add Task"),
                content: TextField(
                  controller: titleController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      var task = TaskModel(
                          titleController.text, DateTime.now(), false);
                      taskController.addTask(task);
                      Get.back();
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    // Convert to local time zone
    DateTime localDate = dateTime.toLocal();

    // Format date components using built-in methods
    String weekday = localDate.weekday.toString();
    String day = localDate.day.toString().padLeft(2, '0');
    String month = localDate.month.toString().padLeft(2, '0');
    String year = localDate.year.toString();
    String hour = localDate.hour.toString().padLeft(2, '0');
    String minute = localDate.minute.toString().padLeft(2, '0');

    // Return a human-readable format: "YYYY-MM-DD HH:MM"
    return '$year-$month-$day $hour:$minute';
  }
}
