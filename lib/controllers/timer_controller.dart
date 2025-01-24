import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TimerController extends GetxController {
  var remainingTime = 1500.obs;
  var isRunning = false.obs;
  int? startTime;

  Box? timerBox;

  @override
  void onInit() async {
    super.onInit();
    timerBox = await Hive.openBox('timerBox');

    loadTimerState();
  }

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
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

  void pauseTimer() {
    if (isRunning.value) {
      isRunning.value = false;
      saveTimerState();
    }
  }

  void stopTimer() {
    isRunning.value = false;
    saveTimerState();
  }

  void resetTimer() {
    isRunning.value = false;
    remainingTime.value = 1500;
    saveTimerState();
  }

  void saveTimerState() {
    timerBox?.put("remainingTime", remainingTime.value);
    timerBox?.put("isRunning", isRunning.value);
    timerBox?.put("startTime", startTime);
  }

  void loadTimerState() {
    remainingTime.value =
        timerBox?.get("remainingTime", defaultValue: 1500) ?? 1500;
    isRunning.value = timerBox?.get("isRunning", defaultValue: false) ?? false;
    startTime = timerBox?.get("startTime", defaultValue: null);

    if (isRunning.value) {
      int elapsedTime =
          DateTime.now().millisecondsSinceEpoch - (startTime ?? 0);
      int updatedTime = remainingTime.value - (elapsedTime ~/ 1000);

      remainingTime.value = updatedTime > 0 ? updatedTime : 0;
      if (remainingTime.value > 0) {
        startTimer();
      }
    }
  }
}
