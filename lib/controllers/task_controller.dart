import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:paamy_pomodorro/models/task_model.dart';

class TaskController extends GetxController {
  final taskBox = Hive.box<TaskModel>('tasks');
  var tasks = <TaskModel>[].obs;

  void addTask(String title) {
    final task = TaskModel(title: title);
    taskBox.add(task);
    tasks.add(task);
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
    loadTasks();
  }
}
