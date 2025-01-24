import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';

class FocusScreen extends StatelessWidget {
  FocusScreen({super.key});

  final TimerController timerController = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pomodoro Timer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer Display
            Obx(() => Text(
                  formatTime(timerController.remainingTime.value),
                  style: TextStyle(fontSize: 48),
                )),
            SizedBox(height: 20),

            // Focus Time Slider
            Text("Set Focus Time (minutes):"),
            Obx(() => Slider(
                  value: timerController.focusTime.value.toDouble(),
                  min: 5,
                  max: 60,
                  divisions: 11,
                  label: "${timerController.focusTime.value} min",
                  onChanged: (value) {
                    timerController.setFocusTime(value.toInt());
                  },
                )),
            SizedBox(height: 20),

            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => ElevatedButton(
                    onPressed: timerController.isRunning.value
                        ? null
                        : timerController.startTimer,
                    child: Text("Start"),
                  ),
                ),
                SizedBox(width: 10),
                Obx(
                  () => ElevatedButton(
                    onPressed: !timerController.isRunning.value
                        ? null
                        : timerController.pauseTimer,
                    child: Text("Pause"),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: timerController.resetTimer,
                  child: Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, "0");
    final secs = (seconds % 60).toString().padLeft(2, "0");
    return "$minutes:$secs";
  }
}
