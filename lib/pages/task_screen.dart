import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              final textController = TextEditingController();
              return AlertDialog(
                title: const Text("Add Task"),
                content: TextField(controller: textController),
                actions: [
                  TextButton(
                    onPressed: () {
                      taskController.addTask(textController.text);
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
}
