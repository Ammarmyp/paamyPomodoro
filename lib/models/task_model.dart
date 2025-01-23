import 'package:hive/hive.dart';

part 'task_model.g.dart';

enum Priority { high, medium, low }

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  final DateTime createdAt;

  @HiveField(2)
  bool isCompleted = false;
  @HiveField(3)
  late String priority;
  @HiveField(4)
  String? description;

  TaskModel(this.title, this.createdAt, this.isCompleted, this.priority,
      [this.description = '']);
}
