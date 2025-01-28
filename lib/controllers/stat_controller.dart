import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:paamy_pomodorro/models/focus_session.dart';

class StatController extends GetxController {
  var focusSessions = <FocusSession>[].obs; // Reactive list of focus sessions
  var dailyStats = DailyStats(date: DateTime.now(), totalFocusMinutes: 0).obs;
  var userGoal = UserGoal(dailyGoalMinutes: 60).obs; // Default goal: 60 mins

  final focusSessionBox = Hive.box<FocusSession>('focusSession');
  final dailyStatsBox = Hive.box<DailyStats>('dailyStats');
  final userGoalBox = Hive.box<UserGoal>('userGoal');

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    // Load existing focus sessions
    focusSessions.value = focusSessionBox.values.toList();

    // Load today's stats
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final todayStats = dailyStatsBox.get(todayDate.toString());

    dailyStats.value =
        todayStats ?? DailyStats(date: todayDate, totalFocusMinutes: 0);

    // Load user goal
    userGoal.value =
        userGoalBox.get('dailyGoal') ?? UserGoal(dailyGoalMinutes: 60);
  }

  void saveFocusSession(DateTime startTime, int durationInMinutes) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    // Save session
    final session = FocusSession(
      startTime: startTime,
      durationInMinutes: durationInMinutes,
      date: todayDate,
    );
    focusSessionBox.add(session);
    focusSessions.add(session);

    // Update daily stats
    if (dailyStats.value.date != todayDate) {
      dailyStats.value = DailyStats(date: todayDate, totalFocusMinutes: 0);
    }
    dailyStats.value.totalFocusMinutes += durationInMinutes;
    dailyStatsBox.put(todayDate.toString(), dailyStats.value);

    update(); // Update UI
  }

  void setDailyGoal(int minutes) {
    final goal = UserGoal(dailyGoalMinutes: minutes);
    userGoalBox.put('dailyGoal', goal);
    userGoal.value = goal;

    update(); // Update UI
  }

  bool isGoalAchieved() {
    return dailyStats.value.totalFocusMinutes >=
        userGoal.value.dailyGoalMinutes;
  }

  List<DailyStats> getWeeklyStats() {
    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));

    return dailyStatsBox.values
        .where((stat) => stat.date.isAfter(startOfWeek))
        .toList();
  }
}
