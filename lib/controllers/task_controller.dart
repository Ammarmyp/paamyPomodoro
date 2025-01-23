import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paamy_pomodorro/models/task_model.dart';

class TaskController extends GetxController {
  final taskBox = Hive.box<TaskModel>('tasks');
  var tasks = <TaskModel>[].obs;

  void addTask(TaskModel taskItem) {
    taskBox.add(taskItem);
    tasks.add(taskItem);
  }

  void updateTask(TaskModel task) {
    final editableTask = taskBox.values.firstWhere(
      (t) => t.key == task.key,
    );

    editableTask.title = task.title;
    editableTask.description = task.description;
    editableTask.priority = task.priority;

    editableTask.save();

    tasks.refresh();
  }

  void deleteTask(TaskModel task) {
    task.delete();
    tasks.remove(task);
  }

  void toggleTaskCompletion(TaskModel task) {
    task.isCompleted = !task.isCompleted;
    task.save();
    tasks.refresh();
  }

  void loadTasks() {
    tasks.value = taskBox.values.toList().cast<TaskModel>();
  }

  @override
  void onInit() {
    super.onInit();
    // taskBox.clear();
    loadTasks();
  }
}
