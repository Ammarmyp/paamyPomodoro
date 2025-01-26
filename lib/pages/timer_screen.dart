import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paamy_pomodorro/controllers/timer_controller.dart';
import 'package:paamy_pomodorro/utils/format_time.dart';

class TimerScreen extends StatelessWidget {
  TimerScreen({super.key});

  final TimerController timerController = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatTime(timerController.remainingTime.value),
          ),

          //controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: timerController.stopTimer,
                child: Text("Cancel"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: timerController.isPaused.value
                    ? timerController.startTimer
                    : timerController.pauseTimer,
                child:
                    Text(timerController.isRunning.value ? "Pause" : "Resume"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
