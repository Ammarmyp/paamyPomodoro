import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  bool isCompleted = false;

  TaskModel({required this.title, this.isCompleted = false});
}
