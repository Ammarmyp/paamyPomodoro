import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paamy_pomodorro/components/task_card.dart';
import 'package:paamy_pomodorro/components/theme_toggler.dart';
import 'package:paamy_pomodorro/models/task_model.dart';

import '../controllers/task_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text(
            "Tasks",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          actions: [
            ThemeToggler(),
            const SizedBox(width: 10),
            IconButton(
              icon: Icon(
                LucideIcons.settings,
                size: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                // Navigate to the settings screen
                // Get.to(() =>  TaskScreen());
              },
            ),
          ],
        ),
        body: Obx(() {
          return taskController.tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/notask.png",
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Don't procrastinate, go ahead and add a task",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          LucideIcons.arrowLeft,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "swipe for actions",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: const EdgeInsets.all(16.0),
                        itemCount: taskController.tasks.length,
                        itemBuilder: (context, index) {
                          final task = taskController.tasks[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TaskCard(task: task),
                          );
                        },
                      ),
                    ),
                  ],
                );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final titleController = TextEditingController();
                final tagsController = TextEditingController();
                final descriptionController = TextEditingController();
                final List<String> items = ["low", "medium", "high"];
                return AlertDialog(
                  title: const Text("Add Task"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: "Enter task title",
                        ),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: "Enter task description here",
                        ),
                      ),
                      DropdownButton<String>(
                        hint: const Text("Select priority"),
                        items: items.map((item) {
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                        onChanged: (value) {
                          tagsController.text = value!;
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (titleController.text.trim().isEmpty) {
                          Get.snackbar("Error", "Task title cannot be empty");
                          return;
                        }
                        var task = TaskModel(
                          titleController.text.trim(),
                          DateTime.now(),
                          false,
                          tagsController.text.trim(),
                          descriptionController.text.trim(),
                        );
                        taskController.addTask(task);
                        Get.back();
                      },
                      child: const Text("Add"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                );
              },
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.add),
        ),
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
