import 'package:hive/hive.dart';

part 'focus_session.g.dart';

@HiveType(typeId: 1)
class FocusSession {
  @HiveField(0)
  DateTime startTime;

  @HiveField(1)
  int durationInMinutes;

  @HiveField(2)
  DateTime date;

  FocusSession({
    required this.startTime,
    required this.durationInMinutes,
    required this.date,
  });
}

@HiveType(typeId: 2)
class DailyStats {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int totalFocusMinutes;

  DailyStats({
    required this.date,
    required this.totalFocusMinutes,
  });
}

@HiveType(typeId: 3)
class UserGoal {
  @HiveField(0)
  int dailyGoalMinutes;

  UserGoal({required this.dailyGoalMinutes});
}
