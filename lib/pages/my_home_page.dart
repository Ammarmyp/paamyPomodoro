import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paamy_pomodorro/components/task_card.dart';
import 'package:paamy_pomodorro/components/theme_toggler.dart';
import 'package:paamy_pomodorro/controllers/task_controller.dart';
import 'package:paamy_pomodorro/controllers/theme_controller.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';
import 'package:paamy_pomodorro/models/task_model.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final ThemeController themeController = Get.find<ThemeController>();
  final TimerController timerController = Get.find<TimerController>();
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
            IconButton(
              icon: Icon(
                LucideIcons.settings,
                size: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                // Navigate to the settings screen
                // Get.to(() => TaskScreen());
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
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskController.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TaskCard(task: task),
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
                    decoration: const InputDecoration(
                      hintText: "Enter task title",
                    ),
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
}
