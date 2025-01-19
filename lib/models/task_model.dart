import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime createdAt;

  @HiveField(2)
  bool isCompleted = false;

  TaskModel(
    this.title,
    this.createdAt,
    this.isCompleted,
  );
}
