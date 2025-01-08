import 'package:get/get.dart';

class TimerController extends GetxController {
  var remaingTime = 1500.obs;
  var isRunning = false.obs;

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
      updateTimer();
    }
  }

  void pauseTimer() {
    isRunning.value = false;
  }

  void resetTimer() {
    remaingTime.value = 1500;
    isRunning.value = false;
  }

  void updateTimer() async {
    while (isRunning.value && remaingTime.value > 0) {
      await Future.delayed(const Duration(seconds: 1));
      remaingTime.value--;
    }
    if (remaingTime.value == 0) {
      isRunning.value = false;
    }
  }
}
