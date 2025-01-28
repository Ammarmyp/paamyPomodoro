import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paamy_pomodorro/models/focus_session.dart';

class TimerController extends GetxController {
  var remainingTime = 1500.obs;
  var isRunning = false.obs;
  var focusTime = 25.obs;
  var sliderValue = 10.obs;
  var isPaused = false.obs;
  RxInt userGoal = 50.obs;
  int? startTime;

  Box? timerBox;
  final focusSessionBox = Hive.box<FocusSession>('focusSession');
  final dailyStatsBox = Hive.box<DailyStats>('dailyStats');
  final userGoalBox = Hive.box('userGoal');

  RxList<int> customSessions = <int>[].obs;
  RxList<FocusSession> focusSessions =
      <FocusSession>[].obs; // Reactive list of focus sessions
  var dailyStats = DailyStats(date: DateTime.now(), totalFocusMinutes: 0).obs;

  RxInt selectedSession = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    timerBox = await Hive.openBox('timerBox');

    loadTimerState();
  }

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
      isPaused.value = false;
      startTime = DateTime.now().millisecondsSinceEpoch;

      saveTimerState();

      ever(remainingTime, (_) {
        if (remainingTime.value <= 0) {
          stopTimer();
        }
      });

      updateTimer();
    }
  }

  void updateTimer() async {
    while (isRunning.value && remainingTime.value > 0) {
      await Future.delayed(const Duration(seconds: 1));
      remainingTime.value -= 1;
    }
    if (remainingTime.value == 0) {
      isRunning.value = false;
    }
  }

  void updateSlider(int minutes) {
    sliderValue.value = minutes;

    saveTimerState();
  }

  void pauseTimer() {
    if (isRunning.value) {
      isRunning.value = false;
      isPaused.value = true;
      saveTimerState();
    }
  }

  void stopTimer() {
    isRunning.value = false;
    isPaused.value = false;
    saveTimerState();
  }

  void resetTimer() {
    isRunning.value = false;
    remainingTime.value = focusTime.value * 60;
    saveTimerState();
  }

  void saveTimerState() {
    timerBox?.put("remainingTime", remainingTime.value);
    timerBox?.put("isRunning", isRunning.value);
    timerBox?.put("startTime", startTime);
    timerBox?.put("focusTime", focusTime.value);
    timerBox?.put("customSessions", customSessions.toList());
  }

  void loadTimerState() {
    remainingTime.value =
        timerBox?.get("remainingTime", defaultValue: 1500) ?? 1500;
    isRunning.value = timerBox?.get("isRunning", defaultValue: false) ?? false;
    startTime = timerBox?.get("startTime", defaultValue: null);
    focusTime.value = timerBox?.get("focusTime", defaultValue: 25) ?? 25;
    focusSessions.value = focusSessionBox.values.toList();

    //*sessions

    List<dynamic>? storedSessions =
        timerBox?.get("customSessions", defaultValue: [20, 30, 40]);

    if (storedSessions != null) {
      customSessions.assignAll(storedSessions.cast<int>());
    }

    if (isRunning.value) {
      int elapsedTime =
          DateTime.now().millisecondsSinceEpoch - (startTime ?? 0);
      int updatedTime = remainingTime.value - (elapsedTime ~/ 1000);

      remainingTime.value = updatedTime > 0 ? updatedTime : 0;
      if (remainingTime.value > 0) {
        startTimer();
      }
    }

    //* load today's stats
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final todayStats = dailyStatsBox.get(todayDate.toString());

    dailyStats.value =
        todayStats ?? DailyStats(date: todayDate, totalFocusMinutes: 0);

    //* user goals
    var goal = userGoalBox.get("dailyGoal", defaultValue: 40);
    userGoal.value = goal;
  }

  void setFocusTime(int minutes) {
    focusTime.value = minutes;
    remainingTime.value = minutes * 60;

    saveTimerState();
  }

  void saveFocusSession(DateTime startTime, int durationInMinutes) async {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    // Save session
    final session = FocusSession(
      startTime: startTime,
      durationInMinutes: durationInMinutes,
      date: todayDate,
    );

    await focusSessionBox.add(session);

    focusSessions.add(session);

    //* update daily stats

    if (dailyStats.value.date != todayDate) {
      dailyStats.value = DailyStats(date: todayDate, totalFocusMinutes: 0);
    }

    dailyStats.value.totalFocusMinutes += durationInMinutes;
    dailyStatsBox.put(todayDate.toString(), dailyStats.value);
  }

  void setDailyGoal(int minutes) {
    userGoalBox.put("dailyGoal", minutes);
    userGoal.value = minutes;
  }

  bool isGoalAchieved() {
    return dailyStats.value.totalFocusMinutes >= userGoal.value;
  }

  //* WEEKLY STATS

  List<DailyStats> getWeeklyStats() {
    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));

    return dailyStatsBox.values
        .where((stat) => stat.date.isAfter(startOfWeek))
        .toList();
  }

  void updateTimerForSession(int sessionIndex) {
    selectedSession.value = sessionIndex;
    int timeInSeconds = customSessions[sessionIndex] * 60;
    setFocusTime(timeInSeconds ~/ 60);
  }

  void addCustomSession(int minutes) {
    if (!customSessions.contains(minutes)) {
      customSessions.add(minutes);
      saveTimerState();
    }
  }

  void removeCustomSession(int index) {
    if (index >= 0 && index < customSessions.length) {
      customSessions.removeAt(index);
      timerBox?.put("customSessions", customSessions.toList());
    }
  }
}
