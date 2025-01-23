import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paamy_pomodorro/components/priority_tag.dart';
import 'package:paamy_pomodorro/controllers/task_controller.dart';
import 'package:paamy_pomodorro/models/task_model.dart';
import 'package:paamy_pomodorro/utils/priority_colors.dart';
import 'package:paamy_pomodorro/utils/theme.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  TaskCard({super.key, required this.task});
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              taskController.deleteTask(task);
            },
            icon: LucideIcons.trash2,
            backgroundColor: AppTheme.brightRed.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          SlidableAction(
            onPressed: (context) {
              final titleController = TextEditingController();
              final tagsController = TextEditingController();
              final descriptionController = TextEditingController();
              final List<String> items = ["low", "medium", "high"];

              showDialog(
                  context: context,
                  builder: (context) {
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
                              Get.snackbar(
                                  "Error", "Task title cannot be empty");
                              return;
                            }
                            var task = TaskModel(
                              titleController.text.trim(),
                              DateTime.now(),
                              false,
                              tagsController.text.trim(),
                              descriptionController.text.trim(),
                            );
                            taskController.updateTask(task);
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
                  });
            },
            icon: LucideIcons.edit,
            backgroundColor: AppTheme.lightBlue.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              getPriorityColor(task.priority, context),
            ],
            stops: const [0.6, 1.0],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedScale(
                    scale: task.isCompleted ? 1.4 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        taskController.toggleTaskCompletion(task);
                      },
                      checkColor: Theme.of(context).colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 200,
                        ),
                        child: Text(
                          task.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 200,
                        ),
                        child: Text(
                          task.description ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.9),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PriorityTag(priority: task.priority)
          ],
        ),
      ),
    );
  }
}
